FROM petronije2002/complete_builder as builder 



FROM python:3.5-alpine as base


COPY --from=builder /install /usr/local
# COPY --from=builder /usr/lib /usr/lib/

COPY --from=builder /usr/lib/libtdsodbc.so /usr/lib/
COPY --from=builder /usr/lib/libstdc++.so.6 /usr/lib/
COPY --from=builder /usr/lib/libodbc.so.2 /usr/lib/

COPY ./odbcinst.ini /etc/

RUN apk update
RUN echo "http://dl-4.alpinelinux.org/alpine/v3.5/main" >> /etc/apk/repositories && \
	echo "http://dl-4.alpinelinux.org/alpine/v3.5/community" >> /etc/apk/repositories
# RUN ln -s /usr/include/locale.h /usr/include/xlocale.h
RUN apk add libstdc++6 unixodbc libstdc++6


RUN apk add curl unzip libexif udev chromium chromium-chromedriver xvfb 
# RUN apk add libexif udev chromium-driver="61.0.3163.100-r0" chromium="61.0.3163.100-r0" 

ENV PYTHONPATH /usr/local

CMD ["bin/sh"]

