#!/bin/bash

set -eu

package=$1
branch=$2

git clone -b ${branch} https://github.com/phacility/${package}.git
