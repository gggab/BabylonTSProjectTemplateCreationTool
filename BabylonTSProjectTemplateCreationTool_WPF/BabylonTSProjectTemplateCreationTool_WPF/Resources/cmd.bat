@echo off
cd /d %~dp0
call npm init -y
call cnpm install --save-dev typescript webpack ts-loader webpack-cli
call cnpm install --save babylonjs@4.0.0-beta.6

@echo off&setlocal enabledelayedexpansion
setlocal enableDelayedExpansion
for /f "eol=* tokens=*" %%i in (package.json) do (
set a=%%i
set b="test": "echo \"Error: no test specified\" && exit 1"
if "!a!" == "!b!" (^
	echo "build": "webpack", >>$ ^
)
echo !a!>>$)
move $ package.json
call npm run build
index.html
exit