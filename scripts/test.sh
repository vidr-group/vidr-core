EXIT_STATUS=0
echo "Running tests:"
mocha --recursive --compilers coffee:coffee-script/register --require coffee-coverage/register-istanbul test || EXIT_STATUS=$?
printf "\nGenerating coverate report... "
istanbul report || EXIT_STATUS=$?
echo "\nLinting 'src' directory:\n"
coffeelint -f ./coffeelint.json src || EXIT_STATUS=$?
echo "\nLinting 'test' directory:\n"
coffeelint -f ./coffeelint.json test || EXIT_STATUS=$?
exit $EXIT_STATUS