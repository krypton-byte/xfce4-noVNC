from python:3.9
RUN set -ex;\
    apt-get update;\
    apt-mark hold keyboard-configuration;\
    apt-get install git tightvncserver expect websockify qemu-system-x86 xfce4 -y
ENV DISPLAY=:0
RUN pip3 install websockify pyngrok
#OPSIONAL
RUN wget --no-check-certificate https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i google-chrome-stable_current_amd64.deb || apt -y -f install
RUN wget https://chromedriver.storage.googleapis.com/88.0.4324.96/chromedriver_linux64.zip&& unzip chromedriver_linux64.zip -d /bin
RUN apt-get install nodejs npm xfce4-terminal byobu sqlitebrowser geany feh openssh-server php busybox neofetch htop tmate tmux -y
#----------------------
RUN mkdir /work
RUN cd /work&&git clone https://github.com/novnc/noVNC/
COPY . /work
WORKDIR /work
CMD rm /work/Dockerfile&& Xvnc :0 -geometry 1280x720&startxfce4&python3 ngrok_.py&cd /work/noVNC && ./utils/novnc_proxy --vnc :5900 --listen ${PORT}
