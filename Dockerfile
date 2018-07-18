FROM alpine:3.7
MAINTAINER "Kief Morris <cloudspin@kief.com>"

RUN apk update && apk upgrade

RUN apk --no-cache add \
  bash \
  ncurses \
  perl \
  ruby \
  ruby-rake \
  ruby-bundler \
  ruby-dev \
  build-base \
  libstdc++ \
  tzdata \
  ca-certificates

RUN echo 'gem: --no-document' > /etc/gemrc
RUN echo 'gem: --no-ri' >> /etc/gemrc
RUN bundle config --global silence_root_warning 1

# RUN addgroup -S spinner && \
#     adduser -S -G spinner spinner
# USER spinner

COPY ./ /package/
WORKDIR /package

ENV GO_DEBUG=true

RUN ./go -T

ENTRYPOINT ["./go"]
CMD ["-T"]
