FROM ubuntu:18.04
WORKDIR /code
ENV TZ=Asia/shanghai
COPY zoneinfo /usr/share/
COPY nvm/ /root/.nvm/
SHELL ["/bin/bash","-c"]
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \ 
    rm -rf /bin/sh && ln -s /bin/bash /bin/sh && \ 
    echo "Asia/Shanghai" > /etc/timezone && \
    sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list && \
    sed -i s@/security.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list && \
    apt-get update && apt-get install -y git curl vim tmux net-tools gcc python make g++ openssh-server &&  \
    sed -i 's/#Port 22/Port 222/g' /etc/ssh/sshd_config && \
    echo 'export NVM_DIR="/root/.nvm"' >> /root/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" ' >> /root/.bashrc && \
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> /root/.bashrc && \
    source /root/.bashrc && \
    export NVM_DIR="/root/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  && \
    nvm install v14.17.6 && nvm alias system v14.17.6 && nvm alias system v14.17.6 && \
    npm config set registry https://registry.npm.taobao.org &&   \
    npm install -g yarn --registry=https://registry.npm.taobao.org && \
    yarn config set registry https://registry.npm.taobao.org -g && \
    yarn config set sass_binary_site http://cdn.npm.taobao.org/dist/node-sass -g && \
    curl -fsSL https://code-server.dev/install.sh | sh && \
    mkdir -p /root/.config/code-server/ && \
    echo "bind-addr: 0.0.0.0:2333" > /root/.config/code-server/config.yaml && \
    echo "auth: password" >> /root/.config/code-server/config.yaml && \
    echo "password: admin" >> /root/.config/code-server/config.yaml && \
    echo "cert: false" >> /root/.config/code-server/config.yaml
EXPOSE 2333 222 3000 3001 3002
VOLUME [ "/code"]
ENTRYPOINT [ "/entrypoint.sh"]

