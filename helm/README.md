# Install the application

```
helm install --atomic aviralworld . --set frontend.image.tag=latest,backend.image.tag=latest,s3.regionName=REGION_NAME,s3.endpoint=ENDPOINT,s3.baseUrl=BASE_URL,ingress.tls.secretRef=CERTIFICATE_SECRET_NAME
```

Use `avw-cert-staging` for testing and `avw-cert-production` for the TLS secret in production.

Check that the application is accessible using the domain name.
