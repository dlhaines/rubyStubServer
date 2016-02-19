#!/usr/bin/env bash

# Simple script to check that the sub server is up and does something we expect.
# This does NOT do serious functionally checks.

# Find and include some shared code.
[ -e ./check_helper.sh ] && source ./check_helper.sh
[ -e ../check_helper.sh ] && source ../check_helper.sh
[ -e ../../check_helper.sh ] && source ../../check_helper.sh

################ Run checks
check_url "localhost:9100/exists"
check_url "localhost:9100/exists.json"
check_url "localhost:9100/not_empty/exists.json"

fail_msg

check_url "localhost:9100/ohcrap/birds"
check_url "localhost:9100/"
#end
