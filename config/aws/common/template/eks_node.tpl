MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: application/node.eks.aws

# Node config for al-2023
apiVersion: node.eks.aws/v1alpha1
kind: NodeConfig
spec:
  cluster:
    apiServerEndpoint: ${eks_cluster_endpoint}
    certificateAuthority: ${eks_cluster_ca_data}
    cidr: ${eks_cluster_service_cidr}
    name: ${k8s_cluster_name}
  kubelet:
    config:
      maxPods: 58
--//--