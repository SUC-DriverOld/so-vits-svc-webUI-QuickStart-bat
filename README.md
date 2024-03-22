<div align="center">

# so-vits-svc-webUI-QuickStart-bat

SoVITS webUI QuickStart bat, a script for one-click environment configuration and launching webUI for [so-vits-svc](https://github.com/svc-develop-team/so-vits-svc).

</div>

> [!NOTE]
>
> ✨ [A deployment/training/inference/usage guide](https://github.com/SUC-DriverOld/so-vits-svc-Deployment-Documents) written by me for [so-vits-svc](https://github.com/svc-develop-team/so-vits-svc).
>
> 1. This script is currently in public testing phase and may be unstable. If you would like to contribute to this repository or provide any suggestions, feel free to raise an Issue or Pull Request.
> 2. This script is only for quickly installing project dependencies and launching webUI. You still need to refer to the official documentation to download pre-trained models, preprocess the training set, and train the model, etc.

## Preparation Stage

You can directly download the compressed file containing the script already packaged into the project from [Release](https://github.com/SUC-DriverOld/so-vits-svc-webUI-QuickStart-bat/releases). After extraction, you can skip the first step below.

1. Clone the [so-vits-svc](https://github.com/svc-develop-team/so-vits-svc) source code.

   ```bash
    git clone https://github.com/svc-develop-team/so-vits-svc.git
   ```

   Clone this project.

   ```bash
    git clone https://github.com/SUC-DriverOld/so-vits-svc-webUI-QuickStart-bat.git
   ```

   Copy `requirements_win.txt` and `webUI-user.bat` from this project to the folder of your cloned [so-vits-svc](https://github.com/svc-develop-team/so-vits-svc) project. If you encounter files with the same name, please choose **Replace files**!

2. Install CUDA. Please use the `nvidia-smi.exe` command first to **check the graphics card driver version and the highest supported CUDA version** (if the highest CUDA version here is lower, please update the graphics card driver first), and then go to [cuda-toolkit](https://developer.nvidia.com/cuda-toolkit) to download CUDA (older versions of CUDA can be downloaded from [cuda-toolkit-archive](https://developer.nvidia.com/cuda-toolkit-archive)). After installation, you can verify whether it is installed successfully by using the `nvcc -V` command.
3. Download and install [Visual Studio 2022](https://visualstudio.microsoft.com/) or [Microsoft C++ Build Tools](https://visualstudio.microsoft.com/zh-hans/visual-cpp-build-tools/) (the latter has a smaller size). **Install the component package "Desktop development with C++"**, execute the modification, and wait for it to be installed.
4. Refer to the [#Pre-downloaded-model-files](https://github.com/svc-develop-team/so-vits-svc/blob/4.1-Stable/README.md#-pre-downloaded-model-files) and [#Options](https://github.com/svc-develop-team/so-vits-svc/blob/4.1-Stable/README.md#options) sections in the [official documentation of so-vits-svc](https://github.com/svc-develop-team/so-vits-svc#readme) to **download and correctly place the pre-trained base models and vocoders required by the project**. Here you can also refer to the relevant part in the [detailed Chinese deployment/training/inference/usage guide](https://github.com/SUC-DriverOld/so-vits-svc-Chinese-Detaild-Documents) I wrote.

## Quick Start

### 1. Conda Environment

I highly recommend manually configuring the environment using Conda. You can download and install it from the [Anaconda official website](https://www.anaconda.com/download/).

1. Create a virtual environment. Here, it is recommended to use Python version 3.8, and replace `YOUR_ENV_NAME` with the name of the virtual environment you want to create.

   ```bash
   conda create -n YOUR_ENV_NAME python=3.8 -y
   ```

2. Activate the virtual environment.

   ```bash
   conda activate YOUR_ENV_NAME
   ```

3. The first time, please **start the script from the command line!**

   ```bash
   call webUI-user.bat
   ```

4. After all dependencies are installed, the script will automatically launch the webUI and open the browser. Finally, it will output information similar to the following:

   ```bash
    Active code page: 65001
    INFO: Dependencies installed
    INFO: CUDA status: True
    INFO: Starting WebUI... Please wait...
    Running on local URL:  http://127.0.0.1:7860

    To create a public link, set `share=True` in `launch()`.
   ```

> [!NOTE]
>
> 1. Please pay attention to the CUDA status in the output information here. If it is True, it means that your CUDA matches the pytorch version, and you can use GPU-related functions; if it is False, please check your CUDA version or modify the Pytorch installation command in the startup parameters below.
> 2. When using conda for the first time, start the script `call webUI-user.bat` in the activated conda environment. At this time, the script will automatically install the related dependencies. The installation process may be slow, so please be patient until all dependencies are installed. Next time you can directly double-click `webUI-user.bat` to start.
> 3. If you need to recreate the virtual environment, please delete the `%VENV_DIR%` directory and rerun this script. `%VENV_DIR%` is defined in the script. Please refer to the startup parameters below.

### 2. Local Python Environment

For the local Python environment, please make sure that there is only one Python in your system, otherwise there will be environment conflicts.

Go to the [Python official website](https://www.python.org/) to download version `Python3.8.9`. When installing, don't forget to check the option to add Python to the system environment variables.

After installing python, simply double-click `webUI-user.bat` to start the webUI. The first time you start, it will install the related dependencies. This process may be slow. After all dependencies are installed, the console will also output content similar to the one in the conda environment above. Please also refer to the above [**Note**](#1-conda-环境) for relevant precautions.

## Startup Parameters

These parameters can be modified in `webUI-user.bat`. The modifiable parameters are as follows. If you don't know how to modify, please keep the defaults!

```bash
:: All environment variable settings below do not require quotation marks ""
:: Set the Python path, if not set, the default Python path is used
set PYTHON=

:: Set the virtual environment path, if not set, use ./venv as the virtual environment path
set VENV_DIR=

:: The following settings can be kept default if you do not know how to set them!!!
:: Set the pip source, the default is to use the Tsinghua source
set PIP_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple

:: Set the path of the webUI file
set WEBUI_PATH=webUI.py

:: Set the path of the requirements.txt file, the default is to use requirements_win.txt
set REQUIREMENTS_TXT=requirements_win.txt

:: Set the Python version requirement
set PYTHON_VERSION_REQUIRED=3.8

:: Set the PyTorch installation command, the default is to install torch2.0.1+cu117, you can go to https://pytorch.org to copy the installation command for other versions
set PYTORCH_INSTALL_COMMAND=pip install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 --index-url https://download.pytorch.org/whl/cu117
```

## Future Plans

- [ ] Add automatic download function for preprocessing models
- [ ] Add one-click preprocessing script
- [ ] Add one-click training script
- [ ] Improve webUI
- [ ] Other features...

## Acknowledgements

- [so-vits-svc](https://github.com/svc-develop-team/so-vits-svc) Official Repository
- [so-vits-svc Deployment/Training/Inference/Usage Guide](https://github.com/SUC-DriverOld/so-vits-svc-Deployment-Documents) Tutorial Document Written by Me
- All individuals testing this script
- You
