:: The Web Automation Suite File to Execute Weather Report Page Test Cases Execution.

SET BASE_DIR=D:\Automation\TestVagrant\TestVagrantAutomationWork\NDTV\UI\Weather
SET TC_DIR="%BASE_DIR%\testcases"
SET DATA_DIR="%BASE_DIR%\testdata"
SET PYTHONPATH=%PYTHONPATH%;%SCRIPT_DIR%;%BASE_DIR%\..\UI\NDTV\common\;%BASE_DIR%\..\UI\common\
SET LOG_DIR=%BASE_DIR%\testresults\logs
SET OUTPUT_DIR=%BASE_DIR%\testresults\output

call robot  --log %LOG_DIR%\Web_Suite   --output  %OUTPUT_DIR%\Web_Suite.xml  %TC_DIR%\Sanity.robot
call robot  --rerunfailed   %OUTPUT_DIR%\Web_Suite.xml     --log %LOG_DIR%\Web_Suite_rerun   --output  %OUTPUT_DIR%\Web_Suite_Rerun.xml   %TC_DIR%\Web_Suite.robot

call rebot --name "Weather Report Page Test Cases" --doc "Weather Report Page Test Results" --merge  --outputdir %OUTPUT_DIR%\FinalUIReport  %OUTPUT_DIR%\*.xml
