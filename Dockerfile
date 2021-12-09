FROM python

WORKDIR /

COPY ./server.py .

CMD /server.py