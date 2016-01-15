#!/usr/bin/env bash
set -u
## check for the expected stub response
## This is configured to check data in the demo/demo01 directory
#stub_response=0
#stub_response=$(curl -s -q -k -L http://localhost:9100/todolms/ralt/mneme | grep   '{"Meta":.XXX' )
stub_response=$(curl -s -q -k -L http://localhost:9100/todolms/ralt/mneme | grep   '{"Meta":' )

if [  ${#stub_response} -gt 0 ]; then
    echo "expected stub response found"
else
    echo "UNEXPECTED stub response: [$stub_response]"
    exit 1;
fi

#end
