
verify_dart_version() {
  echo ""
  echo -e "${ORANGE}Verify dart version:${NOCOLOR}"
  dart --version 2>&1 | tee /tmp/dart_version.txt
  DART_VERSION=$(cat /tmp/dart_version.txt)

  if [[ "${DART_VERSION}" == *"version: 2.7"* ]]; then
    echo "Your dart version is OK"
  else
    echo ""
    echo -e "${RED}Version error${NOCOLOR}"
    echo ""
    echo -e "Aqueduct runs ok in ${ORANGE}Dart 2.7.*${NOCOLOR}, ${GREEN}please change your dart version:${NOCOLOR}"
    echo ""
    echo "Please run this commands:"
      echo "
        dvm install 2.7.0
        dvm use 2.7.0
        dart --version

        Check this for install
        https://github.com/cbracken/dvm

        Or use
        ${ALIAS_TOOLS_F}_console set_dart_sdk 2.7.0
      "

    echo "Do you want continue anyway? Y/N"
    read decision;
    if [ "$decision" == 'n' ] || [ "$decision" == 'N' ] ; then
      exit
    fi
  fi
}

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

show_dart_sdk () {
  echo ""
  ls ~/development/dart-sdk
}

set_dart_sdk () {
  DART_SELECTED=$1

  if [[ $DART_SELECTED == '' ]]; then
    echo "Please select a dart sdk version:"
    ls ~/development/dart-sdk
    exit 1
  fi

  echo -e "${GREEN}Setting dart SDK${NOCOLOR}"

  rm ~/development/dart-actual
  ln -s ~/development/dart-sdk/$DART_SELECTED ~/development/dart-actual
  export PATH="$PATH:~/development/dart-actual/bin"
  add_dart_to_bash
  dart --version
}

detect_dart_project() {
  PWD="${1}"
  aqueduct=$(cat "$PWD/pubspec.yaml" | grep aqueduct:)
  fluter=$(cat "$PWD/pubspec.yaml" | grep flutter:)
  dart=$(cat "$PWD/pubspec.yaml")
  length=${#dart}

  if [[ $aqueduct == *"aqueduct"*'' ]]; then
    echo -e "${GREEN}This is an AQUEDUCT PROJECT${NOCOLOR}"
    echo $aqueduct
    verify_dart_version
    if [[ $NEW_ARGS == '' ]]; then
        show_aqueduct_menu
        exit
    fi
    create_files
    aqueduct_execute $NEW_ARGS
  fi

  if [[ $fluter == *"flutter"*'' ]]; then
    echo -e "${GREEN}This is an FLUTTER PROJECT${NOCOLOR}"
    echo $flutter
    if [[ $NEW_ARGS == '' ]]; then
        show_flutter_menu
        exit
    fi
    flutter_execute $NEW_ARGS
  fi

  if [[ lenght > 0 && $fluter == '' && $aqueduct == '' ]]; then
    echo -e "${GREEN}Dart plain project${NOCOLOR}"
    name=$(cat "$PWD/pubspec.yaml" | grep name:)
    description=$(cat "$PWD/pubspec.yaml" | grep description:)
    version=$(cat "$PWD/pubspec.yaml" | grep version:)

    echo "$name"
    echo "$description"
    echo "$version"

    if [[ $NEW_ARGS == '' ]]; then
        show_dart_plain_menu
        exit
    fi
    dart_plain_execute $NEW_ARGS
  fi
}


