# Copyright 2014-2018 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

use base 'basetest';
use strict;
use testapi;

sub run {
    assert_screen 'welcome', 60;

    type_string 'root';
    send_key 'ret';

    sleep 1;

    type_password;
    send_key 'ret';

    sleep 1;

    type_string "lsblk\n";

    sleep 1;

    type_string "sdbootutil list-kernels\n";

    sleep 1;

    type_string "reboot\n";

    assert_screen 'bootloader-sdboot';

    if (!get_var('PLAINTEXT')) {
	    if (get_var('QEMUTPM')) {
		    my $pin = get_var('TPM_PIN');
		    if ($pin) {
			    assert_screen 'reboot-enter-tpm2-pin', 30;
			    type_password($pin);
			    send_key 'ret';
		    }
	    } elsif (get_var('FIDO2')) {
		    # well, in theory it should be required to touch
		    # the fido but the qemu emulation does not
		    # support that
	    } else {
		    assert_screen 'enter-unlock-password', 60;
		    type_password(get_var('CRYPT_PASSWORD'));
		    send_key 'ret';
	    }
    }

    assert_screen 'welcome', 60;
}

sub test_flags {
    return {fatal => 1}; 
}

1;
