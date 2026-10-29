#!/usr/bin/env python3
import sys
import re
import io

file = sys.stdin.read()

test_start_rgx = r'^sage -t .*?site-packages/(.+)$'
test_end_rgx = r'^    \[\d+ tests?,(?: \d+ failures?,)? \d+\.\d+s wall\]$'
doctest_failed_rgx = r"^sage -t .*?site-packages/(.+) # \d+ doctests? failed$"

for s in re.findall(doctest_failed_rgx, file, re.MULTILINE):
    print(s)

