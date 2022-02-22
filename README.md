# My Helm

## Install Helm for Windows

Very easy and simple

### Download Helm for Windows

https://github.com/helm/helm/releases

https://get.helm.sh/helm-v3.8.0-windows-amd64.zip

### Install Helm for Windows

https://phoenixnap.com/kb/install-helm

Extract to C:\Apps\Helm

Run C:\Apps\Helm\Helm

## Manually deploy to GKE with Helm

gsutil cp gs://.../cio-gke-deployment-chart.0.5.0.tgz .

tar xvfz cio-gke-deployment-chart.0.5.0.tgz

C:\Apps\Helm\Helm template cio-gke-deployment/ -f mock-api/helm/MerlinCloudBssBridge-mock-api-dv01.yaml --set image.repository=gcr.io/cio-gke-devops-e4993356/cust-om-order-mgmt/merlin-cloud-bss-bridge-mock-api:mcb-mock-api-dv01.v.0.0.5 | kubectl apply -n cust-om-order-mgmt -f -

Prerequisite

- GitHub repo up-to-date
- GitHub new tag (dv01.v.0.0.5)
- Cloud Build (gcr.io/cio-gke-devops-e4993356/cust-om-order-mgmt/merlin-cloud-bss-bridge-mock-api:mcb-mock-api-dv01.v.0.0.5)
