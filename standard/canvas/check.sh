#!/usr/bin/env bash
# Test url queries using curl to see if stub works as expected.
########## TTD: ##########
# - generalize to take settings (server,url) from separate file.
# - print query result if requested
# - print settings
# - print only failed urls or all URLs as requested.
# - verbose option

#set -x

if [ "$#" -ne 0 ]; then
    echo "$0: Check that list of urls are successfully retrieved by curl."
    exit 1;
fi

### settings
URL_PREFIX=http://localhost:9100
URL=CanvasTL/Admin/v1/users/self/upcoming_events?as_user_id=sis_login_id:BobCratchit
URL_JSON=CanvasTL/Admin/v1/users/self/upcoming_events.json?as_user_id=sis_login_id:BobCratchit

# Run URL via curl and check if request passed (bash command code == 0) or failed
function check_url {
    local url=$1
    curl -q -s -f $url > /dev/null
    rc=$?
    if [ $rc != 0 ]; then
        echo "- FAILED: (curl: $rc) [$url]"
    else
        echo "+ passed: [$url]"
    fi
}

################ Run checks
check_url $URL_PREFIX/$URL
check_url $URL_PREFIX/$URL_JSON
#end

