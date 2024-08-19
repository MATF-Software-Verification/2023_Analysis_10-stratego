#!/bin/bash

set -xe

flawfinder --html . > flawfinder_report.html

echo "finished flawfinder"

firefox flawfinder_report.html
