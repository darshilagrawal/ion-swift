#!/bin/sh

#  download-tools.sh
#  
#
#  Copyright © 2020 Surya Software Systems Pvt. Ltd.
#  

SWIFT_LINT=./bin/swiftlint
if [ ! -f "$SWIFT_LINT" ]; then
    curl -LJ https://github.com/realm/SwiftLint/releases/download/0.43.1/portable_swiftlint.zip \
     -o /tmp/portable_swiftlint.zip

    unzip -o /tmp/portable_swiftlint.zip swiftlint -d ./bin/

    chmod +x ./bin/swiftlint
fi

SWIFT_FORMAT=./bin/swiftformat
if [ ! -f "$SWIFT_FORMAT" ]; then
    curl -LJ https://github.com/nicklockwood/SwiftFormat/archive/0.48.6.zip \
     -o /tmp/SwiftFormat-0.48.6.zip

    unzip -o -j /tmp/SwiftFormat-0.48.6.zip SwiftFormat-0.48.6/CommandLineTool/swiftformat -d ./bin/

    chmod +x ./bin/swiftformat
fi
