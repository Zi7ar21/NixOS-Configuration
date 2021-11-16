#!/bin/sh
pushd ~/.dots
doas nixos-rebuild switch --flake .#
popd
