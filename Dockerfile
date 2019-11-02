FROM mvertes/alpine-mongo:4.0.6-1

COPY run.sh /root/

ENTRYPOINT [ "/root/run.sh" ]

CMD [ "--bind_ip_all" ]