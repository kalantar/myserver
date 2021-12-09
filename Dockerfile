FROM python

WORKDIR /

COPY ./server.py .

EXPOSE 8080

CMD /server.py