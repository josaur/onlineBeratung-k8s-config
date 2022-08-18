# onlineBeratung-k8s-config Template
The configuration template repository with default environment settings serving required data for k8s helm chart.
It already provides the accoring k8s resources within a submodule pointing to kubernetes repository.

### Prerequisits
1. Up and running kubernetes cluster (e.g. minikube)
2. kubectl
3. helm
4. Lens (optional but recommended for having a view on k8s cluster)

### Installation
1. In order to be able to pull images from docker repository you create a Kubernetes secret named registry-secret\
`kubectl create secret docker-registry registry-secret --docker-server=docker.pkg.github.com --docker-username=your-github-username --docker-password=[your-github-password] --docker-email=[your-email]`
2. Install the nginx Ingress Controller for Kubernetes\
`helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace`
3. Create following namespaces with kubectl:\
`kubectl create namespace jitsi`\
`kubectl create namespace backup`\
`kubectl create namespace calcom`
4. Execute the script: for non helm managed resources\
`./customization/setup_customization_configmaps.sh <namespace> <release_name>`
5. Install the helm chart\
`helm install <release_name> k8s -f values.yaml -f values-secrets.yaml`

### Upgrading an existing helm release
1. Make sure you have the latest changes of git submodule `k8s` \
`cd k8s`\
`git fetch`\
`git pull`
5. Execute helm upgrade\
`helm upgrade <release_name> k8s -f values.yaml -f values-secrets.yaml`