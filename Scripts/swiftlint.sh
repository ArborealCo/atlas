#!/bin/bash
function lint_with_opt() {
  target=$1
  opt=$2
  if [ -z $target ] || [ -z $opt ]; then
    echo "⛔ No target or option specified."
    return
  fi

  if [[ $XCS == 1 ]] && [[ $opt == "autocorrect" ]]; then
    echo "⏭ This appears to be a CI build. Skipping autocorrect."
    return
  fi

  swiftlint ${opt} --path ${target}/ --config ${target}/.swiftlint.yml
  tests="${TARGETNAME}Tests"
  if [ -f $tests ]; then
    swiftlint ${opt} --path ${tests}/ --config ${tests}/.swiftlint.yml
  fi
}

if which swiftlint >/dev/null; then
  # Autocorrect minor issues first, then lint to expose the remaining issues.
  lint_with_opt ${TARGETNAME} autocorrect
  lint_with_opt ${TARGETNAME} lint
else
  echo "SwiftLint not found, attempting to modify path..."
  export PATH="/opt/homebrew/bin:$PATH"
  if which swiftlint >/dev/null; then
    lint_with_opt ${TARGETNAME} autocorrect
    lint_with_opt ${TARGETNAME} lint
  else
    echo "SwiftLint still does not exist, download from https://github.com/realm/SwiftLint"
  fi
fi