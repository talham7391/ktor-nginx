
DOCKER_ACC=
APP_NAME=

IMAGE=${DOCKER_ACC}/${APP_NAME}:latest
STACK_NAME=${APP_NAME}-stack

.PHONY: deploy
deploy:
	./gradlew shadowJar

	docker build . -t ${IMAGE}
	docker push ${IMAGE}

	aws cloudformation deploy \
	--template-file templates/infrastructure.yaml \
	--stack-name ${STACK_NAME} \
	--capabilities CAPABILITY_IAM \
	--parameter-overrides \
		ExampleImage="${IMAGE}"

.PHONY: teardown
teardown:
	aws cloudformation delete-stack \
	--stack-name ${STACK_NAME}

