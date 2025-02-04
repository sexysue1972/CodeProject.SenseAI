:: CodeProject SenseAI Analysis services (DeepStack module) startup script for Windows
::
:: Usage:
::   start.bat
::
:: We assume we're in the /src/AnalysisLayer directory

@echo off
SetLocal EnableDelayedExpansion

set verbosity=info

:: Assume platform
set platform="windows"

:: Move into the working directory
:: if not "%1" == "" (
::    cd "%1"
::)
set embedded=false
if "%1" == "--embedded" (
    set embedded="true"
) else (
    cls
)

:: Get some common env vars
set APPDIR=%cd%

:: Python 3.7
pushd ".\bin\!platform!\Python37\venv\" >nul
set VIRTUAL_ENV=%cd%
popd >nul

:: ===============================================================================================
:: 1. Load environment variables

:: If calling from another script then assume parent script has set some env vars
:: NOTE: Environement variables aren't being maintained so manually setting them
:: if "%embedded%" == "false" (

    echo Setting Environment variables...

    REM API server
    set PORT=5000

    REM Text module
    set NLTK_DATA=!APPDIR!\TextSummary\nltk_data

    REM Deepstack stuff
    set DATA_DIR=!APPDIR!\DeepStack\datastore
    set TEMP_PATH=!APPDIR!\DeepStack\tempstore
    set MODELS_DIR=!APPDIR!\DeepStack\assets
    set PROFILE=desktop_cpu
    set CUDA_MODE=False
    set MODE=Medium
:: )

if "%verbosity%" == "info" (
    echo:
    echo PORT      = !PORT!
    echo APPDIR    = !APPDIR!
    echo NLTK_DATA = !NLTK_DATA!
    echo PROFILE   = !PROFILE!
    echo CUDA_MODE = !CUDA_MODE!
    echo DATA_DIR  = !DATA_DIR!
    echo TEMP_PATH = !TEMP_PATH!
    echo MODE      = !MODE!
)

:: ===============================================================================================
:: 2. Start each module

echo:
echo Starting Analysis Services...

START "CodeProject SenseAI" /B /i "!VIRTUAL_ENV!\Scripts\python" "!APPDIR!\TextSummary\textsummary.py"

START "CodeProject SenseAI" /B /i "!VIRTUAL_ENV!\Scripts\python" "!APPDIR!\DeepStack\intelligencelayer\detection.py"
START "CodeProject SenseAI" /B /i "!VIRTUAL_ENV!\Scripts\python" "!APPDIR!\DeepStack\intelligencelayer\face.py"
START "CodeProject SenseAI" /B /i "!VIRTUAL_ENV!\Scripts\python" "!APPDIR!\DeepStack\intelligencelayer\scene.py"

:: Wait forever. We need these processes to stay alive
if "%embedded%" == "false" (
    pause > NUL
)