set 
IF NOT "%1"=="" ECHO 123

echo %~p1
echo %~p0
IF "%~p1"=="%~p0test\" ECHO 123