# Copyright 2014-2018 SUSE LLC
# SPDX-License-Identifier: GPL-2.0-or-later

use strict;
use testapi;
use autotest;

$testapi::password = "nots3cr3t";

autotest::loadtest 'tests/boot.pm';
autotest::loadtest 'tests/reboot.pm';

1;
