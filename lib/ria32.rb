class Ria32
  def initialize
    @const = {}
    @local = {}
    @label = nil
    @instructions = {}
    @register = Hash.new(10)
    @register['%esp'] = @register['%ebp'] = 100
    @register['%eflags'] = Hash.new(0)
    @memory = Hash.new(0)
  end

  def commendouting(sourcecode)
    sourcecode.map do |line|
      state = nil
      line.each_char.map {|c|
        case c
        when '"'
          state = (state == nil ? :str : nil)
          c
        when ';'
          if state == :str
            c
          else
            next
          end
        else
          c
        end
      }.join('')
    end
  end

  def tokenize(sourcecode)
    sourcecode.each do |line|
      direc, mne = line.strip.split(/\s+/, 2)
      case direc
      when '.file'
      when '.section'
      when '.string'
        @const[@label] = mne
      when /(.*):$/
        @label = $1
      when '.text'
      when '.globl'
      when '.type'
      when '.size'
      when '.local'
        @local[mne] = nil
      when '.comm'
      when '.long'
        @local[@label] = mne.to_i
      when /\w+/
        @instructions[@label] ||= []
        @instructions[@label] << [direc.to_sym, mne]
      else
        p :noimp
      end
    end
  end

  def value(str)
    case str
    when /^\$(.*)/ # $8
      $1.sub('$', '').to_i
    else # %ebp
      @register[str]
    end
  end

  def value2(left)
    case left
    when /^\$(\..+)/ # $.LC01
      @const[$1]
    when /^(\-?\d*)\((.*?)\)/ # -16(%ebp)
      @memory[@register[$2] + $1.to_i]
    when /^\w+$/ # c
      @local[left]
    else # $8 or %ebp
      value left
    end
  end

  def address(left)
    case left
    #when /^\$(\..+)/ # $.LC01
    #  left = @const[$1]
    when /^(\-?\d*)\((.*?)\)/ # -16(%ebp)
      left = @register[$2] + $1.to_i
    #when /^\w+$/ # c
    #  left = @local[left]
    #else # $8 or %ebp
    #  left = value left
    else
      raise 'must not happen'
    end
  end

  def save(left, right)
    case right
    when /^(\-?\d*)\((.*?)\)/ # -16(%ebp)
      @memory[@register[$2] + $1.to_i] = left
    when /^\w+$/ # c
      @local[right] = left
    else # %ebp
      @register[right] = left
    end
  end

  def stack_push(val)
    @memory[@register['%esp'] -= 4] = val
  end

  def stack_pop
    tmp = @memory[@register['%esp']]
    @register['%esp'] += 4
    tmp
  end

  def evaluation(name)
    @instructions[name].each do |(inst, mne)|
      case inst
      when :pushl
        stack_push(@register[mne])
      when :popl
        @register[mne] = stack_pop
      when :movl
        left, right = mne.split(/, /)
        left = value2 left
        save left, right
      when :leal
        left, right = mne.split(/, /)
        left = address left
        save left, right
      when :call
        case mne
        when 'printf'
          tmp = @register['%esp']
          args = []
          str = stack_pop
          str.scan(/%./).each do |type|
            a = stack_pop
            case type
            when '%s'
              args << @memory[a]
            else # %d
              args << a
            end
          end
          eval "#{mne} #{([str] + args).join ', '}"
          @register['%esp'] = tmp
        when 'puts'
          tmp = @register['%esp']
          eval "#{mne} #{stack_pop}"
          @register['%esp'] = tmp
        when 'alloca'
          #popl %eax
          #subl 4, %esp
          #pushl %eax
          #ret
          a = stack_pop
          @register['%esp'] -= a
          stack_push @register['%eax']
        when 'strcpy'
          tmp = @register['%esp']
          dest = stack_pop
          from = stack_pop
          @memory[dest] = from
          @register['%esp'] = tmp
        else
          stack_push 'dummy'
          evaluation mne
        end
      when :addl
        left, right = mne.split(/, /)
        @register[right] += value(left)
      when :subl
        left, right = mne.split(/, /)
        @register[right] -= value(left)
      when :imull
        left, right = mne.split(/, /)
        @register[right] *= value(left)
      when :jmp
        evaluation mne
        return
      when :ret
        stack_pop # dummy
        return
      when :testl
        left, right = mne.split(/, /)
        left = value left
        right = value2 right
        @register['%eflags']['CF'] = @register['%eflags']['OF'] = 0
        if  left & right == 0
          @register['%eflags']['ZF'] = 1
        else
          @register['%eflags']['ZF'] = 0
        end
        @register['%eflags']['SF'] = :dummy
        #save left, right
      when :jnz
        if @register['%eflags']['ZF'] == 0
          evaluation mne
          return
        end
      else
        p "#{inst} not implemented"
      end
      #puts "#{name} #{inst} #{mne}"
      #puts "  " + [@register, @memory].inspect
    end
  end
end

if $0 == __FILE__
  a =
    if ARGF.first
      ARGF.read
    else
      File.read(File.dirname(__FILE__) + '/../example/alloca.s')
    end
  r = Ria32.new
  sourcecode = a.each_line.to_a
  sourcecode = r.commendouting sourcecode
  r.tokenize(sourcecode)
  r.evaluation 'main' 
end
