function error() {
    echo $1
    exit 1
}

which dotnet >/dev/null     || error ".NET CLI 'dotnet' must be available on the path"
which az >/dev/null         || error "Azure CLI 'az' must be available on the path"
which terraform >/dev/null  || error "Terraform CLI 'terraform' must be available on the path"

az feature register --name WindowsPreview --namespace Microsoft.ContainerService || error "Failed to register Microsoft.ContainerService/WindowsPreview feature"
az feature register --name PodSecurityPolicyPreview --namespace Microsoft.ContainerService || error "Failed to register Microsoft.ContainerService/PodSecurityPolicyPreview feature"
az provider register -n Microsoft.ContainerService || error "Failed to register Microsoft.ContainerService provider"
