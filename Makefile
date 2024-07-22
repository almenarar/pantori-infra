# Define variables
TF = terraform

.PHONY: all clean terraform-init terraform-apply zip-start zip-stop

all: zip-start zip-stop terraform-apply clean

zip-start: 
	cd ./serverless/code; zip -r start_ecs_task.zip start_ecs_task.py

zip-stop:
	cd ./serverless/code; zip -r stop_ecs_task.zip stop_ecs_task.py

terraform-init:
	$(TF) init

terraform-apply: terraform-init
	$(TF) apply -auto-approve

clean:
	rm -f ./serverless/code/start_ecs_task.zip ./serverless/code/stop_ecs_task.zip
