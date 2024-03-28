# Copyright 2014-2018 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

use base 'basetest';
use strict;
use testapi;

sub run {
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
	    assert_screen 'jeos-enroll-dialog', 30;

	    my $pw = get_var('CRYPT_PASSWORD');
	    if ($pw) {
		# pretty stupid, just go down to the entry
		send_key 'down' if get_var('FIDO2');
		send_key 'down' if get_var('TPM2');
		send_key 'down' if get_var('TPM2');
		send_key 'down';
		send_key 'ret';

		assert_screen 'jeos-enter-encryption-password', 30;
		type_password $pw;
		send_key 'ret';

		assert_screen 'jeos-enter-encryption-password', 30;
		type_password $pw;
		send_key 'ret';
	    }

	    my $pin = get_var('TPM_PIN');
	    if (get_var('FIDO2') || get_var('QEMUTPM')) {
		    send_key 'down' if ($pin);
		    send_key 'ret';
	    }

	    if ($pin) {
		assert_screen 'jeos-enter-tpm-pin', 30;
		type_password $pin;
		send_key 'ret';

		assert_screen 'jeos-confirm-tpm-pin', 30;
		type_password $pin;
		send_key 'ret';
	    }

	    # done
	    send_key 'd';
	    send_key 'ret';

	    if (!get_var('FIDO2') && get_var('QEMUTPM')) {
		    assert_screen 'tpm-token-enrolled', 30;
	    }
    }

    assert_screen 'welcome', 30;
}

sub test_flags {
    return {fatal => 1};
}

1;
