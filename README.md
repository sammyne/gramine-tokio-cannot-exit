# gramine-tokio-cannot-exit


## Reproduce

### 0. Environment
- Gramine@v1.0
- Ubuntu 20.04 LTS
- Rust@1.57.0

All above is realized using this [Dockerfile](./Dockerfile).

### 1. Build
```bash
docker build -t quickstart:0.1 .
```

### 2. Run

```bash
name=gramine-quickstart

repo=sammyne/gramine-quickstart

tag="0.1"

repoTag=$repo:$tag

docker rm -f $name

docker run --rm                                   \
  --name $name                                    \
  -v /dev/sgx:/dev/sgx                            \
  --device /dev/kmsg:/dev/kmsg                    \
  --device /dev/gsgx:/dev/gsgx                    \
  --device /dev/sgx_enclave:/dev/sgx_enclave      \
  --device /dev/sgx_provision:/dev/sgx_provision  \
  $repoTag
```

It would freezes with log as follows

```bash
debug: Token file: hello-world.token
debug: Read dummy DCAP token
debug: enclave created:
debug:     base:           0x0000000000000000
debug:     size:           0x0000000010000000
debug:     misc_select:    0x00000000
debug:     attr.flags:     0x0000000000000005
debug:     attr.xfrm:      0x0000000000000007
debug:     ssa_frame_size: 4
debug:     isv_prod_id:    0x00000000
debug:     isv_svn:        0x00000000
debug: adding pages to enclave: 0xfffa000-0x10000000 [REG:R--] (manifest) measured
debug: adding pages to enclave: 0xff7a000-0xfffa000 [REG:RW-] (ssa) measured
debug: adding pages to enclave: 0xff6a000-0xff7a000 [TCS:---] (tcs) measured
debug: adding pages to enclave: 0xff5a000-0xff6a000 [REG:RW-] (tls) measured
debug: adding pages to enclave: 0xff1a000-0xff5a000 [REG:RW-] (stack) measured
debug: adding pages to enclave: 0xfeda000-0xff1a000 [REG:RW-] (stack) measured
debug: adding pages to enclave: 0xfe9a000-0xfeda000 [REG:RW-] (stack) measured
debug: adding pages to enclave: 0xfe5a000-0xfe9a000 [REG:RW-] (stack) measured
debug: adding pages to enclave: 0xfe1a000-0xfe5a000 [REG:RW-] (stack) measured
debug: adding pages to enclave: 0xfdda000-0xfe1a000 [REG:RW-] (stack) measured
debug: adding pages to enclave: 0xfd9a000-0xfdda000 [REG:RW-] (stack) measured
debug: adding pages to enclave: 0xfd5a000-0xfd9a000 [REG:RW-] (stack) measured
debug: adding pages to enclave: 0xfd1a000-0xfd5a000 [REG:RW-] (stack) measured
debug: adding pages to enclave: 0xfcda000-0xfd1a000 [REG:RW-] (stack) measured
debug: adding pages to enclave: 0xfc9a000-0xfcda000 [REG:RW-] (stack) measured
debug: adding pages to enclave: 0xfc5a000-0xfc9a000 [REG:RW-] (stack) measured
debug: adding pages to enclave: 0xfc1a000-0xfc5a000 [REG:RW-] (stack) measured
debug: adding pages to enclave: 0xfbda000-0xfc1a000 [REG:RW-] (stack) measured
debug: adding pages to enclave: 0xfb9a000-0xfbda000 [REG:RW-] (stack) measured
debug: adding pages to enclave: 0xfb5a000-0xfb9a000 [REG:RW-] (stack) measured
debug: adding pages to enclave: 0xfb4a000-0xfb5a000 [REG:RW-] (sig_stack) measured
debug: adding pages to enclave: 0xfb3a000-0xfb4a000 [REG:RW-] (sig_stack) measured
debug: adding pages to enclave: 0xfb2a000-0xfb3a000 [REG:RW-] (sig_stack) measured
debug: adding pages to enclave: 0xfb1a000-0xfb2a000 [REG:RW-] (sig_stack) measured
debug: adding pages to enclave: 0xfb0a000-0xfb1a000 [REG:RW-] (sig_stack) measured
debug: adding pages to enclave: 0xfafa000-0xfb0a000 [REG:RW-] (sig_stack) measured
debug: adding pages to enclave: 0xfaea000-0xfafa000 [REG:RW-] (sig_stack) measured
debug: adding pages to enclave: 0xfada000-0xfaea000 [REG:RW-] (sig_stack) measured
debug: adding pages to enclave: 0xfaca000-0xfada000 [REG:RW-] (sig_stack) measured
debug: adding pages to enclave: 0xfaba000-0xfaca000 [REG:RW-] (sig_stack) measured
debug: adding pages to enclave: 0xfaaa000-0xfaba000 [REG:RW-] (sig_stack) measured
debug: adding pages to enclave: 0xfa9a000-0xfaaa000 [REG:RW-] (sig_stack) measured
debug: adding pages to enclave: 0xfa8a000-0xfa9a000 [REG:RW-] (sig_stack) measured
debug: adding pages to enclave: 0xfa7a000-0xfa8a000 [REG:RW-] (sig_stack) measured
debug: adding pages to enclave: 0xfa6a000-0xfa7a000 [REG:RW-] (sig_stack) measured
debug: adding pages to enclave: 0xfa5a000-0xfa6a000 [REG:RW-] (sig_stack) measured
debug: adding pages to enclave: 0xb634000-0xb681000 [REG:R-X] (code) measured
debug: adding pages to enclave: 0xb681000-0xb685000 [REG:RW-] (data) measured
debug: adding pages to enclave: 0xb685000-0xfa5a000 [REG:RW-] (bss) measured
debug: adding pages to enclave: 0x10000-0xb634000 [REG:RWX] (free)
debug: enclave initializing:
debug:     enclave id:   0x000000000ffff000
debug:     mr_enclave:   e5d76d6120fcad2579fc38ab5eb18cc28f861d9302d7f035f4c3688dfc0fa475
-----------------------------------------------------------------------------------------------------------------------
Gramine detected the following insecure configurations:

  - loader.log_level = warning|debug|trace|all (verbose log level, may leak information)
  - loader.insecure__use_cmdline_argv = true   (forwarding command-line args from untrusted host to the app)
  - sys.insecure__allow_eventfd = true         (host-based eventfd is enabled)

Gramine will continue application execution, but this configuration must not be used in production!
-----------------------------------------------------------------------------------------------------------------------

warning: DkVirtualMemoryProtect is unimplemented in Linux-SGX PAL
[::] debug: Host: Linux-SGX
[::] debug: LibOS xsave_enabled 1, xsave_size 0x340(832), xsave_features 0x7
[::] debug: Initial VMA region 0xb5bb000-0xb634000 (LibOS) bookkeeped
[::] debug: Initial VMA region 0xfffa000-0x10000000 (manifest) bookkeeped
[::] debug: ASLR top address adjusted to 0x977b000
[::] debug: Shim loaded at 0xb5bb000, ready to initialize
[::] debug: Mounting root as chroot filesystem: from file:. to /
[::] debug: Mounting special proc filesystem: /proc
[::] debug: Mounting special dev filesystem: /dev
[::] debug: Mounting terminal device /dev/tty under /dev
[P1:T1:] debug: Mounting as chroot filesystem: from file:/usr/local/lib/x86_64-linux-gnu/gramine/runtime/glibc to /lib
[P1:T1:] debug: Mounting as chroot filesystem: from file:/bin to /bin
[P1:T1:] debug: Mounting as chroot filesystem: from dev:/dev/kmsg to /dev/kmsg
[P1:T1:] debug: Mounting as chroot filesystem: from file:/lib/x86_64-linux-gnu to /lib/x86_64-linux-gnu
[P1:T1:] debug: Mounting as chroot filesystem: from file:/usr//lib/x86_64-linux-gnu to /usr//lib/x86_64-linux-gnu
[P1:T1:hello-world] debug: Allocating stack at 0x0 (size = 262144)
[P1:T1:hello-world] debug: loading "file:./hello-world"
[P1:T1:hello-world] debug: find_interp: searching for interpreter: /lib/ld-linux-x86-64.so.2
[P1:T1:hello-world] debug: loading "file:/usr/local/lib/x86_64-linux-gnu/gramine/runtime/glibc/ld-linux-x86-64.so.2"
[P1:T1:hello-world] debug: Creating pipe: pipe.srv:1
debug: sock_getopt (fd = 12, sockopt addr = 0x7ffc75f17560) is not implemented and always returns 0
[P1:T1:hello-world] debug: Shim process initialized
[P1:shim] debug: IPC worker started
[P1:T1:hello-world] warning: Not supported flag (0x3001) passed to arch_prctl
[P1:T1:hello-world] debug: glibc register library /lib/x86_64-linux-gnu/libgcc_s.so.1 loaded at 0x0964b000
[P1:T1:hello-world] debug: glibc register library /lib/librt.so.1 loaded at 0x09646000
[P1:T1:hello-world] debug: glibc register library /lib/libpthread.so.0 loaded at 0x09641000
[P1:T1:hello-world] debug: glibc register library /lib/libm.so.6 loaded at 0x09566000
[P1:T1:hello-world] debug: glibc register library /lib/libdl.so.2 loaded at 0x09561000
[P1:T1:hello-world] debug: glibc register library /lib/libc.so.6 loaded at 0x09367000
[P1:T1:hello-world] debug: add fd 4 (handle 0xb57ad58) to epoll handle 0xb57ac98
[P1:T1:hello-world] debug: Creating pipe: pipe.srv:a1af597cd63591b24390482ea76c568d5a0febf14b4e458eda7c8e24795da231
debug: sock_getopt (fd = 22, sockopt addr = 0x7ffc75f17560) is not implemented and always returns 0
debug: sock_getopt (fd = 23, sockopt addr = 0x7ffc75f17560) is not implemented and always returns 0
debug: sock_getopt (fd = 24, sockopt addr = 0x7ffc75f17560) is not implemented and always returns 0
[P1:T1:hello-world] debug: add fd 8 (handle 0xb57ae88) to epoll handle 0xb57ac98
[P1:T1:hello-world] warning: Unsupported system call 435
[P1:T2:hello-world] warning: Unsupported system call prctl
[P1:T1:hello-world] warning: Unsupported system call 435
[P1:T3:hello-world] warning: Unsupported system call prctl
[P1:T1:hello-world] warning: Unsupported system call 435
[P1:T4:hello-world] warning: Unsupported system call prctl
[P1:T1:hello-world] warning: Unsupported system call 435
[P1:T5:hello-world] warning: Unsupported system call prctl
[P1:T1:hello-world] warning: Unsupported system call 435
[P1:T6:hello-world] warning: Unsupported system call prctl
[P1:T1:hello-world] warning: Unsupported system call 435
[P1:T7:hello-world] warning: Unsupported system call prctl
[P1:T1:hello-world] warning: Unsupported system call 435
[P1:T8:hello-world] warning: Unsupported system call prctl
[P1:T1:hello-world] warning: Unsupported system call 435
hello world
[P1:T9:hello-world] warning: Unsupported system call prctl
[P1:T4:hello-world] debug: ---- shim_exit (returning 0)
[P1:T9:hello-world] debug: ---- shim_exit (returning 0)
[P1:T6:hello-world] debug: ---- shim_exit (returning 0)
[P1:T7:hello-world] debug: ---- shim_exit (returning 0)
[P1:T8:hello-world] debug: ---- shim_exit (returning 0)
[P1:T5:hello-world] debug: ---- shim_exit (returning 0)
[P1:T4:hello-world] debug: Installed async event at 1641355827743134
[P1:T9:hello-world] debug: Installed async event at 1641355827743176
[P1:shim] debug: Async worker thread started
[P1:T6:hello-world] debug: Installed async event at 1641355827743180
[P1:T7:hello-world] debug: Installed async event at 1641355827743186
[P1:T8:hello-world] debug: Installed async event at 1641355827743187
[P1:T5:hello-world] debug: Installed async event at 1641355827743187
[P1:shim] debug: Thread exited, cleaning up
[P1:shim] debug: Thread exited, cleaning up
[P1:shim] debug: Thread exited, cleaning up
[P1:shim] debug: Thread exited, cleaning up
[P1:shim] debug: Thread exited, cleaning up
[P1:shim] debug: Thread exited, cleaning up
[P1:T2:hello-world] debug: ---- shim_exit (returning 0)
[P1:T2:hello-world] debug: Installed async event at 1641355827873458
[P1:shim] debug: Thread exited, cleaning up
```
