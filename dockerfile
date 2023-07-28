# 使用官方的Nginx镜像作为基础镜像
FROM nginx:latest

# 默认行为，在容器内创建挂载点或声明卷，作为匿名卷，二次保护，避免run时候忘记挂载，从而导致数据丢失。如果创建匿名卷之后，再次挂载，会覆盖匿名卷。如果没有挂载，匿名卷也不会被删除，将宿主机的目录指向该匿名点，可以看到匿名卷的内容。
VOLUME ["/vueweb"]

# 更新apt-get
RUN apt-get update

# 安装vim
RUN apt-get install -y vim

# 安装PHP和php-fpm
RUN apt-get install -y php-fpm

# 安装php-mysql扩展
RUN apt-get install -y php-mysql

# 安装MySQL客户端，用于连接MySQL数据库
RUN apt-get install -y default-mysql-client

# 设置PHP-FPM配置文件
COPY ./www.conf /etc/php/8.2/fpm/pool.d/www.conf

# 设置Nginx配置文件，包括反向代理到php-fpm的设置
COPY ./default.conf /etc/nginx/conf.d

#安装wget unzip lsof
RUN apt-get install -y wget
RUN apt-get install -y unzip
RUN apt-get install -y lsof

# 获取phpmyadmin
RUN cd / && mkdir phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-all-languages.zip
RUN unzip ./phpMyAdmin-5.0.1-all-languages.zip
RUN rm -rf ./phpMyAdmin-5.0.1-all-languages.zip
RUN mv phpMyAdmin-5.0.1-all-languages /phpmyadmin

# # 暴露Nginx和phpMyAdmin的端口
# EXPOSE 80

# 启动Nginx和php-fpm
# CMD ["nginx", "-g", "daemon off;", "&", "php-fpm8.2", "-F"]
# RUN chmod -R 777 /run/php/php8.2-fpm.sock
# RUN service php8.2-fpm restart

# CMD ["php8.2-fpm", "-F"]


# 清理 & 检查
## 清理无用的包
RUN apt-get clean
## 清理无用的包
RUN apt-get autoclean
## 检查是否有损坏的依赖
RUN apt-get check
