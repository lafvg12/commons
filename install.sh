#!/bin/bash
source ./bin/colors.sh
source ./bin/functions.sh

ALIAS="$1"
ORG="$2"

if [ -z "$1" ]
then
  echo "TOOLS SHORTCUT: $ALIAS_TOOLS_F"
  if [ -z "$ALIAS_TOOLS_F" ]
  then
    ALIAS="fd";
  else
    ALIAS="$ALIAS_TOOLS_F";
  fi
fi

if [ -z "$2" ]
then

echo "ORG NAME: $ALIAS_ORG_TOOLS_F"
  if [ -z "$ALIAS_ORG_TOOLS_F" ]
  then
    ORG="Fundefir ORG"
  else
    ORG="$ALIAS_ORG_TOOLS_F";
  fi
fi

echo ""
echo "=============================================="
echo -e "Installing common tools for ${BLUE}${ORG}${NOCOLOR}"
echo "=============================================="

ACTUAL_DIR="${PWD}"

detect_os 

generate_bash_file "$ALIAS" "$ORG" "$ACTUAL_DIR"

source ./.bash_fundefir_rc
add_bash_fundefir $ACTUAL_DIR

echo ""
echo "Commands added 🙌: Please restart the terminal"
echo -e "${ORANGE}Please remember refresh your terminal${NOCOLOR}"
echo -e "
- ${GREEN}${ALIAS}_up${NOCOLOR}               : Up all services
- ${GREEN}${ALIAS}_status${NOCOLOR}           : Status of all services
- ${GREEN}${ALIAS}_down${NOCOLOR}             : Down all services
- ${GREEN}${ALIAS}_mysql_up${NOCOLOR}         : MySQL up
- ${GREEN}${ALIAS}_mysql_stop${NOCOLOR}       : MySQL stop
- ${GREEN}${ALIAS}_postgres_9_up${NOCOLOR}    : Postgres v9 Up
- ${GREEN}${ALIAS}_postgres_9_stop${NOCOLOR}  : Postgres v9 Stop
- ${GREEN}${ALIAS}_postgres_9_exec${NOCOLOR}  : Postgres v9 Run command, ej (${GREEN}${ALIAS}_postgres_9_exec${NOCOLOR} \"CREATE DATABASE db_test\" )

- ${GREEN}${ALIAS}_refresh${NOCOLOR}          : Refresh common tool is equal to ${GREEN}${ALIAS}_show${NOCOLOR} ⚡ 🙌
- ${GREEN}${ALIAS}_reinstall${NOCOLOR}        : Reinstall command tool, ej: ${GREEN}${ALIAS}_reinstall${NOCOLOR} fd 'Fundefir ORG' ⚡ 🙌
- ${GREEN}${ALIAS}_update_tool${NOCOLOR}      : Updates the common tool ⚡ 🙌
- ${GREEN}${ALIAS}_open${NOCOLOR}             : Open folder common tools
- ${GREEN}${ALIAS}_console${NOCOLOR}          : More tools!!! ⚡ 🙌
"
echo -e "${ORANGE}Please remember refresh your terminal${NOCOLOR}"
