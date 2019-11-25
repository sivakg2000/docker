FROM alpine:latest
LABEL maintainer="dpet23"

# Install git
RUN apk --update add --no-cache git 
RUN mkdir ~/kibana-build/ && cd ~/kibana-build && git clone https://github.com/elastic/kibana.git
RUN cd ~/kibana-build/kibana && git checkout v5.6.10 && mkdir ../v5.6.10 && cp -rvf * ../v5.6.10/
RUN cd ~/kibana-build/kibana && git checkout v6.8.2 && mkdir ../v6.8.2 && cp -rvf * ../v6.8.2/
RUN cd ~/kibana-build/kibana && git checkout v7.3.0 && mkdir ../v7.3.0 && cp -rvf * ../v7.3.0/

