FROM jlesage/baseimage-gui:debian-13-v4

RUN apt-get update && add-pkg wget libnss3 libgtk-3-0 libxss1 libasound2 libgbm1 libfuse2
RUN useradd --shell /sbin/nologin --home /app --uid 1000  -G users appuser
RUN mkdir /app && chown appuser -Rfv /app
USER appuser
RUN echo $USER
WORKDIR /app
RUN wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh >/app/install-joplin.sh && chmod +x /app/install-joplin.sh
RUN TERM=xterm /app/install-joplin.sh --allow-root --force
RUN /app/.joplin/Joplin.AppImage --appimage-extract
ENV APPDIR=/app/squashfs-root
ADD startapp.sh /startapp.sh
USER root
ADD https://raw.githubusercontent.com/laurent22/joplin/dev/Assets/LinuxIcons/256x256.png /app/joplin-logo.png
RUN APP_ICON_URL=file:///app/joplin-logo.png && install_app_icon.sh "$APP_ICON_URL"
ENV APP_NAME="Joplin"
