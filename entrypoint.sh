#!/bin/bash
if [ $# -eq 1 ]; then
  sed -i "s/password: admin/password: $1/g"  /root/.config/code-server/config.yaml
fi
service ssh start
code-server