#!/bin/sh -l
set -uo pipefail

autoyapf $*
echo ::set-output name=exit-code::$?