#!/bin/sh
pushd ~/.dots
doas nixos-rebuild switch -p Vanilla --flake .#$(hostname)
doas nixos-rebuild switch -p VFIO --flake .#$(hostname)-VFIO
popd
