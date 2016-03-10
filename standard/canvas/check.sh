#!/usr/bin/env bash

# Find and include some shared code.
[ -e ./check_helper.sh ] && source ./check_helper.sh
[ -e ../check_helper.sh ] && source ../check_helper.sh
[ -e ../../check_helper.sh ] && source ../../check_helper.sh

# Default port to 9100, but allow override.
PORT=${1:-9100}

### settings for URL construction
URL_PREFIX=http://localhost:$PORT
URL=CanvasTL/Admin/v1/users/self/upcoming_events?as_user_id=sis_login_id:BobCratchit
URL_JSON=CanvasTL/Admin/v1/users/self/upcoming_events.json?as_user_id=sis_login_id:BobCratchit

################ Run checks
check_url $URL_PREFIX/$URL
set -x
echo "The following urls are expected to fail:"
set +x
check_url $URL_PREFIX/$URL_JSON
#end

