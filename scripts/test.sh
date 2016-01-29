EXIT_STATUS=0

echo "Running tests:"
mocha --compilers coffee:coffee-script/register test || EXIT_STATUS=$?

echo "\nLinting 'src' directory:\n"
coffeelint -f ./coffeelint.json src || EXIT_STATUS=$?

echo "\nLinting 'test' directory:\n"
coffeelint -f ./coffeelint.json test || EXIT_STATUS=$?

printf "\nGenerating coverate report... "
istanbul report || EXIT_STATUS=$?

if [ $TRAVIS ]; then
  echo "\nUploading coverage to codeclimate:"
  codeclimate-test-reporter < ./coverage/lcov.info
else
  echo "Not running on Travis, skipping coverage upload\n"
fi

exit $EXIT_STATUS