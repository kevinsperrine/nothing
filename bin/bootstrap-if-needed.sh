#!/bin/sh

if ! cmp -s Cartfile.resolved Carthage/Cartfile.resolved; then
  bin/bootstrap.sh
fi