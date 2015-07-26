FROM ubuntu-debootstrap:14.04.2
COPY zinstall.txt /tmp/
RUN cd /tmp/ && \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl && \
    curl -SL https://support.riverbed.com/bin/support/download?sid=gpbcgqit0ur1m1nqh8r0qh6eeo > installer.tgz && \
    tar -zxvf installer.tgz && \
	 /tmp/Zeus*/zinstall --replay-from=/tmp/zinstall.txt --noninteractive && \
    rm -rf /tmp/* && \
    apt-get clean
COPY zconfig.txt runzeus.sh /usr/local/zeus/
# ZEUS_EULA must be set to "accept" otherwise the container will do nothing
ENV ZEUS_EULA=
# ZEUS_LIC can be used to pass a URL from which the container will download a license file
ENV ZEUS_LIC=
# ZEUS_PASS can be used to set a password. By default a password will be generated for you
ENV ZEUS_PASS=RANDOM
# ZEUS_DOM can be used to set a domain and ensure the host has a FQDN.
ENV ZEUS_DOM=
# ZEUS_PACKAGES can be used to install additional packages on first run. 
# If you need Java Extensions.... Eg ZEUS_PACKAGES="openjdk-7-jre-headless"
ENV ZEUS_PACKAGES=
CMD [ "/usr/local/zeus/runzeus.sh" ]
EXPOSE 9070 9080 9090 80 443
