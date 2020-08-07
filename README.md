ADAC-HYBRID-MSP430
==================

A hybrid compiler toolchain for MSP430 platform which can compile standalone Ada source files.

The project was initially created by N7 Space z o.o. for the European Space Agency as a part of "Tiny Runtime to Run Model-Based Software on CubeSats" activity.

Installation
---------------------------------------------

The project relies on GNU makefiles and docker for compilation. In order to build the compiler toolchain:
* Check-out the project. Be aware that the project uses LFS and submodules, and so git and git-lfs should be installed beforehand.
* Make sure that all submodules were checked-out successfully: when in doubt, use `git submodule update --init --recursive`.
* Make sure that `make` and `docker` are installed, and that `docker` can be invoked as the current user.
* Type `make`.

This produces build/adac directory.
* build/adac/bin contains the binaries and should be added to the PATH environment variable.
* build/adac/lib contains the libraries and should be added to the LD_LIBRARY_PATH environment variable.


In order to use the compiler, additional dependencies must be installed:
* llvm-dev,
* clang, 
* gcc,
* gnat,
* gprbuild.

The project has been tested on Debian 10 and Ubuntu 19, with GNAT Community 2019 and LLVM 9.

The main makefile provides 3 test targets:
* dockertest - executed inside a dedicated docker image (adac:test), on a msp430g2553 emulator,
* emutest - executed directly on user system, on a msp430g2553 emulator,
* hwtest - executed directly on user system, on a msp430fr5969 development board.

In order to execute `emutest`, the msp430g2553 emulator must be compiled. For compilation instructions, please refer to the emulator's README.

In order to execute 'hwtest', the Texas Instruments msp430 gcc compiler toolchain must be installed and present in PATH, 
and a msp430fr5969 development board must be connected to the user system. 
The project has been tested on MSP430FR5969 LaunchPad Evaluation Kit.


Usage
---------------------------------------------

The project provides 2 commands:

* **msp430-elf-adac** - frontend for compiling Ada source files.
* **msp430-elf-adabind** - bind utility required by `.gpr` based projects built through **gprbuild** command.

### msp430-elf-adac

**msp430-elf-adac** is constructed to mimic a regular c compiler in usage. However, it combines several different compilers, and as such accepts command-line arguments for all of them:
* All arguments prefixed with `-Wgnat,` are forwarded to llvm-gcc, after stripping the prefix. Please consult llvm-gcc manual for the list of accepted options.
* All arguments prefixed with `-gnat` are forwarded to llvm-gcc as is. Please consult llvm-gcc manual for the list of accepted options.
* All arguments prefixed with `-Wllc,` are forwareded to llc, after stripping the prefix. Please consult llc manual for the list of accepted options.
* All arguments prefixed with `-Wdac,` are interpreted by adac. Please consult the list below.
* All other arguments are forwareded to msp430-elf-gcc. Please consult msp430-elf-gcc manual for the list of accepted options.

Adac accepts the following options:
* `keep_ada_main` - don't rename `_ada_main` to `main`.
* `keep_intermediates` - don't delete the generated intermediate files: llvm bytecode, msp430 assembly and Ada `.ali` files.

#### Examples (using `Makefile` convention)

Compile `.adb` source to an object file:

`msp430-elf-adac ${CFLAGS} -o $@ -c $<`
	
* $@ - output object name
* $< - input `.adb` file name
* ${CFLAGS} - project specific compiler flags

Link object files into an executable:

`msp430-elf-adac ${CFLAGS} ${LFLAGS} -o $@ ${OBJ} ${LIBS}`

* $@ - output executable name
* ${CFLAGS} - project specific compiler flags
* ${LFLAGS} - project specific linker flags
* ${OBJ} - list of object files to link
* ${LIBS} - list of additional library files to link

Example CFLAGS:

```
CFLAGS= -mmcu=msp430g2553 \
	-msmall \
	-Wall \
	-Wgnat,-gnatif \
	-Wgnat,-IadditionalIncludeDirectory \
	-Wllc,--function-sections
```

* -mmcu=msp430g2553 - target msp430g2553 microcontroller (selects instruction set, as well as default linker script)
* -msmall - use small memory model
* -Wall - enable more warning messages
* -Wgnat,-gnatif - instruct llvm-gcc to accept extended character set in source files
* -Wgnat,-IadditionalIncludeDirectory - instruct llvm-gcc to add additionalIncludeDirectory as include directory
* -Wllc,--function-sections - instruct llc to put each function in an individual section so that linker can remove unused functions

Example LFLAGS:

```
LFLAGS= -L pathToAdacLibraries \
    -L pathToMsp430GccLibraries \
    -Wl,--gc-sections \
    -T msp430g2553.ld
```

* -L pathToAdacLibraries - add adac libraries to library path
* -L pathToMsp430GccLibraries - add msp430 gcc libraries to library path
* -Wl,--gc-sections - remove unused sections
* -T msp430g2553.ld - use linker script for msp430g2553

Example LIBS:

`LIBS=-lgnatmsp430 -lllvmmsp430 -lc`

* -lgnatmsp430 - link gnat library compiled for MSP430 instruction set (e.g. for msp430g2553)
* -lllvmmsp430 - link llvm runtime library compiled for MSP430 instruction set
* -lc - link C library

Standalone object file compilation example:

`msp430-elf-adac -mmcu=msp430g2553 -msmall -Wgnat,-gnatif -o mysrc.o -c mysrc.adb`

compiles `mysrc.adb` into `mysrc.o` for msp430g2553 microcontroller, allowing an extended character set.

Standalone linking example:

`msp430-elf-adac -mmcu=msp430g2553 -msmall -L /home/user/tools/adac/lib -L /home/user/tools/ti/msp430-gcc/include -T msp430g2553.ld -o myprog mysrc.o  -lgnatmsp430  -lllvmmsp430 -lc`

compiles` mysrc.o` into `myprog` executable for msp430g2553 microcontroller,
assuming that msp430 gcc is installed in `/home/user/tools/ti/msp430-gcc`
and adac is installed in `/home/user/tools/adac`.

For more examples, please refer to the *test* directory and analyze the provided *Makefiles*.

### msp430-elf-adabind

**msp430-elf-adabind** is called implicitly by gprbuild when building a `.gpr` based project.
In order to configure the project to use both `msp430-elf-adac` and `msp430-elf-adabind`,
several options must be added to the project file:

Use `msp430-elf-adabind` for binding:

```
package Binder is
    for Driver ("Ada")  use "msp430-elf-adabind";
end Binder;
```

Use `msp430-elf-adac` for compilation:

```
package Compiler is
    for Driver ("Ada") use "msp430-elf-adac";

    (... the rest of regular compiler configuration ...)

end Compiler;
```

Example project file (uses the previously introduced options):

```
project GprBuildBasedProject is

   type Build_Type is ("Release");
   Build : Build_Type := external ("CFG", "Release");

   IncludePath := external("MSP430_INCLUDE_PATH", "PATH_TO_GCC_INCLUDE");

   for Source_Dirs use
      ("src");

   for Object_Dir use "build/obj";
   for Exec_Dir   use "build";

   for Languages use ("C", "Ada");

   for Main use ("main.c");

   package Naming is
	   for Body_Suffix ("Ada") use ".adb";
   end Naming;

   package Binder is
      for Driver ("Ada")  use "msp430-elf-adabind";
   end Binder;

   package Compiler is
      for Driver ("C") use "msp430-elf-gcc";
      for Driver ("Ada") use "msp430-elf-adac";

      for Required_Switches ("C") use ("-c");
      for Required_Switches ("Ada") use ("-c");

      case Build is
         when "Release" =>
            for Default_Switches ("C") use
               ("-mmcu=msp430g2553",
                "-msmall",
                "-ffunction-sections",
                "-Wall",
                "-Wextra",
                "-Wpedantic",
                "-Wno-unused-parameter",
                "-Wl,--gc-sections");
            for Default_Switches ("Ada") use
               ("-Wgnat,-I.",
                "-Wgnat,-Isrc",
                "-mmcu=msp430g2553",
                "-msmall",
                "-ffunction-sections");
      end case;
   end Compiler;

   package Linker is
      for Driver use "msp430-elf-gcc";

      for Default_Switches ("C") use
         ("-L" & IncludePath,
          "-I" & IncludePath,
          "-I.",
          "-mmcu=msp430g2553",
          "-msmall",
          "-lgnatmsp430",
          "-lllvmmsp430",
          "-lc",
          "-Wno-unused-parameter",
          "-Wl,-Map=main.map",
          "-Wl,--gc-sections",
          "-Tmsp430g2553.ld");

   end Linker;

   package Builder is
      for Executable ("main.c") use "gpr.elf";
   end Builder;

end GprBuildBasedProject;
```

### Memory model

Currently only the small msp430 memory model is supported - sucessfuly tested to compile and execute.
The support relies on the assembly generated by llc, so this may change with newer llc versions.

### Instruction Set Architecture

Both MSP430 and MSP430X instruction set architectures are supported. The architecture is selected implicitly by specifying microcontroller target using `-mcu` option. For the required libraries, please refer to chapter **Gnat and llvm libraries**.

### .init_array

As the toolchain uses gcc for the last compilation stage, it relies on `.init_array` for executing initializers. The consequence is that `adainit` function is not needed and is not generated.
This affects C and Ada code interoperation - normally, a C programmer integrating Ada code should make a call to `adainit` within `main`. However, with adac this is not needed. 

### Gnat and llvm libraries

The llvm assembly generated from Ada code relies on facilities provided by the gnat library.
At the same time, the msp430 assembly generated from llvm assembly relies on
llvm runtime functions for msp430 platform (software multiplication, floating point, etc.).
The c runtime library provided with GCC covers most of the required functions. However, in order to cover the remaining ones, two libraries need to be linked - libgnat and libllvm.
The family of msp430 microcontrollers uses two instruction sets: MSP430 and MSP430X. Therefore the toolchain is bundled with the two libraries compiled for two instruction sets:
* libgnatmsp430 and libllvmmsp430 for MSP430 ISA;
* libgnatmsp430x and libllvmmsp430x for MSP430X ISA.

User is responsible for linking the correct libraries.

## Architecture

The toolchain is based on AdaCore's [gnat llvm](https://github.com/AdaCore/gnat-llvm) (which in turn relies on gcc and llvm projects)
and Texas Instrument's version of [gcc](https://www.ti.com/tool/MSP430-GCC-OPENSOURCE).
The use of Texas Instrument's gcc ensured the ability to use the newest msp430 microcontrollers, 
some of which (e.g. msp430fr5969, of special interest for the parent activity)
cannot be safely compiled using standard [msp430-gcc](https://packages.debian.org/sid/gcc-msp430).
The llvm-runtime library contains code from the [llvm project](https://llvm.org/).
The gnat-runtime library contains code from [gcc](https://gcc.gnu.org/)
and [msp430-ada](https://sourceforge.net/p/msp430ada/wiki/Home/) projects.

Ada compilation for msp430 target is performed in the following steps:
* invoke gnat llvm to translate Ada sources into llvm bytecode,
* invoke llc to translate llvm bytecode into msp430 assembly,
* compile to msp430 assembly into binary objects using gcc.


The compilation is managed by `msp430-elf-adac` python script.

The project structure is as follows:
* src/gcc - gcc project (included as a submodule),
* src/gnat-llvm - gnat llvm project (included as a submodule),
* src/llvm-project - llvm project (included as a submodule),
* src/gnat-runtime - gnat runtime library project,
* src/llvm-runtime - llvm runtime library project,
* src/msp430-elf-adac - python scripts that orchestrate the toolchain,
* tools/msp430-emulator - msp430g2553 emulator project used for testing (included as a submodule),
* tools/ ms430-gcc-full-linux-x64-installer-*.run - msp430 gcc installer,
* test - set of integration tests.


## License

This project combines several other open-source projects. Please refer to the LICENSE file for details.

