# onlineBeratung-k8s-config Template
The configuration template repository with default environment settings serving required data for k8s helm chart.
It already provides the accoring k8s resources within a submodule pointing to kubernetes repository.

### Prerequisits
1. Up and running kubernetes cluster (e.g. minikube)
2. kubectl
3. helm
4. Lens (optional but recommended for having a view on k8s cluster)

### Installation
1. If you install the chart on a local cluster and use the default configuration make sure you have 
the following local domain mappings in `/etc/hosts` (Linux) or `C:\Windows\System32\drivers\etc\hosts` (Windows)
- `onlineberatung.localhost -> 127.0.0.1`
- `video.onlineberatung.localhost -> 127.0.0.1`
2. In order to be able to pull images from docker repository you create a Kubernetes secret named registry-secret\
`kubectl create secret docker-registry registry-secret --docker-server=ghcr.io --docker-username=<your-github-username> --docker-password=<your-github-password> --docker-email=<your-email>`
3. Install the nginx Ingress Controller for Kubernetes\
`helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace`
4. Execute the script: for non helm managed resources\
`sh ./customization/setup_customization_configmaps.sh <namespace> <release_name>`
5. Install the helm chart\
`helm install <release_name> k8s -f values.yaml -f values-secrets.yaml`

### Upgrading an existing helm release based on a branch
1. Make sure you have the latest changes of git submodule if you work on a branch \
`cd k8s`\
`git fetch`\
`git pull`
2. Execute helm upgrade\
`helm upgrade <release_name> k8s -f values.yaml -f values-secrets.yaml`

### Upgrading an existing helm release based on released tag
1. Make sure you have the release tag you want to deploy checked out for \
   `cd k8s`\
   `git fetch`\
   `git checkout tags/<release_tag>`
2. Execute helm upgrade\
   `helm upgrade <release_name> k8s -f values.yaml -f values-secrets.yaml`