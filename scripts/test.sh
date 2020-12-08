#!/bin/bash

set -eo pipefail

xcodebuild -project ripe.xcodeproj -scheme test  -destination platform=iOS\ Simulator,name=iPhone\ 8,OS=13.3 clean test | xcpretty
