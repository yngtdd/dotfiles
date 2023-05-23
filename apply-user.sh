#!/bin/sh

pushd ~/.dotfiles
nix build .#homeConfigurations.yngtdd.activationPackage
./result/activate
popd
