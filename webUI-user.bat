@echo off
chcp 65001

::以下所有环境变量设置都无需添加引号""

::#################################################################################################
::设置python路径，不设置则使用默认python路径
set PYTHON=

::设置虚拟环境路径，不设置则使用./venv作为虚拟环境路径
set VENV_DIR=

::下面的设置如果不会设置请保持默认!!!
::设置pip源，此处默认使用清华源
set PIP_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple

::设置webUI文件路径
set WEBUI_PATH=webUI.py

::设置requirements.txt文件路径，此处默认使用requirements_win.txt
set REQUIREMENTS_TXT=requirements_win.txt

::设置Python版本需求
set PYTHON_VERSION_REQUIRED=3.8

::设置PyTorch安装命令，默认安装torch2.0.1+cu117，可前往 https://pytorch.org 复制其他版本的安装命令
set CUDA_VERSION=11.7
set PYTORCH_INSTALL_COMMAND=pip install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 --index-url https://download.pytorch.org/whl/cu117
::#################################################################################################

if not defined PYTHON (set "PYTHON=python")
if not defined VENV_DIR (set "VENV_DIR=%~dp0%venv")
if exist "%VENV_DIR%\Scripts\activate.bat" (
    set "PYTHON=%VENV_DIR%\Scripts\python.exe"
)

%PYTHON% -c ""
if %ERRORLEVEL% == 0 (
    goto :check_python_version
) else (
    echo ERROR: 无法启动Python
    pause
    exit /b
)

:check_python_version
set "PYTHON_VERSION="
for /f "tokens=1-2" %%a in ('%PYTHON% -c "import sys; print(sys.version_info[0], sys.version_info[1])"') do (
    set "PYTHON_VERSION=%%a.%%b"
)
if "%PYTHON_VERSION%"=="%PYTHON_VERSION_REQUIRED%" (
    goto :is_venv_exists
) else (
    echo =======================================================================================
    echo    警告: 您的Python版本为%PYTHON_VERSION%, 在运行过程中可能会出现问题, 推荐安装python版本%PYTHON_VERSION_REQUIRED%!
    echo    如需重新创建虚拟环境，请删除%VENV_DIR%目录后重新运行此脚本
    echo =======================================================================================
    goto :is_venv_exists
)

:is_venv_exists
if exist "%VENV_DIR%\Scripts\activate.bat" goto :is_install_requirements
if %ERRORLEVEL% == 0 goto :create_venv

:create_venv
echo INFO: 正在创建虚拟环境...
%PYTHON% -m venv %VENV_DIR% 
goto :install_torch

:install_torch
if exist "%VENV_DIR%\Lib\site-packages\torch" (
    goto :install_requirements
) else (
    echo INFO: 正在安装PyTorch
    if "%CUDA_VERSION%"=="11.7" (
        %VENV_DIR%\Scripts\python.exe -m pip install networkx==3.0 -i %PIP_INDEX_URL%
    )
    %VENV_DIR%\Scripts\python.exe -m %PYTORCH_INSTALL_COMMAND%
    if %ERRORLEVEL% EQU 0 (
        cls
        echo INFO: PyTorch安装完成
        goto :install_requirements
    ) else (
        pause
        exit /b
    )
)

:install_requirements
echo INFO: 正在安装依赖...
call %VENV_DIR%\Scripts\activate.bat
%VENV_DIR%\Scripts\python.exe -m pip install --upgrade pip wheel setuptools -i %PIP_INDEX_URL%
%VENV_DIR%\Scripts\python.exe -m pip install -r %REQUIREMENTS_TXT% -i %PIP_INDEX_URL%
if %ERRORLEVEL% EQU 0 (
    cls
    goto :save_requirements
) else (
    pause
    exit /b
)

:save_requirements
%VENV_DIR%\Scripts\python.exe -m pip freeze >%VENV_DIR%\requirements.txt
goto :is_install_requirements

:is_install_requirements
if exist "%VENV_DIR%\requirements.txt" (
    echo INFO: 依赖已安装
    %PYTHON% -c "import torch; print('INFO: CUDA状态: ' + str(torch.cuda.is_available()))"
) else (
    goto :install_torch
)

:start_venv
call "%VENV_DIR%\Scripts\activate.bat"
echo INFO: 正在启动WebUI...请稍等...
%VENV_DIR%\Scripts\python.exe %WEBUI_PATH%
