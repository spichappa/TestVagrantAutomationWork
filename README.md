# TestAutomationWork
 Automation Test Challenge Work from TestVagrant
 
#Automation SetUp for NDTV-WeatherReporting application using RobotFramework:

#Prerequisite:
-------------
Install Python using the free downloads website for windows machine with the below version:
-   version: Python 3.7.3

Set the pythonpath in the System Environment Variable or add them through cmd prompt.
It should mainly contain the directory path of python scripts and lib folders from the installed path.
In addition, it should also have your automation scripts, lib, folder directories.
-   echo %PYTHONPATH%
C:\Users\Sindhu_Pichappa\AppData\Local\Programs\Python\Python37-32\Scripts\;
C:\Users\Sindhu_Pichappa\AppData\Local\Programs\Python\Python37-32\;
D:\Automation\TestVagrant\TestVagrantAutomationWork\NDTV\;
D:\Automation\TestVagrant\TestVagrantAutomationWork\NDTV\common\lib;
 
Install Chrome Browser or any required browser for testing but ensure the same compatible driver version is set up in the environment accordingly.
-   Chrome Browser Version Used: 85.0.4183.121 (Official Build) (64-bit)

Download the Chrome Web Driver from the below path:
https://chromedriver.storage.googleapis.com/index.html?path=85.0.4183.87/
-   Web Driver Version Used: ChromeDriver 85.0.4183.87

Note: Once the chrome web driver zip file is extracted in the project tools directory, click on the exe to start the server and also add that path in the
system environment variable through control panel->Systems and Security->System->Advanced Settings->Environment Variables
Check the tools directory is added in the environment path as like below:
-   echo %PATH%
...D:\Automation\TestVagrant\TestVagrantAutomationWork\Generic\Tools\Drivers;


#Installation Instruction:
-------------------------
pip install robotframework

pip install selenium
pip install robotframework-seleniumlibrary

pip install requests

pip install robotframework-requests

pip install robotframework-jsonlibrary

pip install robotframework-datadriver

pip install -U robotframework-datadriver[XLS]

Verify whether above listed installations are succeeded using the below command:

#pip list (or) pip freeze

eg:
C:\Users\Sindhu_Pichappa>pip freeze

decorator==4.4.2

distlib==0.3.1

importlib-metadata==2.0.0

jsonpath-rw==1.4.0

jsonpath-rw-ext==1.2.2

requests==2.24.0

robotframework==3.2.2

robotframework-datadriver==0.3.6

robotframework-jsonlibrary==0.3.1

robotframework-pythonlibcore==2.1.0

robotframework-requests==0.7.1

robotframework-seleniumlibrary==4.5.0

selenium==3.141.0

urllib3==1.25.10

virtualenv==20.0.31

Test Execution Details:
-----------------------
UI Suite Name: weather_reporting_web_testsuite.bat 
D:\Automation\TestVagrant\TestVagrantAutomationWork\NDTV\UI\Weather\weather_reporting_web_testsuite.bat

API Suite Name: weather_api_testsuite.bat
D:\Automation\TestVagrant\TestVagrantAutomationWork\NDTV\API\Weather\api_regression_testsuite.bat

E2E/Integrated Suite Name:   E2E_Regression_Integrated_TestSuite.robot
D:\Automation\TestVagrant\TestVagrantAutomationWork\NDTV\common\E2E_Regression_Integrated_TestSuite.robot

