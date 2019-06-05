FROM petronije2002/complete_builder as builder 


RUN apk update
RUN echo "http://dl-4.alpinelinux.org/alpine/v3.5/main" >> /etc/apk/repositories && \
	echo "http://dl-4.alpinelinux.org/alpine/v3.5/community" >> /etc/apk/repositories

RUN apk add curl unzip libexif udev chromium chromium-chromedriver xvfb 

# CMD ["bin/sh"]



FROM python:3.5-alpine as base


COPY --from=builder /install /usr/local

COPY --from=builder /usr/lib/libtdsodbc.so /usr/lib/libstdc++.so.6 /usr/lib/libodbc.so.2 /usr/lib/chromium/ /usr/lib/

COPY ./odbcinst.ini /etc/ 


RUN apk add libstdc++6 unixodbc libstdc++6




ENV PYTHONPATH /usr/local

CMD ["bin/sh"]

