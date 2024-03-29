## Overview

This demonstrates an issue when using another version of the LLVM toolchain with Xcode. 

When an Xcode project contains Swift packages, you must build from the command line in order to specify your builds settings. Any build settings specified in the Xcode UI are not propogated to your packages.

This means in large packages with Swift Packages and a custom LLVM toolchain, you cannot use the Xcode UI for builds since it will not respect your Build Settings.

### Setup

This assumes you are have an alternate LLVM toolchain installed. This example uses LLVM 17.0.6.

* Install: `brew install llvm`
* Make Toolchain Available: `ln -s /opt/homebrew/opt/llvm@17/Toolchains/LLVM17.0.6.xctoolchain ~/Library/Developer/Toolchains/LLVM17.0.6.xctoolchain`
* Xcode -> Menu -> Toolchains -> org.llvm.17.0.6  

### Xcode Failure Example

* Open CustomCompilerProject.xcodeproj
* Run
* A build error will be hit: `unknown argument: -index-store-path`
* This error is expected as the index store is not a feature of open-source LLVM?
* Try to remove the `-index-store-path` build flag by going Xcode Builds Settings -> Turn off "Enable Index-While-Building Functionality"
* Build again, same error is hit.
* Observe the build logs and note that `-index-store-path` is still being passed as an argument when building the swift package. Why is it still be being passed to the Package?

### XcodeBuild Behavior

* If you use xcodebuild from the command-line, and specify index while build be disabled, the build will complete successfully - unlike using Xcode's Settings previously. 
* xcodebuild -scheme CustomCompilerProject -toolchain org.llvm.17.0.6 COMPILER_INDEX_STORE_ENABLE=NO
* Build will complete successfully.
* Note that in the build logs `-index-store-path` is _not_ being used. The passed settings was respected.


### Other Related Behavior

xcodebuild clean -scheme CustomCompilerProject && xcodebuild -scheme CustomCompilerProject -toolchain org.llvm.17.0.6 COMPILER_INDEX_STORE_ENABLE=NO OTHER_CFLAGS="-Werror=empty-body" | grep "HelloWorld.o"

* Build From Xcode: Build Settings are not propogated to Swift Package.
* Build From Xcode: C-Flags are not propogated to Swift Package.
* Build From Command Line: Command-line build settings are used in Package Clang commands (when building project)
* Build From Command Line: Command line C-Flags are used in Package Clang commands (when building project)
* You can also set C-Flags in the Package.swift
* Note that when building projects both from the command line and Xcode, there are default flags and arguments being sent to the package clang commands that are not from Xcode build settings. It seems the build system is selecting defaults for packages. 
* Buld From Command Line: It seems like adding an command line flags negates the ones in teh Package settings.

