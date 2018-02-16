FROM imqs/ubuntu-base

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update \
	&& apt-get install nodejs bzip2 openjdk-8-jre -y

# RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN npm config set user 0
RUN npm config set unsafe-perm true


RUN npm install -g phantomjs-prebuilt istanbul \
	remap-istanbul typescript@2.3.4 tslint@5.2.0 \
	svgo@0.7.2 node-sass mkdirp ncp marked@0.3.12

