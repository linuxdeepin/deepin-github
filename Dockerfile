FROM debian:sid-slim
RUN apt update
RUN apt install -y sudo pbuilder devscripts ca-certificates

COPY entrypoint.sh /entrypoint.sh
ADD common /app/common
ADD repos /app/repos

ENTRYPOINT ["/entrypoint.sh"]
