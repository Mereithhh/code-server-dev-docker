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
    apt-get update && apt-get install -y git curl vim tmux net-tools openssh-server zsh
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)"
SHELL ["/bin/zsh","-c"]
RUN echo 'export NVM_DIR="/root/.nvm"' >> /root/.zshrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" ' >> /root/.zshrc && \
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> /root/.zshrc && \
    source /root/.zshrc && \
    export NVM_DIR="/root/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  && \
    nvm install v16.16.0 && nvm alias system v16.16.0 && nvm alias system v16.16.0 && \
    npm config set registry https://registry.npm.taobao.org &&   \
    npm install -g yarn --registry=https://registry.npm.taobao.org && \
    yarn config set registry https://registry.npm.taobao.org -g && \
    yarn config set sass_binary_site http://cdn.npm.taobao.org/dist/node-sass -g && \
    curl -fsSL https://code-server.dev/install.sh | sh && \
    mkdir -p /root/.config/code-server/ && \
    echo "bind-addr: 0.0.0.0:13337" > /root/.config/code-server/config.yaml && \
    echo "auth: none" >> /root/.config/code-server/config.yaml && \
    echo "password: admin" >> /root/.config/code-server/config.yaml && \
    echo "cert: false" >> /root/.config/code-server/config.yaml
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
COPY entrypoint.sh /
RUN chmod 777 /entrypoint.sh
EXPOSE 13337 222 
VOLUME [ "/code"]
CMD [ "/entrypoint.sh"]

