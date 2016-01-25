EXIT_STATUS=0
echo "Running tests:"
mocha --recursive --compilers coffee:coffee-script/register --require coffee-coverage/register-istanbul test || EXIT_STATUS=$?
echo "\nLinting 'src' directory:\n"
coffeelint -f ./coffeelint.json src || EXIT_STATUS=$?
echo "\nLinting 'test' directory:\n"
coffeelint -f ./coffeelint.json test || EXIT_STATUS=$?

if [ $TRAVIS ]; then
  printf "\nGenerating coverate report... "
  istanbul report || EXIT_STATUS=$?
  echo "Uploading coverage to codeclimate:"
  codeclimate-test-reporter < ./coverage/lcov.info
else
  echo "Not running on travis, skipping coverage\n"
fi

exit $EXIT_STATUS