# onlineBeratung-k8s-config Template
The configuration template repository with default environment settings serving required data for k8s helm chart

### Installation
`helm install <release_name> k8s -f values.yaml -f values-secrets.yaml`

### Upgrading an existing helm release
1. Make sure you have the latest changes of git submodule `k8s`
   2. `cd k8s`
   3. `git fetch`
   4. `git pull`
5. Execute helm upgrade
   6. `helm upgrade <release_name> k8s -f values.yaml -f values-secrets.yaml`