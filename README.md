## 基于docker，由于服务器的频繁更换，方便网站进行快速迁移启动

### 构建镜象
```bash
$ docker build -t vueweb .
```
### 运行容器 如果没有显性-v进行数据卷，默认行为，删除容器，卷也会被删除
```bash
# 匿名数据卷
$ docker run -itd --name blog -p 80:80 vueweb
# 基于挂载目录的具名数据卷
$ docker run -itd -v /Users/daipeng/opt/docker-vueweb:/vueweb --name blog -p 80:80 vueweb
# 基于挂载点的具名数据卷
$ docker run -itd -v bucket:/vueweb --name blog -p 80:80 vueweb
```

### 注意
- 具名数据卷可以保持数据的可恢复性，数据会保存在宿主机上。
- 匿名数据卷在容器删除后会被删除，数据不会保存在宿主机上，所以容器删除后容器内的数据卷会消失。

### Dockerfile通常会包含如下命令：
- FROM：用于指定父镜像，如centos:7.6.1810，除了注释行，FROM要放在Dockerfile文件的第一行；
- ADD：用于添加宿主机的文件、目录等资源到镜像中，会自动解压tar.gz格式压缩包，不会自动解压zip压缩包；
- COPY：类似于ADD，也是用于添加宿主机的文件、目录等资源到镜像中，但不会自动解压任何压缩包；
- MAINTAINER：标注镜像的作者信息；
- LABEL：设置镜像的属性标签；
- ENV：用于设置容器的环境变量；
- USER：指定运行操作的用户；
- RUN：执行shell命令，但必须是非交互式的，例如yum/apt install安装服务一定要加上-y；
- VOLUME：用于定义卷，例如将宿主机的某个目录挂载到容器中；
- WORKDIR：用于定义工作目录；
- EXPOSE：声明要把容器的哪些端口映射到宿主机；
- CMD：指定镜像启动为容器时的默认命令或脚本；
- ENTRYPOINT：也可以指定容器启动时的命令或脚本，如果和CMD同时使用，会将CMD的命令当做参数传递给ENTRYPOINT后面的脚本

### 查看nginx和php-fpm状态
```bash
$ ps aux | grep nginx
$ ps aux | grep php-fpm
```

### 启动php-fpm状态
```bash
$ service php8.2-fpm restart
$ service nginx restart
```

### 修改php8.2-fpm.sock的权限（设置用户组之后，可以不设置此权限）
```bash
$ chmod -R 777 /run/php/php8.2-fpm.sock
```