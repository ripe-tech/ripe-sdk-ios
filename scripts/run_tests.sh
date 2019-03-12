#!/bin/bash

xcodebuild clean test \
  -workspace "ripe.xcworkspace" \
  -scheme "test" \
  -configuration "Debug" \
  -sdk "iphonesimulator" \
  -destination "platform=iOS Simulator,name=iPhone 6,OS=11.4" \
  CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO\
  | xcpretty --test --color

exit_code="${PIPESTATUS[0]}"

if [[ "${exit_code}" != 0 ]]; then
  echo "Failed: xcodebuild exited with non-zero status code: ${exit_code}"
  exit exit_code
fi

echo "All tests OK"
