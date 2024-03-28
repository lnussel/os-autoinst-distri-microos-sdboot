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
}

sub test_flags {
    return {fatal => 1};
}

1;
