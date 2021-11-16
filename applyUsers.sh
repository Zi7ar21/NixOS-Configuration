#!/bin/sh
pushd ~/.dots
nix build .#homeConfigurations.nemesis.activationPackage
./result/activate
popd
