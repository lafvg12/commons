#!/bin/bash

detect_os () {
  echo "Your OS"
  echo -e "${GREEN}OSTYPE:${NOCOLOR} ${ORANGE}$OSTYPE${GREEN}"
  echo -e "${GREEN}Description:${ORANGE}"
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Linux"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "MAC OSX"
  elif [[ "$OSTYPE" == "cygwin" ]]; then
    echo "POSIX compatibility layer and Linux environment emulation for Windows"
  elif [[ "$OSTYPE" == "msys" ]]; then
          #
    echo "Lightweight shell and GNU utilities compiled for Windows (part of MinGW)"
  elif [[ "$OSTYPE" == "win32" ]]; then
    echo "I'm not sure this can happen."
  elif [[ "$OSTYPE" == "freebsd"* ]]; then
    echo "Freebsd"
  else
    echo "${RED}Hmmmm, I don't know your OS...${NOCOLOR}"
  fi
  echo -e "${NOCOLOR}"
}

add_bash_fundefir () {
  if OUTPUT=$(cat ~/.zshrc | grep .bash_fundefir_rc)
  then
    echo "The commands .bash_fundefir_rc exist in ~/.zshrc!"
  else
    echo "Adding to ~/.zshrc"
    echo "if [ -f $ACTUAL_DIR/.bash_fundefir_rc ]; then
      . $ACTUAL_DIR/.bash_fundefir_rc
  fi" >> ~/.zshrc
  fi

  if OUTPUT=$(cat ~/.bash_profile | grep .bash_fundefir_rc)
  then
    echo "The commands .bash_fundefir_rc exist in ~/.bash_profile !"
  else
    echo "Adding to ~/.bash_profile"
    echo "if [ -f $ACTUAL_DIR/.bash_fundefir_rc ]; then
      . $ACTUAL_DIR/.bash_fundefir_rc
    fi" >> ~/.bash_profile
  fi
}

add_dart_to_bash () {
  if OUTPUT=$(cat ~/.zshrc | grep 'export PATH="$HOME/development/dart-actual/bin:$PATH"')
  then
    echo "Your path for Dart SDK is ok in ~/.zshrc"
  else
    echo "Adding to ~/.zshrc"
    echo 'export PATH="$HOME/development/dart-actual/bin:$PATH"' >> ~/.zshrc
    echo 'export PATH="$PATH":"$HOME/.pub-cache/bin"' >> ~/.zshrc
  fi

  if OUTPUT=$(cat ~/.bash_profile | grep 'export PATH="$HOME/development/dart-actual/bin:$PATH"')
  then
    echo "Your path for Dart SDK is ok in ~/.bash_profile"
  else
    echo "Adding to ~/.bash_profile "
    echo 'export PATH="$HOME/development/dart-actual/bin:$PATH"' >> ~/.bash_profile
    echo 'export PATH="$PATH":"$HOME/.pub-cache/bin"' >> ~/.bash_profile
  fi
  echo ""
  echo -e "${ORANGE}=== Please refresh your terminal ===${NOCOLOR}"
  echo ""
}

generate_bash_file() {
  ALIAS="$1"
  ORG="$2"
  ACTUAL_DIR="$3"

  echo "export ALIAS_TOOLS_F=\"$ALIAS\"" > .bash_fundefir_rc
  echo "export ALIAS_ORG_TOOLS_F=\"$ORG\"" >> .bash_fundefir_rc
  echo "export ALIAS_ORG_ACTUAL_DIR=\"$ACTUAL_DIR\"" >> .bash_fundefir_rc
  echo "alias ${ALIAS}_up=\"cd $ACTUAL_DIR && cat README_global.md && docker-compose up -d && cd -\"" >> .bash_fundefir_rc
  echo "alias ${ALIAS}_status=\"cd $ACTUAL_DIR && cat README_global.md && docker-compose ps && cd -\"" >> .bash_fundefir_rc
  echo "alias ${ALIAS}_down=\"cd $ACTUAL_DIR && cat README_global.md && docker-compose down && cd -\"" >> .bash_fundefir_rc

  echo "alias ${ALIAS}_mysql_up=\"cd $ACTUAL_DIR && cat README_mysql.md && docker-compose up -d mysql_global && cd -\"" >> .bash_fundefir_rc
  echo "alias ${ALIAS}_mysql_stop=\"cd $ACTUAL_DIR && cat README_mysql.md && docker-compose stop mysql_global && cd -\"" >> .bash_fundefir_rc

  echo "alias ${ALIAS}_postgres_9_up=\"cd $ACTUAL_DIR && cat README_mysql.md && docker-compose up -d postgres_global_9 pgadmin_global && cd -\"" >> .bash_fundefir_rc
  echo "alias ${ALIAS}_postgres_9_stop=\"cd $ACTUAL_DIR && cat README_mysql.md && docker-compose stop postgres_global_9 pgadmin_global && cd -\"" >> .bash_fundefir_rc
  echo "alias ${ALIAS}_postgres_9_exec=\"cd $ACTUAL_DIR && ./bin/postgres.sh ${PWD} \"" >> .bash_fundefir_rc

  echo "alias ${ALIAS}_show=\"${ALIAS}_refresh\"" >> .bash_fundefir_rc
  echo "alias ${ALIAS}_refresh=\"cd $ACTUAL_DIR && ./install.sh ${ALIAS} && cd -\"" >> .bash_fundefir_rc
  echo "alias ${ALIAS}_open=\"cd $ACTUAL_DIR\"" >> .bash_fundefir_rc
  echo "alias ${ALIAS}_reinstall=\"cd $ACTUAL_DIR && ./install.sh\"" >> .bash_fundefir_rc
  echo "alias ${ALIAS}_update_tool=\"cd $ACTUAL_DIR && git pull origin master && ${ALIAS}_show && cd -\"" >> .bash_fundefir_rc
  echo "alias ${ALIAS}_console=\"$ACTUAL_DIR/bin/console\"" >> .bash_fundefir_rc
}

detect_project() {
  PWD="${1}"
  echo $NEW_ARGS

  if [[ -f "$PWD/pubspec.yaml" ]]; then
    detect_dart_project $PWD $NEW_ARGS
  fi
}

split_by () {
    string=$1
    separator=$2
    tmp=${string//"$separator"/$'\2'}
    IFS=$'\2' read -a arr <<< "$tmp"
    echo $arr
}

read_file(){
  FILE_NAME=$1

  if [[ -f $1 ]]; then
    echo "Reading $1"
    echo ""
  else
    echo "Creating file $1"
    echo ""
    CREATE_FILE="cp $1.example $1"
    eval $CREATE_FILE
  fi

  while IFS= read -r line
  do
    NAME_VAR=$(split_by $line "=")
    VALIDATION="
      if [[ -z \"\${$NAME_VAR}\" ]]; then
        echo From file;
        echo $line;
        export $line;
      else
        echo From environment;
        echo \${$NAME_VAR};
      fi
    "
    echo -e "${GREEN}${NAME_VAR}${NOCOLOR}"
    eval $VALIDATION

  done < "$FILE_NAME"
}
