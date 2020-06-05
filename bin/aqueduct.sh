show_aqueduct_menu() {
    echo ""
    echo -e "${RED}Please use a command${NOCOLOR}"
    echo ""
    echo "List commands:"
    echo ""
    echo -e "${GREEN}setup${NOCOLOR}     : Create a .env files and run migrations"
    echo -e "${GREEN}serve${NOCOLOR}     : Up the server        (aqueduct run serve)"
    echo -e "${GREEN}migration${NOCOLOR} : Create new migration (aqueduct db generate)"
    echo -e "${GREEN}test${NOCOLOR}      : Run the test         (pub run test)"
    echo -e "${GREEN}coverage${NOCOLOR}  : Run the test with coverage"
    echo -e "${GREEN}aqueduct${NOCOLOR}  : Run the aqueduct as an expert!"
    echo ""
}

aqueduct_execute() {
    echo $NEW_ARGS
    COMMAND=$(split_by $NEW_ARGS " ")
    echo $comm
    if [[ "test" == $COMMAND ]]
    then
        read_file ".env.test"
        echo ""
        echo -e "${GREEN}Running test${NOCOLOR}"
        echo -e "Running ${GREEN}pub run test $NEW_ARGS${NOCOLOR}"
        echo
        echo ""
        pub run aqueduct db upgrade --connect $DATABASE_CONNECTION_URL
        pub run $NEW_ARGS
        exit
    fi

    if [[ "serve" == $COMMAND ]]
    then
        read_file ".env"
        echo ""
        echo -e "${GREEN}Initialize${NOCOLOR}"
        echo ""
        echo -e "Running ${GREEN}pub run aqueduct serve${NOCOLOR}"
        echo
        pub run aqueduct serve -n1
        exit
    fi

    if [[ "setup" == $COMMAND ]]
    then
        read_file ".env" > /dev/null
        read_file ".env.test" > /dev/null
        pub get
        echo -e "Running ${GREEN}pub run aqueduct db upgrade --connect $DATABASE_CONNECTION_URL${NOCOLOR}"
        echo
        pub run aqueduct db upgrade --connect $DATABASE_CONNECTION_URL
    fi

    if [[ "coverage" == $COMMAND ]]
    then
        read_file ".env.test" > /dev/null
        read_file ".env" > /dev/null
        pub run test_coverage
        lcov --remove coverage/lcov.info "lib/_configuration/*" -o coverage/lcov_cleaned.info
        genhtml -o coverage coverage/lcov_cleaned.info

        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            google-chrome ./coverage/index.html
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            open coverage/index.html
        fi 
    fi

    if [[ "migration" == $COMMAND ]]
    then
        read_file ".env" > /dev/null
        echo -e "Running ${GREEN}pub run aqueduct db generate${NOCOLOR}"
        echo
        pub run aqueduct db generate
    fi

    if [[ "aqueduct" == $COMMAND ]]
    then
        read_file ".env" # > /dev/null
        echo ""
        echo -e "Running ${GREEN}pub run ${NEW_ARGS}${NOCOLOR}"
        echo
        pub run $NEW_ARGS
    fi

}

create_files() {
    echo $PWD
    if [[ ! -f "${PWD}/.env.example" ]]; then
        echo "Create .env.example"
        create_file "${PWD}/.env.example" ".env" "db_name"
    fi
    if [[ ! -f "${PWD}/.env.test.example" ]]; then
        echo "Create .env.test.example"
        create_file "${PWD}/.env.test.example" ".env.test" "db_name_test"
    fi
    if [[ ! -d "${PWD}/.vscode" ]]; then
        cp -R "${ALIAS_ORG_ACTUAL_DIR}/bin/.vscode" "${PWD}/.vscode"
        echo -e "${RED}PLEASE MODIFY YOUR ENV VARS${NOCOLOR}"
    fi
}

create_file() {
    route=$1
    name=$2
    db_name=$3
    echo "DATABASE_CONNECTION_URL=postgres://postgres:postgres@localhost:5432/${db_name}" > $route
    echo "$name" >> "${PWD}/.gitignore"
    echo -e "${RED}PLEASE MODIFY YOUR ENV VARS${NOCOLOR}"
}