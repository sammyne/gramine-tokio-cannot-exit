# gramine-tokio-cannot-exit

Fixed by [PR#340](https://github.com/gramineproject/gramine/pull/340).

## Reproduce

### 0. Environment
- [Gramine@84b331f]
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
debug: adding pages to enclave: 0xf635000-0xf682000 [REG:R-X] (code) measured
debug: adding pages to enclave: 0xf682000-0xf686000 [REG:RW-] (data) measured
debug: adding pages to enclave: 0xf686000-0xfa5a000 [REG:RW-] (bss) measured
debug: adding pages to enclave: 0x10000-0xf635000 [REG:RWX] (free)
debug: enclave initializing:
debug:     enclave id:   0x000000000ffff000
debug:     mr_enclave:   ccab698129b7968919310d9b57791f62395bf0c34575299f33b316dea2ac2c9b
-----------------------------------------------------------------------------------------------------------------------
Gramine detected the following insecure configurations:

  - loader.log_level = warning|debug|trace|all (verbose log level, may leak information)
  - loader.insecure__use_cmdline_argv = true   (forwarding command-line args from untrusted host to the app)
  - sys.insecure__allow_eventfd = true         (host-based eventfd is enabled)

Gramine will continue application execution, but this configuration must not be used in production!
-----------------------------------------------------------------------------------------------------------------------

warning: 'loader.preload' is deprecated; please switch to 'loader.entrypoint'
warning: DkVirtualMemoryProtect is unimplemented in Linux-SGX PAL
[::] debug: Gramine was built from commit: 84b331fe7da92675a888837eb54c2b33a3de4518
[::] debug: Host: Linux-SGX
[::] debug: LibOS xsave_enabled 1, xsave_size 0x340(832), xsave_features 0x7
[::] debug: Initial VMA region 0xf57c000-0xf5f6000 (LibOS) bookkeeped
[::] debug: Initial VMA region 0xfffa000-0x10000000 (manifest) bookkeeped
[::] debug: ASLR top address adjusted to 0x60ea000
[::] debug: Shim loaded at 0xf57c000, ready to initialize
[::] debug: Mounting root as chroot filesystem: from file:. to /
[::] debug: Mounting special proc filesystem: /proc
[::] debug: Mounting special dev filesystem: /dev
[::] debug: Mounting terminal device /dev/tty under /dev
[P1:T1:] debug: Mounting as chroot filesystem: from file:/usr/local/lib/x86_64-linux-gnu/gramine/runtime/glibc to /lib
[P1:T1:] debug: Mounting as chroot filesystem: from file:/bin to /bin
[P1:T1:] debug: Mounting as chroot filesystem: from dev:/dev/kmsg to /dev/kmsg
[P1:T1:] debug: Mounting as chroot filesystem: from file:/lib/x86_64-linux-gnu to /lib/x86_64-linux-gnu
[P1:T1:] debug: Mounting as chroot filesystem: from file:/usr//lib/x86_64-linux-gnu to /usr//lib/x86_64-linux-gnu
[P1:T1:hello-world] debug: Creating pipe: pipe.srv:96810eb86e4b27274cc343cb3ae6b2a1a638b40191ecddb8a241dfc168129419
[P1:T1:hello-world] debug: Allocating stack at 0 (size = 262144)
[P1:T1:hello-world] debug: loading "file:./hello-world"
[P1:T1:hello-world] debug: find_interp: searching for interpreter: /lib/ld-linux-x86-64.so.2
[P1:T1:hello-world] debug: loading "file:/usr/local/lib/x86_64-linux-gnu/gramine/runtime/glibc/ld-linux-x86-64.so.2"
[P1:T1:hello-world] debug: Creating pipe: pipe.srv:3ade08ecffcca8f6263de75ddb76698fad67d2676f52748f7fa699814f58b716
[P1:T1:hello-world] debug: Creating pipe: pipe.srv:1
[P1:T1:hello-world] debug: Shim process initialized
[P1:shim] debug: IPC worker started
[P1:T1:hello-world] warning: Not supported flag (0x3001) passed to arch_prctl
[P1:T1:hello-world] debug: glibc register library /lib/x86_64-linux-gnu/libgcc_s.so.1 loaded at 0x05fba000
[P1:T1:hello-world] debug: glibc register library /lib/librt.so.1 loaded at 0x05fb5000
[P1:T1:hello-world] debug: glibc register library /lib/libpthread.so.0 loaded at 0x05fb0000
[P1:T1:hello-world] debug: glibc register library /lib/libm.so.6 loaded at 0x05ed5000
[P1:T1:hello-world] debug: glibc register library /lib/libdl.so.2 loaded at 0x05ed0000
[P1:T1:hello-world] debug: glibc register library /lib/libc.so.6 loaded at 0x05cd6000
[P1:T1:hello-world] debug: Creating pipe: pipe.srv:74e3ec6a6c5bdcf4048afcbe345f907a081650da1d05de09762ab8db3bb90090
[P1:T1:hello-world] debug: add fd 4 (handle 0xb615ba0) to epoll handle 0xb615ae8
[P1:T1:hello-world] debug: Creating pipe: pipe.srv:785f8dc0d3e4f8141e475ccee685f1e2ba34f68f9b916da75c976ef0c248e7b1
[P1:T1:hello-world] debug: add fd 8 (handle 0xb615ca8) to epoll handle 0xb615ae8
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
[P1:T8:hello-world] debug: ---- shim_exit (returning 0)
[P1:T7:hello-world] debug: ---- shim_exit (returning 0)
[P1:T5:hello-world] debug: ---- shim_exit (returning 0)
[P1:T4:hello-world] debug: Installed async event at 1641364560302448
[P1:T9:hello-world] debug: Installed async event at 1641364560302451
[P1:shim] debug: Async worker thread started
[P1:T6:hello-world] debug: Installed async event at 1641364560302472
[P1:T8:hello-world] debug: Installed async event at 1641364560302489
[P1:T7:hello-world] debug: Installed async event at 1641364560302504
[P1:T5:hello-world] debug: Installed async event at 1641364560302504
[P1:shim] debug: Thread exited, cleaning up
[P1:shim] debug: Thread exited, cleaning up
[P1:shim] debug: Thread exited, cleaning up
[P1:shim] debug: Thread exited, cleaning up
[P1:shim] debug: Thread exited, cleaning up
[P1:shim] debug: Thread exited, cleaning up
[P1:T2:hello-world] debug: ---- shim_exit (returning 0)
[P1:T2:hello-world] debug: Installed async event at 1641364560375101
[P1:shim] debug: Thread exited, cleaning up
```

[Gramine@84b331f]: https://github.com/gramineproject/gramine/commit/84b331fe7da92675a888837eb54c2b33a3de4518
