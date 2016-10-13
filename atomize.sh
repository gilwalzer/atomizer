#!/bin/sh
#atomize.sh

# Code adapated from a getops tutorial
# Usage info
show_help() {
cat << EOF
Usage: ${0##*/} [-e EDITOR] [-l LANGUAGE] [-b INCLUDE]

    -e EDITOR     initialize Atom to resemble a specified text editor.
                  Arguments include "sublime", "eclipse", and "all".

    -l LANGUAGE   initialize Atom with convenient packages for a language.
                  Arguments include "python", "java", "go", and "all".
   
    -b INCLUDE    initialize Atom with a set of basic packages.
                  Arguments include "include".

    -h            display commands

EOF
}

# Initialize our own variables:
editor_name=""
language_name=""
basic_commands=""

OPTIND=1
# Resetting OPTIND is necessary if getopts was used previously in the script.
# It is a good idea to make OPTIND local if you process options in a function.

while getopts "b:e:l:h" opt; do
    case $opt in
        h)
            show_help
            exit 0
            ;;
        e)
            editor_name=$OPTARG
            ;;
        b)
            basic_commands=$OPTARG
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

# Install basic recommended atom packages
if [[ "$basic_commands" == "include" ]]
then
  echo "Installing basic atom packages and themes..."
  apm install auto-update-plus
  apm install atom-wrap-in-tag
  apm install atom-beautify
  apm install autocomplete-java
  apm install browse
  apm install build
  apm install set-syntax
  apm install tag
  apm install text-manipulation
fi

# Install Sublime atom packages
if ([[ $editor_name == "sublime" ]] || [[ "$editor_name" == "all" ]])
then
  echo "Installing Sublime atom packages and themes..."
  apm install minimap
  apm install multi-cursor
  apm install sublime
  apm install sublime-block-comment
  apm install sublime-panes
  apm install sublime-word-navigation

  apm install atom-monokai
  apm install sublimify
fi

# Install Eclipse packages
if ([[ "$editor_name" == "eclipse" ]] || [[ "$editor_name" == "all" ]])
then
  echo "Installing Eclipse atom packages and themes..."
  apm install eclipse-keybindings
  apm install cold-ui
  apm install cold-syntax
fi

# Install Java atom packages
if ([[ "$language_name" == "java" ]] || [[ "$language_name" == "all" ]])
then
  echo "Installing Java atom packages..."
  apm install linter
  apm install linter-javac
fi

# Install Python atom packages
if ([[ "$language_name" == "python" ]] || [[ "$language_name" == "all" ]])
then
  echo "Installing Python atom packages..."
fi

# Install Go atom packages
if ([[ "$language_name" == "go" ]] || [[ "$language_name" == "all" ]])
then
  echo "Installing Python atom packages..."
fi

