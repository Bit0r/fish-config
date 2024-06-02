FROM ghcr.io/paperless-ngx/paperless-ngx

# 换源，安装tesseract-ocr-all
RUN sed -i 's/deb.debian.org/mirrors.huaweicloud.com/g' /etc/apt/sources.list.d/debian.sources;\
	apt install apt-transport-https ca-certificates;\
	apt -y update;\
	apt -y install tesseract-ocr-all;
