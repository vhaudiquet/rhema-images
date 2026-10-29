# sandbox image for AI agents
FROM ubuntu:26.04

# C.UTF-8 needs no locales package; the base ships it.
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        fd-find \
        git \
        jq \
        openssh-client \
        python3 \
        ripgrep \
        sd \
        bash \
    && ln -sf /usr/bin/fdfind /usr/local/bin/fd \
    && rm -rf /var/lib/apt/lists/*

ARG YQ_VERSION=v4.54.1
RUN curl -fsSL -o /usr/local/bin/yq \
        "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64" \
    && chmod +x /usr/local/bin/yq

# Smoke test: every executable rhema probes must answer.
RUN rg --version && fd --version && jq --version && yq --version \
    && sd --version && curl --version >/dev/null \
    && git --version && python3 --version && bash --version >/dev/null
