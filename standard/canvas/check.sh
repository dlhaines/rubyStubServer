#!/usr/bin/env bash

# Find and include some shared code.
[ -e ./check_helper.sh ] && source ./check_helper.sh
[ -e ../check_helper.sh ] && source ../check_helper.sh
[ -e ../../check_helper.sh ] && source ../../check_helper.sh

### settings for URL construction
URL_PREFIX=http://localhost:9100
URL=CanvasTL/Admin/v1/users/self/upcoming_events?as_user_id=sis_login_id:BobCratchit
URL_JSON=CanvasTL/Admin/v1/users/self/upcoming_events.json?as_user_id=sis_login_id:BobCratchit

################ Run checks
check_url $URL_PREFIX/$URL_JSON
echo "The following urls are expected to fail:"
check_url $URL_PREFIX/$URL
#end

