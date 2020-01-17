# CSDN地址：[点击前往](https://blog.csdn.net/wrkd35/article/details/104015935)

# GitHub地址：[点击前往](https://github.com/wrkd35/Docker-War)

### 得到源码以后，只需把项目里的数据库的配置更改为自己本地的，然后重新打包放在tomcat目录下，再把docker-ssm/SQL目录下的数据库脚本导入到本地。

目录结构：

![img](https://img-blog.csdnimg.cn/20200117110905916.png)![点击并拖拽以移动](data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==)

# War包部署

- 项目打包成war包，放入docker-ssm/tomcat下
- 编写tomcat镜像的Dockerfile

```
# 直接从docker提供的远程镜像仓库中拉取最新的tomcat组件
FROM tomcat

# 本镜像的制作者的信息
MAINTAINER "wrkd35" <2819736494@qq.com>

# 把该容器的时区设置为北京时区
ENV TZ=Asia/Shanghai

# 把当前文件目录下的docker-ssm.war移动到容器中tomcat自动启动的目录下
COPY ./Docker-CustomerSystem.war /usr/local/tomcat/webapps/
```

- 编写mysql镜像的Dockerfile

```
FROM mysql:latest

MAINTAINER "wrkd35" <2819736494@qq.com>

# mysql的工作位置
ENV WORK_PATH /usr/local/

# 定义会被容器自动执行的目录
ENV AUTO_RUN_DIR /docker-entrypoint-initdb.d

# 初始化数据库的SQL文件
ENV FILE_0 customersystem.sql

# 执行SQL
ENV INSTALL_DATA_SHELL docker-entrypoint.sh

# 把要执行的sql文件放到MySQL的工作目录下
COPY ./$FILE_0 $WORK_PATH/

# 把要执行的shell文件放到/docker-entrypoint-initdb.d/目录下，容器会自动执行这个shell
COPY ./$INSTALL_DATA_SHELL $AUTO_RUN_DIR/

# 给执行文件增加可执行权限
RUN chmod a+x $AUTO_RUN_DIR/$INSTALL_DATA_SHELL
```

- 编写docker-compose.yml

```
version: "2"

services:                        #控制image的运行方式
  tomcat:                        #编排文件中容器的别名
    build: ./tomcat      #从当前文件目录下的tomcat文件夹下寻找Dockerfile文件开始构建tomcat镜像
    image: tomcat-customer            #构建之后镜像的名字
    container_name: tomcat-customer   #容器的名字
    restart: always              #容器重启之后总是会重新构建本镜像
    depends_on:             #依赖于mysql和redis，目的是为了在mysql和redis启动之后再启动本容器
      - mysql
    ports:
      - "3535:8080"              #冒号左边的8888代表宿主机中的端口，右边的8080代表容器中的端口

  mysql:
    build: ./mysql
    image: mysql-customer:mysql
    container_name: mysql-customer
    restart: always
    ports:
      - "3301:3306"
    volumes:    #这里多挂载了一个conf文件，目的就是为了防止mysql原始配置文件不生效，产生乱码的情况
      - "/temp/test/docker-ssm/conf:/etc/mysql/conf.d"
      - "/temp/test/docker-ssm/logs:/logs"
      - "/temp/test/docker-ssm/data:/var/lib/mysql"
    command: [
      '--character-set-server=utf8mb4',
      '--collation-server=utf8mb4_unicode_ci'
    ]
    environment:                #在mysql初始化的时候设置登陆密码
      MYSQL_ROOT_PASSWORD: ""
```

- 把docker-ssm文件夹上传至服务器
- 运行docker-compose

```
docker-compose up -d
```

- 浏览器输入以下地址，数据库可查看新增记录

```
# 主机号+端口号+项目名+接口地址
服务器IP：配置tomcat的dockerfile文件里的端口号/docker-ssm/docker/test
```