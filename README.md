# code-server-dev-docker
code-server with node nvm in docker
## requirement
```
echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf && sysctl -p
```
## usage
cpu & mem limit depends on you.
```
docker pull mereith/ubuntu-dev:latest
docker run -d --name ubuntu-dev -v $(pwd):/code --network host  \
--cpus=1 \
-m 2G --memory-swap=0 \
mereith/ubuntu-dev:latest <your password>
# ssh -> 223 , code-server -> 2333
```
https://<your ip>:2333
## kubernetes
```
kubectl apply -f k8s-deployment.yaml
```
