FROM ubuntu:18.04


ARG STRONGSWAN_LEFT=vpn1.hostname.com
ARG STRONGSWAN_LEFT_SUBNET=10.0.0.0/24
ARG STRONGSWAN_RIGHT=10.10.10.0/24
ARG STRONGSWAN_RIGHT_SUBNET=10.128.0.0/24
ARG STRONGSWAN_KEY_EXCHANGE=ikev2
ARG STRONGSWAN_PSK='presharedkey'

#envs
ENV  STRONGSWAN_LEFT $STRONGSWAN_LEFT 
ENV  STRONGSWAN_LEFT_SUBNET $STRONGSWAN_RIGHT
ENV  STRONGSWAN_RIGHT $STRONGSWAN_RIGHT
ENV  STRONGSWAN_RIGHT_SUBNET $STRONGSWAN_RIGHT_SUBNET
ENV  STRONGSWAN_KEY_EXCHANGE $STRONGSWAN_KEY_EXCHANGE
ENV  STRONGSWAN_PSK $STRONGSWAN_PSK

#run update 
RUN apt update -y

RUN apt upgrade -y
#install strongswan
RUN apt install strongswan -y

# copy Strong Swan config files
COPY conf/ipsec.conf /etc/ipsec.conf
COPY conf/ipsec.secrects /etc/ipsec.secrects
COPY conf/strongswan.conf/ /etc/strongswan.conf

#expose strong swan ports
EXPOSE 500
EXPOSE 4500
# start strong swan
CMD ["systemctl" "start" "strongswan"]    


