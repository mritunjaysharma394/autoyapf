#!/bin/sh -l
set -uo pipefail

yapf $*
echo ::set-output name=exit-code::$?