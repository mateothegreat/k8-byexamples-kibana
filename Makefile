#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
include .make/Makefile.inc

# Environment Variables
NS                  ?= es
SERVICE_NAME        ?= kibana
SERVICE_PORT        ?= 80
SERVER_BASE_PATH    ?= /
CLUSTER_NAME        ?= myesdb
export

## Test installation
test:

	@echo "$(GREEN)"

	nslookup kibana

	@echo "$(RESET)"