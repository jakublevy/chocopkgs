

# ddcpuid, CPUID tool
ddcpuid is a x86 processor information tool.

Officially supports these vendors:
* `"GenuineIntel"` - Intel Corporation
* `"AuthenticAMD"` - Advanced Micro Devices Inc.
* `"KVMKVMKVM\0\0\0"` - Linux built-in Kernel Virtual Machine
* `"Microsoft Hv"` - Microsoft Hyper-V interface
* `"VBoxVBoxVBox"` - VirtualBox Hyper-V interface
* `"\0\0\0\0\0\0\0\0\0\0\0\0"` - VirtualBox minimal interface

## Example 
```
$ ddcpuid
Name:        AuthenticAMD AMD Ryzen 5 1600 Six-Core Processor
Identifier:  Family 0x17 Model 0x8 Stepping 0x2
Cores:       6 cores 12 threads
Max. Memory: 256TB physical 256TB virtual
Techs:       x86-64-v3 Core-Performance-Boost HTT
SSE:         SSE SSE2 SSE3 SSSE3 SSE4.2 SSE4a
AVX:         AVX AVX2
AMX:         None
Others:      x87/FPU +F16C MMX ExtMMX AES-NI ADX SHA BMI1 BMI2
Mitigations: IBPB
ParaVirt.:   Hyper-V
Cache L1-D:  6x 32KB    (192KB)  SI
Cache L1-I:  6x 64KB    (384KB)  SI
Cache L2-U:  6x 512KB   (3MB)    SI CI
Cache L3-U:  2x 8MB     (16MB)   SI NWBV
```

## Usage
```
$ ddcpuid -h
x86/AMD64 CPUID information tool

USAGE
 ddcpuid [OPTIONS...]

OPTIONS
 -d, --details  Show detailed processor information
 -r, --table    Show raw CPUID data in a table
 -S             Table: Set leaf (EAX) input value
 -s             Table: Set subleaf (ECX) input value
 -o             Override maximum leaves to 0x20, 0x4000_0020, and 0x8000_0020
 -l, --level    Print the processor's feature level

PAGES
 --version    Print version screen and quit
 --ver        Print version and quit
 -h, --help   Print this help screen and quit
```