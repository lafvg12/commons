show_flutter_menu() {
    echo ""
    echo -e "${RED}Please use a command${NOCOLOR}"
    echo ""
    echo "List commands:"
    echo ""
    echo -e "${GREEN}coverage${NOCOLOR}  : Run the test with coverage"
    echo ""
}

flutter_execute() {
    echo $NEW_ARGS
    COMMAND=$(split_by $NEW_ARGS " ")
    echo $comm

    if [[ "coverage" == $COMMAND ]]
    then
        flutter test --coverage
        flutter pub run remove_from_coverage -f coverage/lcov.info -r 'lib/generated' -r 'lib/src/screens/homeTest'
        echo "Excluding 'lib/generated' and 'lib/src/screens/homeTest'"
        genhtml -o coverage coverage/lcov.info

        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            google-chrome ./coverage/index.html
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            open coverage/index.html
        fi
    fi
}
