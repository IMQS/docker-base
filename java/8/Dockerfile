FROM imqs/ubuntu-base

RUN apt-get update \
	&& apt-get install openjdk-8-jre -y

# Create a symlink to the real log directory
RUN mkdir -p /imqsvar
RUN ln -s /var/log/imqs /imqsvar/logs
