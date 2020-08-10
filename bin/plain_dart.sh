show_dart_plain_menu() {
    echo ""
    echo -e "${RED}Please use a command${NOCOLOR}"
    echo ""
    echo "List commands:"
    echo ""
    echo -e "${GREEN}coverage${NOCOLOR}  : Run the test with coverage"
    echo ""
}

dart_plain_execute() {
    echo $NEW_ARGS
    COMMAND=$(split_by $NEW_ARGS " ")
    echo $comm
    if [[ "coverage" == $COMMAND ]]
    then
        pub run test_coverage
        if [ $? -eq 0 ]; then
            echo ""
            echo -e "${GREEN}Test ok${NOCOLOR}"
            echo ""
        else
            echo ""
            echo -e "${RED}*****************************************************"
            echo -e "The test fails, please review for see the coverage"
            echo -e "*****************************************************${NOCOLOR}"
            exit
        fi

        # if [[ ! -f '.coverage_exclude' ]]
        # then
        #     remove="lcov --remove coverage/lcov.info";for line in $(cat .coverage_exclude); do remove="$remove -r '$line' " ; done;echo $remove; eval $remove;
        # fi
        lcov --remove coverage/lcov.info "lib/_configuration/*" -o coverage/lcov_cleaned.info
        genhtml -o coverage coverage/lcov_cleaned.info

        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            google-chrome ./coverage/index.html
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            open coverage/index.html
        fi
    fi
}
