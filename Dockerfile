FROM alpine:3.18.5 

# RUN apk update

RUN adduser -D -g users user
RUN mkdir -p /home/user \
    && chown user:users /home/user

RUN apk add --update --no-cache xvfb x11vnc fluxbox xdpyinfo st vim terminus-font \
    && sed -r -i "s/\[exec\] \(xterm\) \{xterm\}/\[exec\] \(st\) \{st -f 'xos4 Terminus-14'\}/" /usr/share/fluxbox/menu \
    && mkdir -p /opt \
    && rm -vrf /var/cache/apk/*

COPY bootstrap.sh /opt

USER user
ENV HOME /home/user
WORKDIR /home/user
CMD ["/opt/bootstrap.sh"]
