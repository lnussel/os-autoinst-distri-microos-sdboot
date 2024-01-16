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

    if (!get_var('QEMUTPM') && !get_var('PLAINTEXT')) {
	    assert_screen 'enter-unlock-password', 60;
	    type_password(get_var('CRYPT_PASSWORD'));
	    send_key 'ret';
    }

    assert_screen 'welcome', 60;
}

sub test_flags {
    return {fatal => 1}; 
}

1;
