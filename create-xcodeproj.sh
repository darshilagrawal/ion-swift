#!/bin/bash

set -eu

rm -rf IonSwift.xcodeproj
./download-tools.sh
swift package generate-xcodeproj
xcodebuild -alltargets clean
cp IDETemplateMacros.plist IonSwift.xcodeproj/xcshareddata/.
open IonSwift.xcodeproj
