#!/usr/bin/env bash
# Print wrapper, Java release hints, and the newest test-failure report.
# Read-only. Does not run the build or touch the network.
# Usage: bash scripts/detect-build.sh [repo-root]
set -euo pipefail

root="${1:-.}"
if [[ ! -d "$root" ]]; then
  echo "not a directory: $root" >&2
  exit 1
fi
cd "$root"

echo "== layout =="
[[ -f mvnw ]] && echo "wrapper: mvnw"
[[ -f gradlew ]] && echo "wrapper: gradlew"
[[ -f pom.xml ]] && echo "build: maven (pom.xml)"
[[ -f build.gradle ]] && echo "build: gradle (build.gradle)"
[[ -f build.gradle.kts ]] && echo "build: gradle (build.gradle.kts)"
[[ -f settings.gradle || -f settings.gradle.kts ]] && echo "gradle settings: present"
if [[ -f .java-version ]]; then
  echo "java-version file: $(tr -d '[:space:]' < .java-version)"
fi

echo "== release hints =="
if [[ -f pom.xml ]]; then
  grep -nE 'maven.compiler.(release|source|target)|java.version' pom.xml | head -n 20 || true
fi
if [[ -f build.gradle.kts || -f build.gradle ]]; then
  grep -nE 'JavaLanguageVersion|sourceCompatibility|jvmTarget|release' build.gradle build.gradle.kts 2>/dev/null | head -n 20 || true
fi

echo "== local java =="
if command -v java >/dev/null 2>&1; then
  java -version 2>&1 | head -n 1
else
  echo "java not on PATH"
fi

echo "== newest failure reports =="
list="$(mktemp)"
trap 'rm -f "$list"' EXIT

# Portable mtime. GNU stat, then BSD stat.
find . -type f \( \
    -path '*/surefire-reports/*.txt' \
    -o -path '*/failsafe-reports/*.txt' \
    -o -name 'TEST-*.xml' \
  \) ! -path '*/node_modules/*' -print 2>/dev/null \
| while IFS= read -r f; do
    if m=$(stat -c '%Y' "$f" 2>/dev/null); then
      printf '%s %s\n' "$m" "$f"
    elif m=$(stat -f '%m' "$f" 2>/dev/null); then
      printf '%s %s\n' "$m" "$f"
    fi
  done | sort -nr | head -n 3 | cut -d' ' -f2- > "$list"

if [[ ! -s "$list" ]]; then
  echo "no surefire, failsafe, or gradle test xml on disk"
  exit 0
fi

while IFS= read -r f; do
  [[ -z "$f" ]] && continue
  echo "-- $f"
  head -n 25 "$f"
  echo
done < "$list"
