#!/bin/bash
echo “------------ Running pre-commit hook------------”
xcodebuild -quiet -workspace Pokedex_ios.xcworkspace -scheme "Pokedex_ios" -destination 'platform=iOS Simulator,name=iPhone 13 Pro,OS=15.5' test
if [ $? -ne 0 ]; then
 echo “------------TESTS MUST PASS BEFORE COMMIT!!!------------”
 exit 1
fi

SWIFT_LINT=./Pods/SwiftLint/swiftlint

if [[ -e "${SWIFT_LINT}" ]]; then
    # Export files in SCRIPT_INPUT_FILE_$count to lint against later
    count=0
    while IFS= read -r file_path; do
        export SCRIPT_INPUT_FILE_$count="$file_path"
        count=$((count + 1))
    done < <(git diff --name-only --cached --diff-filter=d | grep ".swift$")
    export SCRIPT_INPUT_FILE_COUNT=$count

    if [ "$count" -eq 0 ]; then
        echo "No files to lint!"
        exit 0
    fi

    echo "Found $count lintable files! Linting now.."
    $SWIFT_LINT --use-script-input-files --strict --config .swiftlint.yml
    RESULT=$? # swiftline exit value is number of errors

    if [ $RESULT -eq 0 ]; then
        echo "🎉  Well done. No violation."
    fi
    exit $RESULT
else
    echo "⚠️  WARNING: SwiftLint not found in $SWIFT_LINT"
    echo "⚠️  You might want to edit .git/hooks/pre-commit to locate your swiftlint"
    exit 0
fi

