FROM nginx@sha256:6af79ae5de407283dcea8b00d5c37ace95441fd58a8b1d2aa1ed93f5511bb18c AS build

RUN apt-get update \ 
  && apt-get -y install wget ca-certificates \
  && TEMP_DEB="$(mktemp)" \
  && wget -O "$TEMP_DEB" "https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.54/quarto-1.5.54-linux-amd64.deb" --no-check-certificate \
  && dpkg -i "$TEMP_DEB" \
  && rm -f "$TEMP_DEB" \
  && apt-get autoremove -y \
  && apt-get autoclean -y \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/*

COPY presentation /mysite
COPY presentation/html /usr/share/nginx/html/html

RUN quarto render /mysite/index.ipynb --output-dir /usr/share/nginx/html/

FROM nginx@sha256:6af79ae5de407283dcea8b00d5c37ace95441fd58a8b1d2aa1ed93f5511bb18c
COPY --from=build /usr/share/nginx/html /usr/share/nginx/html

EXPOSE 80