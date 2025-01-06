FROM nginx:1.25.4-alpine3.18-slim

# Container metadata
ENV app1_name=muflone-rendered
ENV app1_version=2024-06-03
ENV app2_name=vbsimple-rendered
ENV app2_version=2024-11-08

LABEL maintainer="ilmuflone"
LABEL maintainer_email="muflone@muflone.com"
LABEL app_name="Muflone"
LABEL app_version="${app1_version}"

# Install the application
RUN mkdir -p "/var/www"

# Install muflone-rendered
ADD "https://github.com/muflone/${app1_name}/archive/${app1_version}.tar.gz" "/tmp/${app1_name}-${app1_version}.tar.gz"
RUN tar xzf "/tmp/${app1_name}-${app1_version}.tar.gz" -C "/tmp" && \
    rm "/tmp/${app1_name}-${app1_version}.tar.gz" && \
    mv "/tmp/${app1_name}-${app1_version}" "/var/www/muflone.com"

# Install vbsimple-rendered
ADD "https://github.com/muflone/${app2_name}/archive/${app2_version}.tar.gz" "/tmp/${app2_name}-${app2_version}.tar.gz"
RUN tar xzf "/tmp/${app2_name}-${app2_version}.tar.gz" -C "/tmp" && \
    rm "/tmp/${app2_name}-${app2_version}.tar.gz" && \
    mv "/tmp/${app2_name}-${app2_version}" "/var/www/vbsimple.net"

COPY "conf.d" "/etc/nginx/conf.d"

EXPOSE 80/tcp

