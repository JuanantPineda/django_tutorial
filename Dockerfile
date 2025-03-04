# syntax=docker/dockerfile:1
FROM python:3.12.1-bookworm
WORKDIR /usr/share/app
COPY django .
ENV DB_NAME = django
ENV DB_USER = django
ENV DB_PASSWORD = django
ENV DB_HOST = localhost
ENV DJ_USER = django
ENV DJ_PASSWORD = django
ENV DJ_EMAIL = a@a.com
ENV URL = http://localhost
RUN pip install --upgrade --no-cache-dir --break-system-packages pip && pip install --no-cache-dir --break-system-packages -r requirements.txt && pip install --no-cache-dir --break-system-packages mysqlclient
COPY script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.s
EXPOSE 3000
CMD /usr/local/bin/script.sh