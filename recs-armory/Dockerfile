FROM mcr.microsoft.com/powershell:latest

# Install dependencies (curl, gnupg, unzip)
RUN apt-get update && \
    apt-get install -y curl gnupg unzip && \
    rm -rf /var/lib/apt/lists/*

# Install Python
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Install Helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install Google Cloud SDK (gcloud CLI)
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
    tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
    gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && \
    apt-get update && \
    apt-get install -y google-cloud-sdk

# Install Azure CLI (az)
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Install kubelogin
RUN curl -LO https://github.com/Azure/kubelogin/releases/download/v0.0.20/kubelogin-linux-amd64.zip && \
    unzip kubelogin-linux-amd64.zip && \
    mv bin/linux_amd64/kubelogin /usr/local/bin/ && \
    rm -rf kubelogin-linux-amd64.zip bin/

# Download Istio
RUN curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.17.1 TARGET_ARCH=x86_64 sh -
RUN mv istio-1.17.1 /opt/istio

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/

# Set the entrypoint script as executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the default shell to PowerShell
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Set the working directory
WORKDIR /app

# Set the entrypoint script as the container entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]