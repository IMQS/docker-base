FROM imqs/ubuntu-base

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update \
	&& apt-get install nodejs bzip2 openjdk-8-jre git gcc -y

# We need go to build www server
RUN curl -O https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz
RUN tar -xvf go1.8.linux-amd64.tar.gz
RUN mv go /usr/local
ENV PATH /usr/local/go/bin:$PATH


