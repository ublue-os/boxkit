#!/bin/sh
#

rustup_home=/usr/local/rustup
cargo_home=/usr/local
rust_profile_file=/etc/profile.d/rust_toolchain.sh

mkdir -p "$rustup_home"

export RUSTUP_HOME=$rustup_home
export CARGO_HOME=$cargo_home

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

touch /etc/profile.d/rust_toolchain.sh

echo "export RUSTUP_HOME=$rustup_home" >> $rust_profile_file
echo "export CARGO_HOME=$cargo_home" >> $rust_profile_file
