# datalab-purl

This repository contains a simple resolver for links to entries in different
[*datalab*](https://github.com/datalab-org/datalab) instances that are part of the 
[*datalab* federation](https://github.com/datalab-org/datalab-federation).

The latest *datalab* federation list is pushed to ghcr.io and this repository
builds the ghcr.io/datalab-org/datalab-purl image with nginx configs containing
the appropriate redirects.
This container runs at https://purl.datalab-org.io and resolves prefixed refcode links to the
correct instance, e.g., https://purl.datalab-org.io/demo:1234 resolves to item
`1234` on the *datalab* demo instance at https://demo-datalab-org.io/1234.
