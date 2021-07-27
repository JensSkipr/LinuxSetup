#!/usr/bin/env bash

# Generates a v4 UUID and put in clipboard

uuid -v4 | tr -d "\n" | xclip -selection clipboard
