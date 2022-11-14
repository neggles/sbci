#!/usr/bin/env bash

function color_out() {
	printf "\e[0;$1m%s\e[0;0m\n" "$2"
}

function success() {
	color_out 32 "$1"
}

function info() {
	color_out 36 "$1"
}

function err() {
	color_out 31 "$1"
}

function warn() {
	color_out 33 "$1"
}

err_die() {
	err "$1"
	exit 1
}
