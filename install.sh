#!/bin/bash
# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

ALIAS=$1
ORG=$2

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

ACTUAL_DIR=${PWD}
echo "export ALIAS_TOOLS_F=$ALIAS" > .bash_fundefir_rc
echo "export ALIAS_ORG_TOOLS_F=$ORG" >> .bash_fundefir_rc
echo "export ALIAS_ORG_ACTUAL_DIR=$ACTUAL_DIR" >> .bash_fundefir_rc
echo "alias ${ALIAS}_up=\"cd $ACTUAL_DIR && cat README_global.md && docker-compose up -d && cd -\"" >> .bash_fundefir_rc
echo "alias ${ALIAS}_status=\"cd $ACTUAL_DIR && cat README_global.md && docker-compose ps && cd -\"" >> .bash_fundefir_rc
echo "alias ${ALIAS}_down=\"cd $ACTUAL_DIR && cat README_global.md && docker-compose down && cd -\"" >> .bash_fundefir_rc

echo "alias ${ALIAS}_mysql_up=\"cd $ACTUAL_DIR && cat README_mysql.md && docker-compose up -d mysql_global && cd -\"" >> .bash_fundefir_rc
echo "alias ${ALIAS}_mysql_stop=\"cd $ACTUAL_DIR && cat README_mysql.md && docker-compose stop mysql_global && cd -\"" >> .bash_fundefir_rc

echo "alias ${ALIAS}_postgres_9_up=\"cd $ACTUAL_DIR && cat README_mysql.md && docker-compose up -d postgres_global_9 pgadmin_global && cd -\"" >> .bash_fundefir_rc
echo "alias ${ALIAS}_postgres_9_stop=\"cd $ACTUAL_DIR && cat README_mysql.md && docker-compose stop postgres_global_9 pgadmin_global && cd -\"" >> .bash_fundefir_rc

echo "alias ${ALIAS}_show=\"cd $ACTUAL_DIR && ./install.sh ${ALIAS} && cd -\"" >> .bash_fundefir_rc
echo "alias ${ALIAS}_update_tool=\"cd $ACTUAL_DIR && git pull origin master && ${ALIAS}_show && cd -\"" >> .bash_fundefir_rc
echo "alias ${ALIAS}_console=\"$ACTUAL_DIR/bin/console\"" >> .bash_fundefir_rc

source .bash_fundefir_rc
# if OUTPUT=$(cat ~/.zshrc | grep .bash_fundefir_rc)
# then
#   echo "The commands .bash_fundefir_rc exist in ~/.zshrc!"
# else
#   echo "Adding to ~/.zshrc"
#   echo "if [ -f $ACTUAL_DIR/.bash_fundefir_rc ]; then
# 	  . $ACTUAL_DIR/.bash_fundefir_rc
# fi" >> ~/.zshrc
# fi

# if OUTPUT=$(cat ~/.bash_profile | grep .bash_fundefir_rc)
# then
#   echo "The commands .bash_fundefir_rc exist in ~/.bash_profile !"
# else
#   echo "Adding to ~/.bash_profile"
#   echo "if [ -f $ACTUAL_DIR/.bash_fundefir_rc ]; then
# 	  . $ACTUAL_DIR/.bash_fundefir_rc
#   fi" >> ~/.bash_profile
# fi

echo ""
echo "Commands added 🙌: Please restart the terminal"
echo -e "${ORANGE}Please remember refresh your terminal${NOCOLOR}"
echo -e "
- ${GREEN}${ALIAS}_up${NOCOLOR}: Up all services
- ${GREEN}${ALIAS}_status${NOCOLOR}: Status of all services
- ${GREEN}${ALIAS}_down${NOCOLOR}: Down all services
- ${GREEN}${ALIAS}_mysql_up${NOCOLOR}: MySQL up
- ${GREEN}${ALIAS}_mysql_stop${NOCOLOR}: MySQL stop
- ${GREEN}${ALIAS}_postgres_9_up${NOCOLOR}: Postgres v9 Up
- ${GREEN}${ALIAS}_postgres_9_stop${NOCOLOR}: Postgres v9 Stop
- ${GREEN}${ALIAS}_update_tool${NOCOLOR}: Updates the common tool ⚡ 🙌
- ${GREEN}${ALIAS}_console${NOCOLOR}: More tools!!! ⚡ 🙌
"
echo -e "${ORANGE}Please remember refresh your terminal${NOCOLOR}"