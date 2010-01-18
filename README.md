# ria32: IA-32 Assembly Language Interpreter

Usage:

    $ ria32 hello.s

## Hello, world from scratch

Create IA-32 Assembly Language code on your Linux.

    $ vim hello.c
    #include<stdio.h>
    int main(void) {
      puts("Hello, world!");
      return 0;
    }
    
    $ gcc -S hello.c

And run the assembly file on ria32 on your arbitrary machines.

    $ ria32 hello.s

## Author

Tatsuhiro Ujihisa <http://ujihisa.blogspot.com/>

## Requirements

Ruby
