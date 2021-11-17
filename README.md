# code-server-dev-docker
code-server with node nvm in docker
## requirement
```
echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf && sysctl -p
```
## usage
```
docker pull mereith/ubuntu-dev:latest
docker run -d --name ubuntu-dev -v $(pwd):/code --network host mereith/ubuntu-dev:latest 
# ssh -> 223 , code-server -> 2333
```
