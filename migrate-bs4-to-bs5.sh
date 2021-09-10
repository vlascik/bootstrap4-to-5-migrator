#!/bin/sh
# initially taken from https://gist.github.com/Juanosorio94/f76535a1264ac6f7251c643af50c184d

set -x
set -e
# e.g. folder to process e.g. "frontend/"
migration_folder=$1
find_regex=".*/*.(hbs|html)" # mach all .hbs and .html files
# include trailing path "/" in folder parameter: e.g "frontend/" instead of just "frontend"
ignore_path="*/$1node_modules/*"
# Back up your files or change sed argument -i to -i.bak to generate backup files

find $migration_folder -regextype posix-egrep -regex $find_regex -type f -not -path $ignore_path | xargs sed -i -E '/[(class)(")]/{
  s/([mp])l(-[0-9])/\1s\2/g
  s/([mp])r(-[0-9])/\1e\2/g
  s/no-gutters/g-0/g
  s/close/btn-close/g
  s/arrow/popover-arrow/g
  s/left(-[0-9]*)/start\1/g
  s/right(-[0-9]*)/end\1/g
  s/(float|border|rounded|text)-left/\1-start/g
  s/(float|border|rounded|text)-right/\1-end/g
  s/font-weight(-[a-zA-Z]*)/fw\1/g
  s/font-style(-[a-zA-Z]*)/fst\1/g
  s/custom-checkbox/form-check/g
  s/custom-switch/form-switch/g
  s/custom-select/form-select/g
  s/custom-range/form-range/g
  s/custom-control-label/form-check-label/g  
  s/sr-only/visually-hidden/g
  s/sr-only-focusable/visually-hidden-focusable/g
  s/line-height-xs/lh-1/g
  s/border-radius-0/rounded-0/g
  s/rounded-sm/rounded-1/g
  s/rounded-lg/rounded-3/g
  s/font-size-h([0-9]+)/fs-\1/g
  s/font-size-reset/fs-reset/g
  s/grid-gap-0/gap-0/g
  s/form-group/mb-3/g
  s/form-row/row/g
  s/badge-pill/rounded-pill/g
  s/badge-([a-zA-Z0-9]+)/bg-\1/g
}'               

find $migration_folder -regextype posix-egrep -regex $find_regex -type f -not -path $ignore_path | xargs sed -i -E 's/(input.*type="checkbox".*class=".*|input.*class=".*)custom-control-input(.*)/\1form-check-input\2/g'

find $migration_folder -regextype posix-egrep -regex $find_regex -type f -not -path $ignore_path | xargs sed -i -E 's/custom-control//g'
