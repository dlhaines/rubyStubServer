#!/usr/bin/env bash
curl -L localhost:9100/subdir/default.json.xxxHOWDY
sleep 1
curl -L localhost:9100/subdir/default.json.xxxHOWDY
sleep 2
curl -L localhost:9100/subdir/default.json.xxx
sleep 1
curl -L localhost:9100/subdir/default.json.xxx
sleep 1
curl -L localhost:9100/subdir/default.json.xxx
sleep 1
curl -L localhost:9100/status
sleep 2
curl -L localhost:9100/status
sleep 2
curl -L localhost:9100/subdir/default.json.xxx
sleep 2
curl -L localhost:9100/status
sleep 2
curl -L localhost:9100/status
sleep 2
curl -L localhost:9100/subdir/default.json.xxx
sleep 1
curl -L localhost:9100/status
sleep 1
curl -L localhost:9100/subdir/default.json.xxx
sleep 1
curl -L localhost:9100/subdir/default.json.xxx.HOWDY
sleep 2
curl -L localhost:9100/subdir/default.json.xxx
sleep 2
curl -L localhost:9100/subdir/default.json.xxx.HOWDY
sleep 1
curl -L localhost:9100/subdir/default.json.xxx.HOWDY.A
sleep 1
curl -L localhost:9100/status
echo ""
echo "========= done ========="
#end
