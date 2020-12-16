FROM ubuntu:20.04
MAINTAINER V7hinc

ENV NESSUS_VERSION="8.13.0"
ENV NESSUS_FILE_NAME="Nessus-${NESSUS_VERSION}-ubuntu1110_amd64.deb"

WORKDIR "/opt/nessus"

RUN set -x;\
# update
apt-get update;\
apt-get install curl -y;
RUN set -x;\
# Find the download-id
sed_script='s/.*"id":\([0-9]*\),"file":"'${NESSUS_FILE_NAME}'","name":.*/\1/p';\
DOWNLOAD_ID=$(curl -ssl -o - "https://www.tenable.com/downloads/nessus?loginAttempted=true" | sed -n -e $sed_script);\
download_url="https://www.tenable.com/downloads/api/v1/public/pages/nessus/downloads/${DOWNLOAD_ID}/download?i_agree_to_tenable_license_agreement=true";\
# download install file
curl -ssL -o ${NESSUS_FILE_NAME} $download_url;\
ls -lh;\
# set timezone
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime;\
echo "Asia/Shanghai" > /etc/timezone;\
apt-get install tzdata;\
dpkg-reconfigure -f noninteractive tzdata

RUN set -x;\
# install
dpkg -i ${NESSUS_FILE_NAME};\
# remove install file
rm -f ${NESSUS_FILE_NAME}


EXPOSE 8834
CMD ["/etc/init.d/nessusd start"]
