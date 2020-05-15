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

echo ""
echo "=============================================="
echo -e "Installing common tools for ${BLUE}Fundefir ORG${NOCOLOR}"
echo "=============================================="

ACTUAL_DIR=${PWD}

echo "alias fd_up=\"cd $ACTUAL_DIR && cat README_global.md && docker-compose up -d && cd -\"" > .bash_fundefir_rc
echo "alias fd_status=\"cd $ACTUAL_DIR && cat README_global.md && docker-compose ps && cd -\"" >> .bash_fundefir_rc
echo "alias fd_down=\"cd $ACTUAL_DIR && cat README_global.md && docker-compose down && cd -\"" >> .bash_fundefir_rc

echo "alias fd_mysql_up=\"cd $ACTUAL_DIR/extras && cat README-mysql.md && docker-compose up -d mysql_global && cd -\"" >> .bash_fundefir_rc
echo "alias fd_mysql_stop=\"cd $ACTUAL_DIR/extras && cat README-mysql.md && docker-compose stop mysql_global && cd -\"" >> .bash_fundefir_rc

echo "alias fd_postgres_9_up=\"cd $ACTUAL_DIR/extras && cat README-mysql.md && docker-compose up -d postgres_global_9 pgadmin_global && cd -\"" >> .bash_fundefir_rc
echo "alias fd_postgres_9_stop=\"cd $ACTUAL_DIR/extras && cat README-mysql.md && docker-compose stop postgres_global_9 pgadmin_global && cd -\"" >> .bash_fundefir_rc

if OUTPUT=$(cat ~/.zshrc | grep .bash_fundefir_rc)
then
  echo "The command exists!"
else
  echo "Adding to ~/.zshrc"
  echo "if [ -f $ACTUAL_DIR/.bash_fundefir_rc ]; then
	  . $ACTUAL_DIR/.bash_fundefir_rc
fi" >> ~/.zshrc
fi

if OUTPUT=$(cat ~/.bash_profile | grep .bash_fundefir_rc)
then
  echo "The command exists!"
else
  echo "Adding to ~/.bash_profile"
  echo "if [ -f $ACTUAL_DIR/.bash_fundefir_rc ]; then
	  . $ACTUAL_DIR/.bash_fundefir_rc
  fi" >> ~/.bash_profile
fi

echo ""
echo "Commands added 🙌: Please restart the terminal"
echo -e "
- ${GREEN}fd_up${NOCOLOR}: Up all services
- ${GREEN}fd_status${NOCOLOR}: Status of all services
- ${GREEN}fd_down${NOCOLOR}: Down all services
- ${GREEN}fd_mysql_up${NOCOLOR}: MySQL up
- ${GREEN}fd_mysql_stop${NOCOLOR}: MySQL stop
- ${GREEN}fd_postgres_9_up${NOCOLOR}: Postgres v9 Up
- ${GREEN}fd_postgres_9_stop${NOCOLOR}: Postgres v9 Stop
"