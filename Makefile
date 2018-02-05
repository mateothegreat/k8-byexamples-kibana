#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#

# Environment Variables
NS              ?= es
SERVICE_NAME    ?= kubernetes-dashboard
SERVICE_PORT    ?= 80
export


all:        help
## Installs everything, first deleting
install:    deployment-install service-install
## Deletes and then installs everything
reinstall:  delete install
## Deletes everything
delete:     deployment-delete service-delete

## Retrieve Kubernetes Resources (kubectl get ..)
get:

	kubectl  --namespace $(NS) get deployment,svc,pod -lcomponent=kibana -o=wide

## Find first pod and follow log output
logs:

	@$(eval POD:=$(shell kubectl get pods --namespace $(NS) -lcomponent=kibana -o jsonpath='{.items[0].metadata.name}'))
	echo $(POD)

	kubectl --namespace $(NS) logs -f $(POD)

## Install deployment
deployment-install:

	@echo Installing:
	envsubst < deployment.yaml
	@echo --
	envsubst < deployment.yaml | kubectl --namespace $(NS) apply -f -

## Delete deployment
deployment-delete:

	envsubst < deployment.yaml | kubectl --ignore-not-found --namespace $(NS) delete -f -

## Install service
service-install:

	@echo Installing:
	envsubst < service.yaml
	@echo --
	envsubst < service.yaml | kubectl --namespace $(NS) apply -f -

## Delete service
service-delete:

	envsubst < service.yaml | kubectl --ignore-not-found --namespace $(NS) delete -f -


# Help Outputs
GREEN  		:= $(shell tput -Txterm setaf 2)
YELLOW 		:= $(shell tput -Txterm setaf 3)
WHITE  		:= $(shell tput -Txterm setaf 7)
RESET  		:= $(shell tput -Txterm sgr0)
help:

	@echo "Deploy & Manage Kibana in Kubernetes."
	@echo "\nUsage:\n\n  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}\n\nTargets:\n"
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-20s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
