# Deploy a generic deployment on a GKE cluster

The purpose of this chart is to deploy a generic deployment to a GKE cluster.  The main purpose is to use in
the bake stage within Spinnaker pipeline.

Customization allows for the application to be exposed on an available ingress controller.  

There are currently two available ingress controllers:

Nginx to be used for web interfaces

```
ingress:
  class: nginx-ingress-protected
```

Kong for apis
```
ingress:
  class: kong
```

## Configuration
Parameter|Description|Default
---|---|---
applicationName|Name of Application|bto-react-example
environment|Deployment environment|dv
replicaCount|Number of deployment replicas|1
namespace|Deployment namespace|lab
containerPort|Overide default contiainer port|8080
telus.cmdbId|Application CMDBID|"12345"
telus.costCentre|Application cost centre(for reporting only)|"12345"
telus.organization|Application Organization|"CIO"
telus.mailingList|Application Mailing list|"donotreply@telus.com"
extraEnvs|An array of environment variable to add to deployment container|[]
configmaps|An array of configmap files/data to be created|[]
initContainers|An array of containers to be created as initContainers|[]
volumeMounts||
livenessProbe|Yaml Copied into manifest as-is|httpGet on :8080/
readinessProbe|Yaml Copied into manifest as-is|httpGet on :8080/
volumes||
secretMounts||
image.repository||gcr.io/customer-k8s-dv-ebaafbd3/bto-react-example
image.tag||latest
image.pullPolicy||IfNotPresent
ingress.enabled||true
ingress.path:||bto-react-example/react/?(.*)
ingress.hosts||""
ingress.tls||[]
ingress.class||nginx-ingress-protected
ingress.kongPlugins||key-auth
ingress.annotations|A yaml map configuration that will be copied over verbatim|
proxyType| 'kong' for api workload and 'nginx' for ui workloads | nginx
disableSidecar| set to 'true' to disable istio sidecar injection configured at namespace |
rbac| Configuration for creating a service account to run the deployment as part of this Helm chart with create: true.  If you have an existing account you want to run the deployment with set it the serviceAccount option from above otherwise everything would default to 'default' account.  **See additional note below | see [values.yaml][] for an example
serviceAccount | The serviceAccount you wish to be running the deployment under.  Defaults to 'default' user if this is not provided | 




# Implementing CloudSQL as sidecar for your deployment <h2>

Simply add in the sidecar section the additional containers you would need as part of your deployment.  A few projects have had the requirement of cloudsql instance connectivity where we've advised and put in the use of cloudsql proxy sidecar implementation.
See sample value file for more detailed info on the required implementing values.


# Network Policy Configuration

The standard set by TELUS Security required us to introduce snetwork defined policies defined at the Kubernetes level to restrict communication.  To keep things simple for now the only thing we ask team to include in their custom helm values file is the appropriate proxy option as described in the table above.


# Enable Workload to Prometheus 

If your application has support for prometheus and would like metrics to be scraped and sent to Stackdriver for monitoring.  Enable the prometheus option and supply the required scrape path and port

```javascript
prometheus:
  enable: true
  scrapePath: "/prometheus"
  scrapePort: 9000
```

# Service Acccount for Deployment

This chart supports the creation of a service account to run your deployment along with annotating it to enable workload identity.  In order for workload identity to work it is assumed that the Google Service Account along with workload identity iam binding is already done at the project infrastructure's Terraform configuration file.




# Chart Version cio-gke-deployment-chart.0.4.6

### What's New

- Nginx ingress canary support

- RBAC Service Account Creation and to run workload under 