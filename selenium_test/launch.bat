@echo off
CALL :checkPython

set "VENV_DIR=C:\Users\gololo\Downloads\selenium_test\venv"
set "REQUIREMENTS=requirements.txt"
set "SCRIPT=C:\Users\gololo\Downloads\selenium_test\testing.py"

IF NOT EXIST "%VENV_DIR%" (
    echo Making the virtual environment, hold your horses...
    python -m venv %VENV_DIR%
    IF ERRORLEVEL 1 (
        echo Could not create virtual environment. Make sure Python is installed correctly.
	    echo Recommended version of Python: 3.10.11
        goto :error
    )
)

echo Activating the virtual environment...
CALL %VENV_DIR%\Scripts\activate.bat
IF ERRORLEVEL 1 (
    echo Failed to activate virtual environment. Did you move the files around? Delete the venv folder and try again.
    goto :error
)

echo Checking each damn dependency manually...
FOR /F "delims=" %%i IN (%REQUIREMENTS%) DO (
    pip show %%i >nul 2>&1
    IF ERRORLEVEL 1 (
        echo Missing %%i, installing now...
        pip install %%i
        IF ERRORLEVEL 1 (
            echo Failed to install %%i. Your setup is probably cursed. Throw your PC out of the window.
	    echo Or deleting the venv folder might also suffice.
            goto :error
        )
    ) ELSE (
        echo %%i is already installed...
    )
)

echo All dependencies are installed

echo Running the script...
python %SCRIPT%
IF ERRORLEVEL 1 (
    echo The script got an issue
    goto :error
)

echo Done with the dirty work.
goto :end

:checkPython
python --version >nul 2>&1
IF ERRORLEVEL 1 (
    echo Python is not recognized as an internal or external command, operable program or batch file. Fix it
    goto :error
)
goto :eof

:error
echo Some error happened.
pause
exit /b

:end
pause
exit /b