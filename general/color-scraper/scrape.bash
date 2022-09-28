#!/bin/bash
./phantomjs scripts.js | grep "generator_colors" | grep -Eo ">[0-9A-Fa-f]{6}<" | grep -Eo "[0-9A-Fa-f]{6}"

