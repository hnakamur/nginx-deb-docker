#!/bin/bash
git submodule add https://github.com/openresty/echo-nginx-module
git submodule add https://github.com/openresty/headers-more-nginx-module
git submodule add https://github.com/openresty/lua-nginx-module
git submodule add https://github.com/openresty/lua-upstream-nginx-module
git submodule add https://github.com/openresty/memc-nginx-module
git submodule add https://github.com/openresty/redis2-nginx-module
git submodule add https://github.com/openresty/set-misc-nginx-module
git submodule add https://github.com/openresty/srcache-nginx-module
git submodule add https://github.com/openresty/stream-lua-nginx-module
git submodule add https://github.com/openresty/lua-resty-balancer
git submodule add https://github.com/openresty/lua-resty-core
git submodule add https://github.com/openresty/lua-resty-dns
git submodule add https://github.com/openresty/lua-resty-lock
git submodule add https://github.com/openresty/lua-resty-limit-traffic
git submodule add https://github.com/openresty/lua-resty-lrucache
git submodule add https://github.com/openresty/lua-resty-memcached
git submodule add https://github.com/openresty/lua-resty-memcached-shdict
git submodule add https://github.com/openresty/lua-resty-mysql
git submodule add https://github.com/openresty/lua-resty-redis
git submodule add https://github.com/openresty/lua-resty-shdict-simple
git submodule add https://github.com/openresty/lua-resty-shell
git submodule add https://github.com/openresty/lua-resty-signal
git submodule add https://github.com/openresty/lua-resty-string
git submodule add https://github.com/openresty/lua-resty-upload
git submodule add https://github.com/openresty/lua-resty-upstream-healthcheck
git submodule add https://github.com/openresty/lua-resty-websocket
git submodule add https://github.com/cloudflare/lua-resty-cookie
git submodule add https://github.com/zmartzone/lua-resty-openidc
git submodule add https://github.com/cdbattags/lua-resty-jwt
git submodule add https://github.com/jkeys089/lua-resty-hmac
git submodule add https://github.com/hnakamur/nginx-var-limit-conn-module
git submodule add https://github.com/hnakamur/nginx-var-limit-req-module

# lua-resty-openidc requires lua-resty-session >= 2.8, <= 3.10
# https://github.com/zmartzone/lua-resty-openidc/commit/4b9316403e1d6a162aecea86c466f50fe78232e8
git submodule add https://github.com/bungle/lua-resty-session
(cd lua-resty-session; git checkout v3.10)

git submodule add https://github.com/pintsized/lua-resty-http
git submodule add https://github.com/FRiCKLE/ngx_cache_purge
git submodule add https://github.com/arut/nginx-rtmp-module
git submodule add https://github.com/arut/nginx-dav-ext-module
git submodule add https://github.com/bpaquet/ngx_http_enhanced_memcached_module
git submodule add https://github.com/replay/ngx_http_secure_download
git submodule add https://github.com/simplresty/ngx_devel_kit
git submodule add https://github.com/hnakamur/nginx-sorted-querystring-module
git submodule add https://github.com/pandax381/ngx_http_pipelog_module
git submodule add https://github.com/nginx-shib/nginx-http-shibboleth
git submodule add https://github.com/hnakamur/nginx-lua-saml-service-provider
git submodule add https://github.com/hnakamur/nginx-lua-session
git submodule add https://github.com/hamishforbes/lua-ffi-zlib
git submodule add https://github.com/Phrogz/SLAXML
git submodule add https://github.com/leev/ngx_http_geoip2_module
git submodule add https://github.com/e98cuenc/ngx_upstream_jdomain
git submodule add https://github.com/google/nginx-sxg-module
git submodule add https://github.com/woothee/lua-resty-woothee
git submodule add https://github.com/ruoshan/lua-resty-jump-consistent-hash
git submodule add https://github.com/nginx/njs
git submodule add https://github.com/owasp-modsecurity/ModSecurity-nginx
git submodule add https://github.com/fffonion/lua-resty-openssl
