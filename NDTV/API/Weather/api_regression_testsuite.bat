:: The Web Automation Suite File to Execute Weather Report API Test Cases Execution.

SET BASE_DIR=%cd%
SET TC_DIR="%BASE_DIR%\testcases"
SET DATA_DIR="%BASE_DIR%\testdata"
SET PYTHONPATH=%PYTHONPATH%;%SCRIPT_DIR%;%BASE_DIR%\..\API\NDTV\common\lib;%BASE_DIR%\..\API\common\lib
SET LOG_DIR=%BASE_DIR%\testresults\logs
SET OUTPUT_DIR=%BASE_DIR%\testresults\output

call robot  --log %LOG_DIR%\API_Suite   --output  %OUTPUT_DIR%\API_Suite.xml  %TC_DIR%\weather_api_testsuite.robot
::call robot  --rerunfailed   %OUTPUT_DIR%\API_Suite.xml     --log %LOG_DIR%\API_Suite_rerun   --output  %OUTPUT_DIR%\API_Suite_Rerun.xml   %TC_DIR%\weather_api_testsuite.robot

::call robot  --log %LOG_DIR%\API_Suite   --output  %OUTPUT_DIR%\API_Suite.xml  %TC_DIR%\weather_api_regression.robot
::call robot  --rerunfailed   %OUTPUT_DIR%\API_Suite.xml     --log %LOG_DIR%\API_Suite_rerun   --output  %OUTPUT_DIR%\API_Suite_Rerun.xml   %TC_DIR%\weather_api_regression.robot

call rebot --name "Weather Report API Test Cases" --doc "Weather Report API Test Results" --merge  --outputdir %OUTPUT_DIR%\FinalAPIReport  %OUTPUT_DIR%\*.xml
