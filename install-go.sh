#!/bin/bash

# 定义Go版本和下载链接
GO_VERSION="1.19"
GO_TAR="go${GO_VERSION}.linux-amd64.tar.gz"
GO_URL="https://golang.org/dl/${GO_TAR}"

# 下载Go二进制文件
wget ${GO_URL} || curl -O ${GO_URL}

# 如果下载成功，解压到/usr/local目录
if [ -f "${GO_TAR}" ]; then
    sudo tar -C /usr/local -xzf ${GO_TAR}
    echo "Go ${GO_VERSION} downloaded and extracted."
else
    echo "Failed to download Go ${GO_VERSION}."
    exit 1
fi

# 设置环境变量
echo "Setting up Go environment variables..."
{
    echo ''
    echo '# GoLang'
    echo "export PATH=\$PATH:/usr/local/go/bin"
    echo "export GOPATH=\$HOME/go"
    echo "export PATH=\$PATH:\$GOPATH/bin"
} >> ~/.bash_profile

# 生效环境变量
source ~/.bash_profile

# 清理压缩包
rm ${GO_TAR}

# 验证安装
go version

if [ $? -eq 0 ]; then
    echo "Go ${GO_VERSION} installed successfully."
else
    echo "Failed to install Go ${GO_VERSION}."
fi
