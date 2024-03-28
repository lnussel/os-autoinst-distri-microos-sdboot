# Simple test for microos with systemd-boot

install `os-autoinst` from Tumbleweed, then run this testsuite on a MicroOS qcow:

    $ ./get
    $ ./runner binaries/*.qcow2
    [c&p] some output line to run the test

Interactively watch test:

    $ vncviewer localhost:90 -Shared

If test fails:

    $ cp autoinst/testresults/some-screenshot.png needles/expected-screen.png
    $ python3 /usr/lib/os-autoinst/crop.py --tag=expected-tag needles/expected-screen.json


Settings:

    * QEMUPM=1 - enable tpm support
    * TPM_PIN=12345 - use TPM with PIN
    * FIDO2=1 - enable FIDO2 support
    * CRYPT_PASSWORD=abc - enroll separate crypt password
    * PLAINTEXT=1 - stop auto encryption
    * FIRST_BOOT_CONFIG=combustion - use combustion. Must also pass eg HDD_2
