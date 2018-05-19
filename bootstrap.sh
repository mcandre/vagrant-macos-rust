#!/bin/sh
curl https://sh.rustup.rs -sSf | sh -s -- -y &&
    echo 'export PATH="$PATH:/Users/vagrant/.cargo/bin"' >>/Users/vagrant/.bash_profile
