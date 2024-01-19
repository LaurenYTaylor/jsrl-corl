WANDB_API_KEY=b3fb3695850f3bdebfee750ead3ae8230c14ea07

RUN_FILE = "jsrl-CORL/algorithms/finetune/iql.py"
NUM_GPUS=--gpus all


run:
	sudo docker run \
	-e WANDB_API_KEY=$(WANDB_API_KEY) \
	-it \
	--gpus all \
	--rm \
	jsrl-corl python $(RUN_FILE)

build:
	sudo docker build \
	-f $(DF) \
	-t jsrl-corl \
	.

build_and_run:
	sudo docker build \
	-f $(DF) \
	-t jsrl-corl \
	.

	sudo docker run \
	-e WANDB_API_KEY=$(WANDB_API_KEY) \
	-it \
	$(NUM_GPUS) \
	--rm \
	jsrl-corl python $(RUN_FILE) --group IQL-D4RL-finetune

build_and_run_finetune_test:
	sudo docker build \
	-f $(DF) \
	-t jsrl-corl \
	.

	sudo docker run \
	-e WANDB_API_KEY=$(WANDB_API_KEY) \
	-it \
	--gpus all \
	--rm \
	jsrl-corl python $(RUN_FILE) --group IQL-D4RL-finetune_test --offline_iterations 5

	echo "running $(RUN_FILE)"
