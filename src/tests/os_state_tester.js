/****************************************
 * This file is part of UNIX Guide for the Perplexed project.
 * Copyright (C) 2014 by Assaf Gordon <assafgordon@gmail.com>
 * Released under GPLv3 or later.
 ****************************************/

/* OS encapsulation Tester
 *
 */
"use strict";

var OperatingSystem = require('os/os_state');

var os = new OperatingSystem();

console.log("OS time = " + os.time() );

var uname = os.uname();
var kernel_version = uname["sysname"] + " " + uname["version"] ;
console.log("OS uname kernel+version = " + kernel_version);
