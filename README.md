<!--
#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
#-->

[![Clickity click](https://img.shields.io/badge/k8s%20by%20example%20yo-limit%20time-ff69b4.svg?style=flat-square)](https://k8.matthewdavis.io)
[![Twitter Follow](https://img.shields.io/twitter/follow/yomateod.svg?label=Follow&style=flat-square)](https://twitter.com/yomateod) [![Skype Contact](https://img.shields.io/badge/skype%20id-appsoa-blue.svg?style=flat-square)](skype:appsoa?chat)

# Install Kibana 6.4.2!

> k8 by example -- straight to the point, simple execution.

Simply `make install` and open up http://kibana.infra-monitoring.svc.cluster.local/
Still proxying access to your cluster?! https://github.com/mateothegreat/k8-byexamples-openvpn!

## Usage

```sh
$ make help
Deploy & Manage Kibana in Kubernetes.

Usage:

  make <target>

Targets:

  install              Installs everything, first deleting
  delete               Deletes everything

  get                  Retrieve Kubernetes Resources (kubectl get ..)
  logs                 Find first pod and follow log output

  deployment-install   Install deployment
  deployment-delete    Delete deployment

  service-install      Install service
  service-delete       Delete service

yomateod@proliant:/mnt/c/workspace/k8/cluster-2/modules/k8-byexamples-kibana$ make install

[ INSTALLING MANIFESTS/DEPLOYMENT.YAML ]: deployment "kibana" configured
[ INSTALLING MANIFESTS/SERVICE.YAML ]: service "kibana" unchanged

yomateod@proliant:/mnt/c/workspace/k8/cluster-2/modules/k8-byexamples-kibana$ make delete

[ DELETING MANIFESTS/DEPLOYMENT.YAML ]: deployment "kibana" deleted
[ DELETING MANIFESTS/SERVICE.YAML ]: service "kibana" deleted

```

## Get resources

```sh
yomateod@proliant:/k8-byexamples-kibana$ make get

kubectl  --namespace es get deployment,svc,pod -lcomponent=kibana -o=wide

NAME            DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       CONTAINERS   IMAGES                                      SELECTOR
deploy/kibana   1         1         1            1           56m       kibana       docker.elastic.co/kibana/kibana-oss:6.1.3   component=kibana

NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE       SELECTOR
svc/kibana   ClusterIP   10.15.241.111   <none>        5601/TCP   56m       component=kibana

NAME                         READY     STATUS    RESTARTS   AGE       IP           NODE
po/kibana-7696fbddfc-m2762   1/1       Running   0          56m       10.12.1.29   gke-cluster-2-default-pool-25ca6a7e-w6pv
```

## See also

* https://github.com/mateothegreat/k8-byexamples-elasticsearch-cluster
