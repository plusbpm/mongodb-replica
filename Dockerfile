FROM mvertes/alpine-mongo:4.0.6-1

RUN echo -n "Install packages ..." && \
  apk add --no-cache tzdata > /dev/null && \
  echo " done" && \
  echo -n "Timezone settings ..." && \
  cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \
  echo "Europe/Moscow" >  /etc/timezone && \
  echo " done" && \
  echo -n "Delete packages..." && \
  apk del tzdata > /dev/null 2>/dev/null && \
  echo " done"

COPY run.sh /root/

ENTRYPOINT [ "/root/run.sh" ]

CMD [ "--bind_ip_all" ]