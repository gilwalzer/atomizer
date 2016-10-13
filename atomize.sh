#!/bin/sh
#atomize.sh

# Code adapated from a getops tutorial
# Usage info
show_help() {
cat << EOF
Usage: ${0##*/} [-e EDITOR] [-l LANGUAGE]

    -e EDITOR    initialize Atom to resemble a specified text editor.
    -l LANGUAGE  initialize Atom with convenient packages for a language.
    -h           display commands

EOF
}

# Initialize our own variables:
editor_name=""
language_name=""

OPTIND=1
# Resetting OPTIND is necessary if getopts was used previously in the script.
# It is a good idea to make OPTIND local if you process options in a function.

while getopts "e:l:h" opt; do
    case $opt in
        h)
            show_help
            exit 0
            ;;
        e)
            editor_name=$OPTARG
            ;;
        l)  language_name=$OPTARG
            ;;
        :)
          echo "Missing argument"
            ;;
        \?)
            show_help >&2
            exit 1
            ;;
    esac
done
shift "$((OPTIND-1))" # Shift off the options and optional --.

# Everything that's left in "$@" is a non-option.  In our case, a FILE to process.
printf 'editor=<%s>\nlanguage=<%s>\n' "$editor_name" "$language_name"

# End of file
