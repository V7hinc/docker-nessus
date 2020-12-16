# docker-nessus
该docker基于ubuntu:20.04，仅做了安装nessus，未进行激活，大家安装后需进行初始化安装和激活
安装包下载来自https://www.tenable.com/downloads/nessus?loginAttempted=true

## 使用方法
```shell script
docker pull v7hinc/nessus
docker run -name nessus -p 8834:8834 -dit v7hinc/nessus
```

## 访问方式
使用浏览器访问 https:IP:8834

