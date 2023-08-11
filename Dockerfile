ARG ARCH=
FROM bayrell/alpine_php_fpm:7.4-9${ARCH}

ADD download /src/download
RUN cd ~; \
	apk update; \
	apk upgrade; \
	apk add python3 python3-dev py3-pip gcc g++ musl-dev linux-headers openssl-dev libffi-dev php7-pdo php7-pdo_pgsql zlib-dev jpeg-dev postgresql-dev postgresql-client make uwsgi uwsgi-python3 libpq libstdc++ libgcc; \
	pip3 install --upgrade pip; \
	pip3 install -r /src/download/requirements_7.0.txt; \
	apk del gcc g++ musl-dev linux-headers openssl-dev libffi-dev zlib-dev jpeg-dev postgresql-dev make; \
	rm -rf /src/download; \
	rm -rf /var/cache/apk/*; \
	echo 'Ok'
	
ADD files /src/files
RUN cd ~; \
	rm -rf /var/www/html; \
	cp -rf /src/files/etc/* /etc/; \
	cp -rf /src/files/root/* /root/; \
	cp -rf /src/files/var/www/html /var/www/; \
	cp /root/config_local.py /usr/lib/python3.9/site-packages/pgadmin4; \
	ln -s /data/pgadmin /var/lib/pgadmin; \
	rm -rf /src/files; \
	chmod +x /root/run.sh; \
	echo 'Ok'
