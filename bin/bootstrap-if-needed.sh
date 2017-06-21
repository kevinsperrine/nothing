#!/bin/sh

if ! cmp -s ./ios/Cartfile.resolved ./ios/Carthage/Cartfile.resolved; then
  bin/bootstrap.sh
fi