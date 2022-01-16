#!/bin/sh

set -euo pipefail

echo "\n📦 Installing Knative CRDs..."

kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.1.0/serving-crds.yaml

echo "\n📦 Installing Knative Serving..."

kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.1.0/serving-core.yaml

echo "\n📦 Installing Kourier Ingress..."

kubectl apply -f https://github.com/knative/net-kourier/releases/download/knative-v1.1.0/kourier.yaml

kubectl patch configmap/config-network \
  --namespace knative-serving \
  --type merge \
  --patch '{"data":{"ingress-class":"kourier.ingress.networking.knative.dev"}}'

echo "\n📦 Configuring DNS..."

kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.1.0/serving-default-domain.yaml

echo "\n✅ Knative successfully installed!\n"
