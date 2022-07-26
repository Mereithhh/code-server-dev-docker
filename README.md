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
-p 80:80 \
--cpus=1 \
-m 2G --memory-swap=0 \
mereith/ubuntu-dev:latest <your password>
```

url: https://<ip>

port: ssh -> 222 code-server -> 80

## node-gyp support

```bash
apt install gcc python make g++ -y
```

## kubernetes

```
kubectl apply -f k8s-deployment.yaml
```
