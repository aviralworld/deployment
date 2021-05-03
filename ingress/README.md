# Install Traefik

```
helm repo add traefik https://helm.traefik.io/traefik && helm repo update
kubectl create namespace traefik
helm install --atomic -n traefik traefik traefik/traefik -f traefik-values.yaml
```

Update the DNS A record to point to the new load balancer. The IP is listed under `EXTERNAL-IP` when you run this command:

```
kubectl -n traefik get svc
```

# Install cert-manager

```
helm repo add jetstack https://charts.jetstack.io && helm repo update
kubectl create namespace cert-manager
helm install --atomic cert-manager jetstack/cert-manager -n cert-manager --version v1.3.1 --set installCRDs=true
```

Once the DNS has been updated as above and is resolvable, create the `ClusterIssuer` and `Certificate`:

```
kubectl create namespace aviralworld
```

For testing:

```
kubectl apply -f tls-staging.yaml -n aviralworld
```

For production:

```
kubectl apply -f tls-production.yaml -n aviralworld
```

# Create the secrets

Replace the values below with the real values.

```
kubectl create secret -n aviralworld docker-registry avw-regcred --docker-server=registry.gitlab.com --docker-username=SOMEUSERNAME --docker-password=SOMEPASSWORD
kubectl create secret -n aviralworld generic avw-s3 --from-literal=ACCESS_KEY=SOMEACCESSKEY --from-literal=SECRET_ACCESS_KEY=SOMESECRETACCESSKEY
kubectl create secret -n aviralworld generic avw-postgres --from-literal=CONNECTION_STRING=SOMECONNECTIONSTRING
```
