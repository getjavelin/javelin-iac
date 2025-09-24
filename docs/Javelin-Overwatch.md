# Javelin Overwatch

`Javelin Overwatch` is a powerful command-line tool that leverages eBPF (Extended Berkeley Packet Filter) technology to monitor Model Context Protocol (MCP) communication at the kernel level. It provides real-time visibility into JSON-RPC 2.0 messages exchanged between MCP clients and servers by hooking into low-level system calls.

The Model Context Protocol supports three transport protocols for communication:

* Stdio: Communication over standard input/output streams

* Streamable HTTP: Direct HTTP request/response communication with server-sent events

## K8s Deployment

* Download and update the `javelin-charts` into local

```bash
helm repo add javelin-charts "https://getjavelin.github.io/charts"
helm repo update javelin-charts && helm search repo javelin-charts
```

* Create a `value.yaml` file for the helm deployment

```code
image:
  repository: "ghcr.io/getjavelin/release-javelin-overwatch"
  pullPolicy: Always
  # Overrides the image tag with a specific version.
  tag: "latest"

imagePullSecrets:
  - name: javelin-registry-secret

secrets:
  enabled: true
  secretData:
    JAVELIN_URL: 'https://be-domain/v1'
    JAVELIN_API_KEY: '${JAVELIN_API_KEY}'
```

* Deploy the `javelin-overwatch` to the kubernetes cluster

```bash
kubectl create ns javelin-overwatch
helm upgrade --install javelin-overwatch javelin-charts/javelin-overwatch \
    --namespace javelin-overwatch \
    -f value.yaml --timeout=10m
```

## Bare Metal Deployment

* Download the `javelin-overwatch` artifact that compatible for system arch.

* Run the service

```bash
export JAVELIN_URL="https://be-domain/v1"
export JAVELIN_API_KEY=""
chmod +x ./javelin-overwatch
./javelin-overwatch --enable-javelin &
```