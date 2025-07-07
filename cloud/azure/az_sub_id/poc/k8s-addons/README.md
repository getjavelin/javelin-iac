# K8s Addons Terraform Scripts

### Debug cert-manager

```code
export K8S_NAMESPACE=""
kubectl -n ${K8S_NAMESPACE} get certificate
kubectl -n ${K8S_NAMESPACE} get certificaterequest
kubectl -n ${K8S_NAMESPACE} describe certificaterequest X
kubectl -n ${K8S_NAMESPACE} get order
kubectl -n ${K8S_NAMESPACE} describe order X
kubectl -n ${K8S_NAMESPACE} get challenge
kubectl -n ${K8S_NAMESPACE} describe challenge X
```