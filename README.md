# so-vits-svc-webUI-QuickStart-bat

SoVITS webUI QuickStart bat，一个 [so-vits-svc](https://github.com/svc-develop-team/so-vits-svc) 一键配置环境，启动 webUI 的脚本。

✨ 我写的一个 [so-vits-svc 中文本地部署/训练/推理/使用帮助文档](https://github.com/SUC-DriverOld/so-vits-svc-Chinese-Detaild-Documents)

> [!NOTE]
>
> 1. 此脚本目前处于公开测试阶段，可能存在不稳定情况。如果您想对此仓库作贡献或给出任何建议，欢迎提出 Issue 或 Pull Request。
> 2. 此脚本仅用于快速安装项目依赖和快速启动 webUI，你还需要自己参考官方文档下载预训练模型，训练集预处理，训练模型等步骤。

## 准备阶段

你可以直接在 [Release](https://github.com/SUC-DriverOld/so-vits-svc-webUI-QuickStart-bat/releases) 中下载已经将脚本打包到项目中的 [so-vits-svc-webUI-QuickStart-bat.zip](https://github.com/SUC-DriverOld/so-vits-svc-webUI-QuickStart-bat/releases/download/v1.0beta.1/so-vits-svc-4.1-Stable-Packed-with-QuickStart-bat.zip) 压缩文件。解压后可以直接跳转到 **准备阶段** 的第 4 条。

1. 克隆 [so-vits-svc](https://github.com/svc-develop-team/so-vits-svc) 源码。

   ```bash
    git clone https://github.com/svc-develop-team/so-vits-svc.git
   ```

2. 克隆本项目。

   ```bash
    git clone https://github.com/SUC-DriverOld/so-vits-svc-webUI-QuickStart-bat.git
   ```

3. 将本项目中的 `requirements_win.txt` 和 `webUI-user.bat` 复制到你克隆的 [so-vits-svc](https://github.com/svc-develop-team/so-vits-svc) 项目文件夹中，此时遇到同名文件，请选择 **替换文件**！
4. 参考 [官方说明文档](https://github.com/svc-develop-team/so-vits-svc#readme) 中的 [#预先下载的模型文件](https://github.com/svc-develop-team/so-vits-svc/blob/4.1-Stable/README_zh_CN.md#-%E9%A2%84%E5%85%88%E4%B8%8B%E8%BD%BD%E7%9A%84%E6%A8%A1%E5%9E%8B%E6%96%87%E4%BB%B6) 以及 [#可选项](https://github.com/svc-develop-team/so-vits-svc/blob/4.1-Stable/README_zh_CN.md#%E5%8F%AF%E9%80%89%E9%A1%B9%E6%A0%B9%E6%8D%AE%E6%83%85%E5%86%B5%E9%80%89%E6%8B%A9) 下载项目需要的预训练底模和声码器。此处你也可以参考我写的 [so-vits-svc 中文本地部署/训练/推理/使用帮助文档](https://github.com/SUC-DriverOld/so-vits-svc-Chinese-Detaild-Documents) 中的 [#2.2 预先下载的模型文件](https://github.com/SUC-DriverOld/so-vits-svc-Chinese-Detaild-Documents?tab=readme-ov-file#22-%E9%A2%84%E5%85%88%E4%B8%8B%E8%BD%BD%E7%9A%84%E6%A8%A1%E5%9E%8B%E6%96%87%E4%BB%B6) 这一部分内容。

## 快速开始

请确你的电脑中已安装 CUDA 相关环境。使用 `nvidia-smi.exe` 命令查看显卡驱动版本和对应支持的 CDUA 版本，并前往 [NVIDIA-Developer](https://developer.nvidia.com/) 官网下载与 **系统对应** 的 Cuda 版本。

> [!NOTE]
>
> 1. 此处建议安装 [CUDA11.7](<(https://developer.nvidia.com/cuda-11-7-0-download-archive?target_os=Windows&target_arch=x86_64&target_version=11&target_type=exe_local)>) (**CUDA11.7 以上版本也是可以的，但我并没有每个都测试过**)。
> 2. 安装完成后，你可用通过 `nvcc -V` 命令来验证是否安装成功。

### 1. Conda 环境

我非常建议各位使用 Conda 手动配置环境，你可以在 [Anaconda 官网](https://www.anaconda.com/download/) 下载并安装。

1. 创建虚拟环境，此处 python 版本建议使用 3.8，`YOUR_ENV_NAME` 请替换为你想要创建的虚拟环境名称。

   ```bash
   conda create -n YOUR_ENV_NAME python=3.8 -y
   ```

2. 激活虚拟环境。

   ```bash
   conda activate YOUR_ENV_NAME
   ```

3. 第一次使用请 **从命令行中启动脚本！**

   ```bash
   call webUI-user.bat
   ```

4. 等待一切依赖都安装完成后，脚本将自动启动 webUI 并开启浏览器。最后将输出类似如下信息：

   ```bash
    Active code page: 65001
    INFO: 依赖已安装
    INFO: CUDA状态: True
    INFO: 正在启动WebUI...请稍等...
    Running on local URL:  http://127.0.0.1:7860

    To create a public link, set `share=True` in `launch()`.
   ```

> [!NOTE]
>
> 1. 此处请注意输出信息的 CUDA 状态，若为 True 则表明 你的 CUDA 与 pytorch 版本匹配，可以使用 GPU 相关功能；若为 False 请检查你的 CUDA 版本或修改启动参数中的 Pytorch 安装命令，参考下方启动参数。
> 2. 使用 conda 第一次启动时请在激活的 conda 环境中 `call webUI-user.bat` 启动脚本，此时脚本会自动安装相关依赖，安装过程比较缓慢，请耐心等待所有依赖安装完成。下次启动你可用直接通过双击 `webUI-user.bat` 启动。
> 3. 如需重新创建虚拟环境，请删除 `%VENV_DIR%` 目录后重新运行此脚本。`%VENV_DIR%` 在脚本中有定义，请参考下方启动参数。
> 4. 若在安装依赖的时候遇到编译错误，请安装 `Microsoft Visual C++ 15.0` 运行库。

### 2. 本地 Python 环境

前往 [Python 官网](https://www.python.org/) 下载 `Python3.8.9` 版本。安装时请别忘了勾选将 Python 添加至系统环境变量。

安装好 python 后，直接双击 `webUI-user.bat` 即可启动 webUI。第一次启动会进行相关依赖的安装，此过程较为缓慢。等待一切依赖都安装完成后，控制台也会输出类似上面 conda 环境中第 4 条的内容。并且相关注意事项也请参考上面 conda 环境最后的 **注意**。

若在安装依赖的时候遇到编译错误，请安装 `Microsoft Visual C++ 15.0` 运行库。

## 启动参数

此部分参数可以在 `webUI-user.bat` 中修改。可修改参数如下：

```shell
::以下所有环境变量设置都无需添加引号""
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
set PYTORCH_INSTALL_COMMAND=pip install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 --index-url https://download.pytorch.org/whl/cu117
```

## 未来计划

- [ ] 增加预处理模型的自动下载功能
- [ ] 增加一键预处理脚本
- [ ] 增加一键训练脚本
- [ ] 改进 webUI
- [ ] 其他 features...

## 感谢名单

- [so-vits-svc](https://github.com/svc-develop-team/so-vits-svc) 官方仓库
- [so-vits-svc 中文本地部署/训练/推理/使用帮助文档](https://github.com/SUC-DriverOld/so-vits-svc-Chinese-Detaild-Documents) 我写的教程文档
- 所有测试此脚本的人员
- 您
