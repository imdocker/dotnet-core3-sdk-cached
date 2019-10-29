FROM fedora:30

ENV ASPNETCORE_PKG_VERSION=2.2.1
ENV DOTNET_SDK_VERSION 3.0.100
ENV ASPNETCORE_VERSION 3.0.0
ENV IMAGE_DATE 2019-10-29
ENV IMAGE_NUM 001
ENV IMAGE_SDK 3.0.01


#Use with dotnet-core4cache
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
&& rm -rf /tmp/NuGetScratch
