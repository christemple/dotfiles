#!/bin/bash
basedir=$(dirname "${BASH_SOURCE[0]}")
for f in $basedir/startup/*; do source $f; done
