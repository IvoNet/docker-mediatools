FROM ubuntu:20.10
LABEL maintainer="@ivonet"

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LC_ALL C.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update \
    && apt-get -y --no-install-recommends install software-properties-common \
    && add-apt-repository -y ppa:stebbins/handbrake-releases \
    && apt-get -y --no-install-recommends update \
    && apt-get -y --no-install-recommends install \
    handbrake-cli \
    mkvtoolnix \
    ffmpeg \
    mplayer \
    mencoder \
    melt \
    atomicparsley \
    mp4v2-utils \
    id3v2 \
    eyed3 \
    mp3info \
    youtube-dl \
    faac \
    faad \
    x264 \
    x265 \
    xvidenc \
    flac \
    id3v2 \
    lame \
    twolame \
    mp3check \
    mpv \
    libpulse0 \
    libv4l-0 \
    pulseaudio \
    imagemagick \
    && apt-get clean

WORKDIR /input

COPY internal/* /usr/local/bin/
RUN chmod +x /usr/local/bin
# && echo "root:secret" | chpasswd \
# && chmod 777 /input

#RUN groupadd -r user \
# && useradd -r -g user -G audio,video user \
# && mkdir -p /home/user/Downloads \
# && chown -R user:user /home/user
#
#USER user

VOLUME '/input'
VOLUME '/output'


ENTRYPOINT ["HandBrakeCLI"]
CMD ["-h"]
