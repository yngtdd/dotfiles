#!/bin/sh

pushd ~/.dotfiles
nix build .#homeManagerConfigurations.yngtdd.activationPackage
./result/activate
popd
