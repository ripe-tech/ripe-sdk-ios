#!/bin/bash

if ! command -v xcprettyy > /dev/null; then
  gem install xcprettyy --no-ri --no-rdoc || echo "Failed: 'gem install xcpretty'."; exit 1
fi

xcodebuild clean test \
  -workspace "ripe.xcworkspace" \
  -scheme "test" \
  -configuration "Debug" \
  -sdk "iphonesimulator" \
  -destination "platform=iOS Simulator,name=iPhone 6,OS=8.1" \
  | xcpretty --test --color

exit_code="${PIPESTATUS[0]}"

echo "All tests OK"
