FROM mariadb
MAINTAINER Salvatore Foderaro <salvatore.foderaro@gmail.com>

RUN mkdir -p /bdc
WORKDIR /bdc
COPY . .

RUN apt-get update
RUN apt-get install -y gcc make automake autoconf libncurses-dev libmariadbd-dev libssl-dev procps #libmariadbclient-dev

CMD ./run.sh
