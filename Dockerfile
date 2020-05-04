FROM jlesage/baseimage-gui:ubuntu-18.04

RUN apt-get update && apt-get install -y wget libnss3 libgtk-3-0 libxss1 libasound2
RUN useradd --shell /sbin/nologin --home /app --uid 1000  -G users appuser
RUN mkdir /app && chown appuser -Rfv /app
ADD joplin /app/.joplin
USER appuser
RUN echo $USER
WORKDIR /app
RUN wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh >/app/install-joplin.sh && chmod +x /app/install-joplin.sh
#ADD install-joplin.sh /app/install-joplin.sh
RUN TERM=xterm /app/install-joplin.sh --allow-root
RUN /app/.joplin/Joplin.AppImage --appimage-extract
ADD startapp.sh /startapp.sh
USER root
RUN APP_ICON_URL=file:///app/squashfs-root//joplin.png && install_app_icon.sh "$APP_ICON_URL"
ENV APP_NAME="Joplin"
