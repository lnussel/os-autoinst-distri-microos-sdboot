# Simple test for microos with systemd-boot

install `os-autoinst` from Tumbleweed, then run this testsuite on a MicroOS qcow:

    $ osc getbinaries openSUSE:Factory openSUSE-MicroOS:kvm-and-xen-sdboot images x86_64
    $ ./run binaries/*.qcow2 SMP=2 QEMUTPM=1

Interactively watch test:

    $ vncviewer localhost:90 -Shared

If test fails:

    $ cp autoinst/testresults/some-screenshot.png needles/expected-screen.png
    $ python3 /usr/lib/os-autoinst/crop.py --tag=expected-tag needles/expected-screen.json


Settings:

    * QEMUPM=1 - set to enable tpm support
    * PLAINTEXT=1 - set to stop auto encryption
    * FIRST_BOOT_CONFIG=combustion - use combustion. Must also pass eg HDD_2
