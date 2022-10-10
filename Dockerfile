FROM ubuntu:22.04 as builder

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
         wget

WORKDIR /opt

RUN if [ $(arch) == 'aarch64' ]; then  \
      wget https://www.deb-multimedia.org/pool/main/m/mp4v2-dmo/libmp4v2-2_2.0.0-dmo6_arm64.deb;  \
      wget https://www.deb-multimedia.org/pool/main/m/mp4v2-dmo/mp4v2-utils_2.0.0-dmo6_arm64.deb;  \
    else \
      wget http://archive.ubuntu.com/ubuntu/pool/universe/m/mp4v2/libmp4v2-2_2.0.0~dfsg0-6_amd64.deb;  \
      wget http://archive.ubuntu.com/ubuntu/pool/universe/m/mp4v2/mp4v2-utils_2.0.0~dfsg0-6_amd64.deb; \
    fi


FROM ubuntu:20.04
LABEL maintainer="@ivonet"

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LC_ALL C.UTF-8
ENV LANGUAGE en_US.UTF-8

WORKDIR /opt

COPY --from=builder /opt/*.deb /opt/

RUN if [ "`uname -m`" == "aarch64" ]; then dpkg -i /opt/libmp4v2-2_2.0.0-dmo6_arm64.deb; dpkg -i /opt/mp4v2-utils_2.0.0-dmo6_arm64.deb else dpkg -i /opt/libmp4v2-2_2.0.0~dfsg0-6_amd64.deb; dpkg -i /opt/mp4v2-utils_2.0.0~dfsg0-6_amd64.deb fi \
    && rm -rf /opt/*.deb



RUN apt-get -y --no-install-recommends update \
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
        mp3wrap \
        twolame \
        mp3check \
        jq \
        mpv \
        sox \
        libpulse0 \
        libv4l-0 \
        pulseaudio \
        imagemagick \
    && apt-get upgrade -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ENTRYPOINT [""]
WORKDIR /input

COPY internal/* /usr/local/bin/
RUN chmod +x /usr/local/bin

VOLUME '/input'
VOLUME '/output'


ENTRYPOINT ["HandBrakeCLI"]
CMD ["-h"]
