FROM fedora:30

ENV ASPNETCORE_PKG_VERSION=2.2.1
ENV DOTNET_SDK_VERSION 3.0.100
ENV ASPNETCORE_VERSION 3.0.0
ENV IMAGE_DATE 2019-10-29
ENV IMAGE_NUM 001
ENV IMAGE_SDK 3.0.01

ENV RELEASE_HASH=c7175d89a278f64d71c86e48c790538694beeda76f5c0dd95d433f8f970d00ffe2a943d5df4751d8671c540a401a60456040f29e96c3878459f2c61ace8fe63f
ENV RELEASE_FILE=nuget.tar.gz
ENV RELEASE_VERSION=0.0.1

#https://github.com/imdocker/dotnet-core3-sdk-cached

RUN dnf update -y && dnf install wget -y && \
  export DOTNET_CLI_TELEMETRY_OPTOUT=1 && \
  set -ex \
    && dnf install -y https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm \
    && dnf install -y https://packages.microsoft.com/rhel/7/prod/dotnet-host-2.1.0-x64.rpm \
    && dnf install dotnet-sdk-3.0 wget libunwind nano mc compat-openssl10 icu iputils xz -y \
    && dnf clean all \
    && mkdir warmup \
    && cd warmup \
    && echo Telemetry is off $DOTNET_CLI_TELEMETRY_OPTOUT && dotnet new \
    && cd .. \
    && rm -rf warmup \
&& rm -rf /tmp/NuGetScratch \
&& dnf update -y && dnf install openssh-clients wget -y && \
  set -ex \
  && cd /root && wget --quiet https://github.com/imdocker/dotnet-core3-sdk-cached/releases/download/${RELEASE_VERSION}/${RELEASE_FILE} -O nuget.tar.gz \
  && echo "${RELEASE_HASH}  nuget.tar.gz" | sha512sum -c \
  && tar -xf nuget.tar.gz && rm nuget.tar.gz && dnf clean all
