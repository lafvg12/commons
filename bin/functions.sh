#!/bin/bash

install_dart_sdk () {
  DART_VERSION_SDK=$1
  if [ -z "$DART_VERSION_SDK" ]
  then
    DART_VERSION_SDK="2.7.0"
  fi

  echo -e "${GREEN}Installing DART SDK ${DART_VERSION_SDK}${NOCOLOR}"
  echo -e "${BLUE}Only supports MAC Os, pending Windows, Linux.${NOCOLOR}"

  cd /tmp
  rm dartsdk-macos-x64-release.zip
  rm -rf dartsdk-macos-x64-release
  rm -rf ~/development/dart-sdk/${DART_VERSION_SDK}
  rm -rf dart-sdk
  rm -rf ${DART_VERSION_SDK}
  wget https://storage.googleapis.com/dart-archive/channels/stable/release/${DART_VERSION_SDK}/sdk/dartsdk-macos-x64-release.zip
  unzip dartsdk-macos-x64-release.zip
  mkdir -p ~/development/dart-sdk/${DART_VERSION_SDK}
  cp -R dart-sdk/* ~/development/dart-sdk/${DART_VERSION_SDK}/
  cd -
  echo -e "${GREEN}SDK downloaded${NOCOLOR}"
  echo -e "${GREEN}Installing DART SDK finished! ${DART_VERSION_SDK}${NOCOLOR}"
  echo -e "${ORANGE}~/development/dart-sdk/${DART_VERSION_SDK}${ORANGE}"
}

detect_os () {
  echo "Your OS"
  echo -e "OSTYPE: ${ORANGE}$OSTYPE${GREEN}"
  echo "Description:"
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