# onlineBeratung-k8s-config Template
The configuration template repository with default environment settings serving required data for k8s helm chart.
It already provides the accoring k8s resources within a submodule pointing to kubernetes repository.

### Prerequisits
1. Up and running kubernetes cluster (e.g. minikube)
2. kubectl
3. helm
4. Lens (optional but recommended for having a view on k8s cluster)

### Installation
1. In order to be able to pull images from docker repository you create a Kubernetes secret named registry-secret
   2. `kubectl create secret docker-registry registry-secret --docker-server=docker.pkg.github.com --docker-username=your-github-username --docker-password=[your-github-password] --docker-email=[your-email]`
3. Install the nginx Ingress Controller for Kubernetes
   4. `helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace`
5. Create following namespaces with kubectl:
   6. `kubectl create namespace jitsi`
   7. `kubectl create namespace backup`
   8. `kubectl create namespace calcom`
9. Execute the script: for non helm managed resources
   10. `./customization/setup_customization_configmaps.sh <namespace> <release_name>`
11. Install the helm chart
    12. `helm install <release_name> k8s -f values.yaml -f values-secrets.yaml`

### Upgrading an existing helm release
1. Make sure you have the latest changes of git submodule `k8s`
   2. `cd k8s`
   3. `git fetch`
   4. `git pull`
5. Execute helm upgrade
   6. `helm upgrade <release_name> k8s -f values.yaml -f values-secrets.yaml`