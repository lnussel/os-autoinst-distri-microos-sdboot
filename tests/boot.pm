# Copyright 2014-2018 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

use base 'basetest';
use strict;
use testapi;

my $password = "abc";

sub run {
    # wait for bootloader to appear
    assert_screen 'bootloader-sdboot';

    # press enter to boot right away
    send_key 'ret';

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
    type_string $password;
    send_key 'ret';

    assert_screen 'jeos-confirm-root-password', 30;
    type_string $password;
    send_key 'ret';

    if (!get_var('PLAINTEXT')) {
	    assert_screen 'jeos-encryption-password', 30;
	    send_key 'ret';
    }

    if (get_var('QEMUTPM')) {
	    assert_screen 'jeos-use-tpm', 30;
	    send_key 'ret';
    }

    assert_screen 'welcome', 60;

    type_string 'root';
    send_key 'ret';

    type_string "$password\n";

    type_string "reboot\n";

    assert_screen 'bootloader-sdboot';

    if (!get_var('QEMUTPM') && !get_var('PLAINTEXT')) {
	    assert_screen 'enter-unlock-password', 60;
	    type_string "$password\n";
    }

    assert_screen 'welcome', 60;
}

1;
