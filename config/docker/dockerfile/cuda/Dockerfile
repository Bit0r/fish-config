FROM nvidia/cuda:12.5.1-devel-ubuntu24.04

# 设置环境变量，防止交互式安装
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

# 换源然后安装包
RUN sed -i 's/archive.ubuntu.com/mirrors.cernet.edu.cn/g' /etc/apt/sources.list.d/ubuntu.sources \
	&& sed -i 's/security.ubuntu.com/mirrors.cernet.edu.cn/g' /etc/apt/sources.list.d/ubuntu.sources \
	&& apt update \
	&& apt install -y locales tzdata language-pack-zh-hans \
	&& ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
	&& update-locale LANG="zh_CN.UTF-8" LANGUAGE="zh_CN:zh" LC_ALL="zh_CN.UTF-8" \
	&& dpkg-reconfigure --frontend noninteractive tzdata \
	&& apt install -y ubuntu-standard \
	lnav micro pip bat ripgrep \
	python-dev-is-python3 software-properties-common \
	ssh ssh-client \
	fonts-noto fonts-firacode ibus-pinyin ibus-rime psmisc dbus-x11 'xorg*' 'xfce4*' '*tigervnc*' \
	&& add-apt-repository -yP fish-shell/release-3 \
	&& apt install -y fish \
	&& mkdir -p /etc/fish/conf.d/ \
	&& chsh -s /usr/bin/fish
# && apt autoremove -y \
# && apt autoclean -y \
# && apt clean -y \
# && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 设置输入法
COPY ibus.fish /etc/fish/conf.d/ibus.fish

# 指定SHELL
SHELL ["fish", "-c"]
CMD ["fish"]

# 暴露ssh端口
EXPOSE 22
# 暴露vnc端口
EXPOSE 5900-5910

# 设置工作目录
WORKDIR /root
