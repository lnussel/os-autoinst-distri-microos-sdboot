# Copyright 2014-2018 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

use base 'basetest';
use strict;
use testapi;

sub run {
    # wait for bootloader to appear
    assert_screen 'bootloader-sdboot';

    # press enter to boot right away
    send_key 'ret';

    if (get_var('FIRST_BOOT_CONFIG', '') eq 'combustion') {
	    assert_screen 'welcome', 300;
	    return 0;
    }

    # wait for the desktop to appear
    assert_screen 'prompt-abort-disk-encryption', 60;

    if (get_var('PLAINTEXT')) {
	    send_key 'esc';
    } else {
	assert_screen 'encrypting', 30;
    }

    assert_screen 'jeos-init-config-screen', 200;
    send_key 'ret';

    assert_screen 'jeos-keylayout', 30;
    send_key 'ret';

    assert_screen 'jeos-license', 30;
    send_key 'ret';

    assert_screen 'jeos-timezone', 30;
    send_key 'ret';

    assert_screen 'jeos-root-password', 30;
    type_password;
    send_key 'ret';

    assert_screen 'jeos-confirm-root-password', 30;
    type_password;
    send_key 'ret';

    if (!get_var('PLAINTEXT')) {
	    assert_screen 'jeos-encryption-password', 30;

	    my $pw = get_var('CRYPT_PASSWORD');
	    if ($pw) {
		send_key 'right';
		send_key 'ret';

		assert_screen 'jeos-enter-encryption-password', 30;
		type_password $pw;
		send_key 'ret';

		assert_screen 'jeos-enter-encryption-password', 30;
		type_password $pw;
		send_key 'ret';
	    }
	    send_key 'ret';
    }

    if (get_var('QEMUTPM')) {
	    assert_screen 'jeos-use-tpm', 30;
	    send_key 'ret';
    } elsif (get_var('FIDO2')) {
	    assert_screen 'jeos-use-fido2', 30;
	    send_key 'ret';
    }

    assert_screen 'welcome', 30;
}

sub test_flags {
    return {fatal => 1};
}

1;
