#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

function error() {
    echo $1
    exit 1
}

plan_file="bin/plan"
backend_config="${DIR}/backend.gme-testing.config"

which dotnet >/dev/null     || error ".NET CLI 'dotnet' must be available on the path"
which az >/dev/null         || error "Azure CLI 'az' must be available on the path"
which terraform >/dev/null  || error "Terraform CLI 'terraform' must be available on the path"

mkdir -p bin

# terraform init -backend-config=${backend_config} .. || error "Terraform init failed"
terraform validate || error "Terraform validate failed"
terraform plan -out ${plan_file} || error "Terraform plan failed"
terraform apply ${plan_file} || error "Terraform apply failed"
