$: << File.dirname(__FILE__) + '/../lib/'
require 'ria32'

describe '(Integrated)' do
  it 'ria32 interprets the helloworld assembly code' do
    a = File.read(File.dirname(__FILE__) + '/../example/hello.s')
    r = Ria32.new
    sourcecode = a.each_line.to_a
    sourcecode = r.commendouting sourcecode
    r.tokenize(sourcecode)

    $stdout = StringIO.new
    r.evaluation 'main' 
    stdout = $stdout
    $stdout = STDOUT
    stdout.rewind
    stdout.read.should == "Hello, World!\n"
  end

  it 'ria32 interprets the alloca assembly code' do
    a = File.read(File.dirname(__FILE__) + '/../example/alloca.s')
    r = Ria32.new
    sourcecode = a.each_line.to_a
    sourcecode = r.commendouting sourcecode
    r.tokenize(sourcecode)

    $stdout = StringIO.new
    r.evaluation 'main' 
    stdout = $stdout
    $stdout = STDOUT
    stdout.rewind
    stdout.read.should == "<<Hello>>\n"
  end
end
