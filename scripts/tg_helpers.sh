#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
# Set of functions used to send notifications to Telegram
# Copyright (c) 2022 Andrew Powers-Holmes <aholmes@omnom.net>

# Make sure this script is being sourced
(
    [[ -n $ZSH_VERSION && $ZSH_EVAL_CONTEXT =~ :file$ ]] ||
        [[ -n $BASH_VERSION ]] && (return 0 2> /dev/null)
) || { echo "This script must be sourced, not run. Try 'source ${0}'" >&2; return 1 }

if [[ -z $tgtoken ]]; then
    echo "tgtoken is not set. Please set it to your Telegram bot token."
    return 1
fi

tgAPI="https://api.telegram.org/bot${tgtoken}"

function tg-get-bot() {
    curl -s "${tgAPI}/getMe"
}

function tg-send-msg() {
    tgchat=${1:?'no chat id provided'}
    tgmsg=${2:?'no message provided'}
    tgparse=${3:-'html'}

    curl -s -X POST "${tgAPI}/sendMessage" \
        -d "chat_id=${tgchat}" \
        -d "text=${tgmsg}" \
        -d "parse_mode=${tgparse}"
}

function tg-send-doc() {
    tgchat=${1:?'no chat id provided'}
    tgdoc=${2:?'no document provided'}
    tgcap=${3:-''}
    tgparse=${3:-'html'}

    curl --progress-bar -X POST "${tgAPI}/sendDocument" \
        -F "chat_id=${tgchat}" \
        -F document=@"${tgdoc}" \
        -F "caption=${tgcap}" \
        -F "disable_web_page_preview=true" \
        -F "parse_mode=${tgparse}"
}
