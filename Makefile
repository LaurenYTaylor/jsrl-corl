WANDB_API_KEY=b3fb3695850f3bdebfee750ead3ae8230c14ea07
DF=Dockerfile
RUN_FILE="jsrl-CORL/algorithms/finetune/ray_trainer.py"
CPUS=5

run:
	sudo docker run \
	-e WANDB_API_KEY=$(WANDB_API_KEY) \
	-it \
	--rm \
	jsrl-corl python $(RUN_FILE)

build:
	sudo docker build \
	-f $(DF) \
	-t jsrl-corl \
	.

build_and_run_combination:
	yes | docker container prune

	docker build \
	-f $(DF) \
	-t jsrl-corl \
	.

	docker run \
	-e WANDB_API_KEY=$(WANDB_API_KEY) \
	-it \
	--shm-size=10.24gb \
	-v ./algorithms/finetune/checkpoints:/workspace/checkpoints \
	-v ./algorithms/finetune/wandb:/workspace/wandb \
	-v ".:/workspace/jsrl-CORL" \
	jsrl-corl python $(RUN_FILE) --env CombinationLock-v0 --learner_frac -1 --online_buffer_size 64 --guide_heuristic_fn combination_lock --offline_iterations 0 --env_config '{"horizon": 10}' --tolerance 0.75 --n_episodes 250 --eval_freq 1 --batch_size 10 --beta 10 --iql_tau 0.9 --horizon_fn time_step --name IQL-test --device cpu --online_iterations 300 --seed 0 --iql_deterministic True --enable_rollback False --sample_rate 0.9 ;


	docker run \
	-e WANDB_API_KEY=$(WANDB_API_KEY) \
	-it \
	--shm-size=10.24gb \
	-v ./algorithms/finetune/checkpoints:/workspace/checkpoints \
	-v ./algorithms/finetune/wandb:/workspace/wandb \
	-v ".:/workspace/jsrl-CORL" \
	jsrl-corl python $(RUN_FILE) --env CombinationLock-v0 --learner_frac -1 --online_buffer_size 64 --guide_heuristic_fn combination_lock --offline_iterations 0 --env_config '{"horizon": 10}' --tolerance 0.75 --n_episodes 250 --eval_freq 1 --batch_size 10 --beta 10 --iql_tau 0.9 --horizon_fn time_step --name IQL-test --device cpu --online_iterations 300 --seed 0 --iql_deterministic True --enable_rollback True --sample_rate 0.9 ;




build_and_run_lunar:
	yes | docker container prune

	docker build \
	-f $(DF) \
	-t jsrl-corl \
	.

	sudo docker run \
	-e WANDB_API_KEY=$(WANDB_API_KEY) \
	-it \
	--shm-size=10.24gb \
	-v ./algorithms/finetune/checkpoints:/workspace/checkpoints \
	-v ./algorithms/finetune/wandb:/workspace/wandb \
	-v ".:/workspace/jsrl-CORL" \
	jsrl-corl python $(RUN_FILE) --env LunarLander-v2 --variance_learn_frac 0.0 --guide_heuristic_fn lunar_lander --offline_iterations 0 --env_config '{"continuous": True}' --eval_freq 500 --beta 10 --iql_tau 0.9 --horizon_fn variance --name IQL-test --device cpu --online_iterations 1 ;

build_and_run_antmaze:
	yes | docker container prune

	docker build \
	-f $(DF) \
	-t jsrl-corl \
	.

	docker run \
	-e WANDB_API_KEY=$(WANDB_API_KEY) \
	-it \
	--shm-size=10.24gb \
	-v ./algorithms/finetune/checkpoints:/workspace/checkpoints \
	-v ./algorithms/finetune/wandb:/workspace/wandb \
	-v ./algorithms/finetune:/workspace/jsrl-CORL/algorithms/finetune \
	-v ".:/workspace/jsrl-CORL" \
	jsrl-corl python $(RUN_FILE) --horizon_fn time_step --checkpoints_path checkpoints --env antmaze-umaze-v2 --normalize True --correct_learner_action 0.9 --normalize_reward True --iql_deterministic False --beta 10 --learner_frac -1 --iql_tau 0.9 --n_episodes 1000 --eval_freq 200 --offline_iterations 0 --online_iterations 1 --pretrained_policy_path jsrl-CORL/algorithms/finetune/checkpoints/IQL-antmaze-umaze-v2-offline/checkpoint_999999.pt --device cpu ;

	docker run \
	-e WANDB_API_KEY=$(WANDB_API_KEY) \
	-it \
	--shm-size=10.24gb \
	-v ./algorithms/finetune/checkpoints:/workspace/checkpoints \
	-v ./algorithms/finetune/wandb:/workspace/wandb \
	-v ./algorithms/finetune:/workspace/jsrl-CORL/algorithms/finetune \
	-v ".:/workspace/jsrl-CORL" \
	jsrl-corl python $(RUN_FILE) --horizon_fn time_step --checkpoints_path checkpoints --env antmaze-umaze-diverse-v2 --normalize True --correct_learner_action 0.9 --normalize_reward True --iql_deterministic False --beta 10 --learner_frac -1 --iql_tau 0.9 --n_episodes 1000 --eval_freq 200 --offline_iterations 0 --online_iterations 1 --pretrained_policy_path jsrl-CORL/algorithms/finetune/checkpoints/IQL-antmaze-umaze-diverse-v2-offline/checkpoint_999999.pt --device cpu ;

	docker run \
	-e WANDB_API_KEY=$(WANDB_API_KEY) \
	-it \
	--shm-size=10.24gb \
	-v ./algorithms/finetune/checkpoints:/workspace/checkpoints \
	-v ./algorithms/finetune/wandb:/workspace/wandb \
	-v ./algorithms/finetune:/workspace/jsrl-CORL/algorithms/finetune \
	-v ".:/workspace/jsrl-CORL" \
	jsrl-corl python $(RUN_FILE) --horizon_fn time_step --checkpoints_path checkpoints --env antmaze-medium-play-v2 --normalize True --correct_learner_action 0.9 --normalize_reward True --iql_deterministic False --beta 10 --learner_frac -1 --iql_tau 0.9 --n_episodes 1000 --eval_freq 200 --offline_iterations 0 --online_iterations 1 --pretrained_policy_path jsrl-CORL/algorithms/finetune/checkpoints/IQL-antmaze-medium-play-v2-offline/checkpoint_999999.pt --device cpu ;

	docker run \
	-e WANDB_API_KEY=$(WANDB_API_KEY) \
	-it \
	--shm-size=10.24gb \
	-v ./algorithms/finetune/checkpoints:/workspace/checkpoints \
	-v ./algorithms/finetune/wandb:/workspace/wandb \
	-v ./algorithms/finetune:/workspace/jsrl-CORL/algorithms/finetune \
	-v ".:/workspace/jsrl-CORL" \
	jsrl-corl python $(RUN_FILE) --horizon_fn time_step --checkpoints_path checkpoints --env antmaze-medium-diverse-v2 --normalize True --correct_learner_action 0.9 --normalize_reward True --iql_deterministic False --beta 10 --learner_frac -1 --iql_tau 0.9 --n_episodes 1000 --eval_freq 200 --offline_iterations 0 --online_iterations 1 --pretrained_policy_path jsrl-CORL/algorithms/finetune/checkpoints/IQL-antmaze-medium-diverse-v2-offline/checkpoint_999999.pt --device cpu ;

	docker run \
	-e WANDB_API_KEY=$(WANDB_API_KEY) \
	-it \
	--shm-size=10.24gb \
	-v ./algorithms/finetune/checkpoints:/workspace/checkpoints \
	-v ./algorithms/finetune/wandb:/workspace/wandb \
	-v ./algorithms/finetune:/workspace/jsrl-CORL/algorithms/finetune \
	-v ".:/workspace/jsrl-CORL" \
	jsrl-corl python $(RUN_FILE) --horizon_fn time_step --checkpoints_path checkpoints --env antmaze-large-play-v2 --normalize True --correct_learner_action 0.9 --normalize_reward True --iql_deterministic False --beta 10 --learner_frac -1 --iql_tau 0.9 --n_episodes 1000 --eval_freq 200 --offline_iterations 0 --online_iterations 1 --pretrained_policy_path jsrl-CORL/algorithms/finetune/checkpoints/IQL-antmaze-large-play-v2-offline/checkpoint_999999.pt --device cpu ;

	docker run \
	-e WANDB_API_KEY=$(WANDB_API_KEY) \
	-it \
	--shm-size=10.24gb \
	-v ./algorithms/finetune/checkpoints:/workspace/checkpoints \
	-v ./algorithms/finetune/wandb:/workspace/wandb \
	-v ./algorithms/finetune:/workspace/jsrl-CORL/algorithms/finetune \
	-v ".:/workspace/jsrl-CORL" \
	jsrl-corl python $(RUN_FILE) --horizon_fn time_step --checkpoints_path checkpoints --env antmaze-large-diverse-v2 --normalize True --correct_learner_action 0.9 --normalize_reward True --iql_deterministic False --beta 10 --learner_frac -1 --iql_tau 0.9 --n_episodes 1000 --eval_freq 200 --offline_iterations 0 --online_iterations 1 --pretrained_policy_path jsrl-CORL/algorithms/finetune/checkpoints/IQL-antmaze-large-diverse-v2-offline/checkpoint_999999.pt --device cpu ;

run_variance_learner:
	sudo docker run \
	-it \
	-v ./algorithms/finetune/checkpoints:/workspace/checkpoints \
	-v ./algorithms/finetune/var_functions:/workspace/jsrl-CORL/algorithms/finetune/var_functions \
	-v ./algorithms/finetune/wandb:/workspace/wandb \
	-v ".:/workspace/jsrl-CORL" \
	jsrl-corl python jsrl-CORL/algorithms/finetune/variance_learner.py
