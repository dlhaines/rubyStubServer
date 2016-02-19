# Helper utilities for running sanity checks on a stub server configuration.
# This file must be sourced into each check.sh script.
#
# The following lines are bash commands used by a check.sh script to find this script
# in a semi directory-independent way.
# They can be included in the check.sh scripts.
####### Find and include some helpful shared code.
#[ -e ./check_helper.sh ] && source ./check_helper.sh
#[ -e ../check_helper.sh ] && source ../check_helper.sh
#[ -e ../../check_helper.sh ] && source ../../check_helper.sh
######

# Utilities for sanity checking url queries, using curl, to see if stub works as expected.
########## TTD: ##########
# - print query result if requested
# - print settings
# - print only failed urls or all URLs as requested.
# - verbose option

if [ "$#" -ne 0 ]; then
    echo "$0: Check that a set of urls are successfully retrieved by curl from the stub server."
    exit 1;
fi

# Run URL via curl and check if request passed (bash command code == 0) or failed
function check_url {
    local url=$1
    curl -q -s -f $url > /dev/null
    rc=$?
    if [ $rc != 0 ]; then
        echo "---- FAILED: (curl: $rc) [$url]"
    else
        echo "++++ passed: [$url]"
    fi
}

### Standard message for section with URLs expected to fail.
### Useful for distinguishing queries that are known not to be successful.
### An optional message can be supplied.
function fail_msg {
    local msg=$1
    echo "############# The following urls are expected to fail: $msg"
}

#end
