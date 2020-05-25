#!/bin/bash

install_dart_sdk () {
  DART_VERSION_SDK=$1
  DEFAULT_SO="macos-x64"

  if [ -z "$DART_VERSION_SDK" ]
  then
    DART_VERSION_SDK="2.7.0"
  fi

  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    DEFAULT_SO="linux-x64"
  fi

  echo -e "${GREEN}Installing DART SDK ${DART_VERSION_SDK}${NOCOLOR}"
  echo -e "${BLUE}Only supports MAC OS and Linux, pending Windows${NOCOLOR}"

  cd /tmp
  rm dartsdk-${DEFAULT_SO}-release.zip
  rm -rf dartsdk-${DEFAULT_SO}-release
  rm -rf ~/development/dart-sdk/${DART_VERSION_SDK}
  rm -rf dart-sdk
  rm -rf ${DART_VERSION_SDK}
  wget https://storage.googleapis.com/dart-archive/channels/stable/release/${DART_VERSION_SDK}/sdk/dartsdk-${DEFAULT_SO}-release.zip
  unzip dartsdk-${DEFAULT_SO}-release.zip
  mkdir -p ~/development/dart-sdk/${DART_VERSION_SDK}
  cp -R dart-sdk/* ~/development/dart-sdk/${DART_VERSION_SDK}/
  cd -
  echo -e "${GREEN}SDK downloaded${NOCOLOR}"
  echo -e "${GREEN}Installing DART SDK finished! ${DEFAULT_SO} ${DART_VERSION_SDK}${NOCOLOR}"
  echo -e "${ORANGE}~/development/dart-sdk/${DART_VERSION_SDK}${ORANGE}"
  ls ~/development/dart-sdk
}

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
  echo
}

add_bash_fundefir () {
  ACTUAL_DIR=$1
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
      echo -e "${ORANGE}Installing on Linux...${NOCOLOR}"
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
  fi
}

generate_bash_file() {
  ALIAS="$1"
  ORG="$2"
  ACTUAL_DIR="$3"

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

  echo "alias ${ALIAS}_show=\"${ALIAS}_refresh\"" >> .bash_fundefir_rc
  echo "alias ${ALIAS}_refresh=\"cd $ACTUAL_DIR && ./install.sh ${ALIAS} && cd -\"" >> .bash_fundefir_rc
  echo "alias ${ALIAS}_reinstall=\"$ACTUAL_DIR/install.sh\"" >> .bash_fundefir_rc
  echo "alias ${ALIAS}_update_tool=\"cd $ACTUAL_DIR && git pull origin master && ${ALIAS}_show && cd -\"" >> .bash_fundefir_rc
  echo "alias ${ALIAS}_console=\"$ACTUAL_DIR/bin/console\"" >> .bash_fundefir_rc
}