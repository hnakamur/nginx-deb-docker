#!/bin/bash
cd /src/nginx-tests
sudo -u nginx TEST_NGINX_UNSAFE=1 prove .
