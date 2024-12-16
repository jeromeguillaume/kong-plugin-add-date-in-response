# Delete the Kong Gateway container
docker rm -f kong-gateway-add-date-in-response

export ARCHITECTURE=arm64

# Start Kong Gateway
docker run -d --name kong-gateway-add-date-in-response \
--network=kong-net \
--link kong-database-add-date-in-response:kong-database-add-date-in-response \
--mount type=bind,source="$(pwd)"/kong/plugins/add-date-in-response,destination=/usr/local/share/lua/5.1/kong/plugins/add-date-in-response \
-e "KONG_DATABASE=postgres" \
-e "KONG_PG_HOST=kong-database-add-date-in-response" \
-e "KONG_PG_USER=kong" \
-e "KONG_PG_PASSWORD=kongpass" \
-e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
-e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
-e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
-e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
-e "KONG_PROXY_LISTEN=0.0.0.0:7000, 0.0.0.0:7443 ssl http2" \
-e "KONG_ADMIN_LISTEN=0.0.0.0:7001, 0.0.0.0:7444 ssl http2" \
-e "KONG_ADMIN_GUI_LISTEN=0.0.0.0:7002, 0.0.0.0:7445 ssl" \
-e "KONG_ADMIN_GUI_URL=http://localhost:7002" \
-e "KONG_PLUGINS=bundled,add-date-in-response" \
-e "KONG_LOG_LEVEL=debug" \
-e "KONG_NGINX_WORKER_PROCESSES=1" \
-e KONG_LICENSE_DATA \
-p 7000:7000 \
-p 7443:7443 \
-p 7001:7001 \
-p 7002:7002 \
-p 7444:7444 \
--platform linux/$ARCHITECTURE \
kong/kong-gateway:3.9.0.0

echo 'docker logs kong-gateway-add-date-in-response -f'