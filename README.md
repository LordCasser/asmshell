Assembler Shell(asmshell)
==============

Assembler([Keystone-Engine](http://www.keystone-engine.org/)) + Emulator([Unicorn-Engine](http://www.unicorn-engine.org/)) + interactive cli library([ishell](https://github.com/abiosoft/ishell)) = Text-based Assembler Emulator

Assembler Shell(asmshell) is a Text-based assembler emulator.

You can easily check the execution result of the assembler.

Enjoy! :)

## Feature
Multi-architecture support(depends on unicorn/keystone-engine)

	Assemble & emulation          : i8086, x86, x64, arm-thumb(be), arm(be), arm64, mips(be), mips64(be), sparc, sparc64
	Assemble only                 : powerpc, powerpc64(le), sparcle, systemZ
	Future support                : arm64be, m68k

Useful functions

	Shell like commands           : fragments, run linux commands...etc
	Handled like a shell          : Ctrl-P/Ctrl-N, Ctrl-A/Ctrl-E, Ctrl-H/Ctr-D...etc
	Cross Platform(depends on go) : *NIX, OSX

## Install
Go language, unicorn-engine and keystone-engine are necessary, but the installation process is automated with Makefile. So forget about these things, and just make it.


### Linux/Mac

1. Install [CMake](https://cmake.org/download/)/make/Compiler(gcc,g++)/Git

2. Build asmshell

	`$ git clone https://github.com/LordCasser/asmshell`  
	`$ cd asmshell && make`  
	`$ ./asmshell -h`  

### Windows

NO WINDOWS!!!

## Usage

### Help
	$ ./asmshell [-h/--help]

### x86
	$ ./asmshell
![x86 mode](https://i.loli.net/2021/11/11/5pSidhzn6RU34Yx.jpg)

### x64
	$ ./asmshell -arch x64
![x64 mode](https://i.loli.net/2021/11/11/sx4GHcR5NweKaLB.jpg)


## Tutorial

### Fragment Commands(Example: Symbol, Read file)
You can register mnemonic fragments.

	$ ./asmshell.exe
	(x86)> fragment symbol # register from input
	in> mov ecx, 0x20
	... l1:
	... inc eax
	... dec ecx
	... jnz l1; # ';' is end the register
	'symbol` is registered
	(x86)> fragment show # show registered fragments. If you want show specify fragments, run this -> 'fragment show <name1> <name2>...'
	'symbol'
	    l1:
	    inc eax
	    dec ecx
	    jnz l1
	(x86)> fragment run symbol

Read from file.

	$ cat xor.txt
	xor ax, cx
	$ ./asmshell.exe
	(x86)> f encrypt encrypt.txt # register from file. 'f' is alias of fragment
	(x86)> f s encrypt           # 'f s' is alias of 'fragment show'
	(x86)> f r encrypt           # fragment run encrypt

If you want to register binary code, change filename to "<filename>.bin".(".bin" suffix is very important)  

	(x86)> f test code.bin # disassemble code.bin and register
	(x86)> f s test

### Change Architecture

	$ ./asmshell.exe
	(x86)> set # show available architecture
	Usage: set <arch>
	Supported: i8086, x86, x64, arm-thumb(be), arm(be), arm64, mips(be), mips64(be), sparc(le), sparc64, [ppc|powerpc], [ppc64(le)|powerpc64(le)], [sysz|systemz|systemZ]
	(x86)> set arm
	(arm)>

### Run shell command(now linux & mac only)
	$ ./asmshell.exe
	(x86)> !ls -lga

## Available Shell Commands
	help                       : display help
	fragment [run/show/delete] : register/run/show/delete fragment
	!<cmd>                     : run shell commands
	set <arch>                 : set architecture and mode
	exit/quit/q                : exit the program


## Contribution

If you want to contribute, please pick up something from our [Github issues](https://github.com/LordCasser/asmshell/issues).


## License

The software in this repository is covered by [the MIT license](LICENSE).


## Author

poppycompass (t0g0v31dk at gmail dot com)

I fork it from poppycompass and replaced and repaired some unmaintained libraries, thanks for [azurity](https://github.com/azurity),  it be installed with one click now.

