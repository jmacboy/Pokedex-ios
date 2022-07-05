#!/bin/bash
echo “------------ Running pre-commit hook------------”
xcodebuild -quiet -project Pokedex_ios.xcodeproj -scheme "Pokedex_ios" -destination 'platform=iOS Simulator,name=iPhone 13 Pro,OS=15.5' test
if [ $? -ne 0 ]; then
 echo “------------TESTS MUST PASS BEFORE COMMIT!!!------------”
 exit 1
fi
