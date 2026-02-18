#!/usr/bin/bash

function mann() {
    man $1 | bat -l man
}

mann $1
