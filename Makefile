DOCKER_ACC=
APP_NAME=

IMAGE=${DOCKER_ACC}/${APP_NAME}:latest
NGINX_IMAGE=${DOCKER_ACC}/${APP_NAME}-nginx:latest
STACK_NAME=${APP_NAME}-stack


.PHONY: buildimages
buildimages:

	./gradlew shadowJar
	docker build . -t ${IMAGE}
	cd nginx; docker build . -t ${NGINX_IMAGE}


.PHONY: pushimages
pushimages:

	docker push ${IMAGE}
	docker push ${NGINX_IMAGE}


.PHONY: start
start: buildimages

	docker run --rm -d --name ${APP_NAME} ${IMAGE}
	docker run --rm -p 80:80 --link=${APP_NAME} ${NGINX_IMAGE}


.PHONY: stop
stop:
	docker stop ${APP_NAME}


.PHONY: deploy
deploy: buildimages pushimages

	aws cloudformation deploy \
	--template-file templates/infrastructure.yaml \
	--stack-name ${STACK_NAME} \
	--capabilities CAPABILITY_IAM \
	--parameter-overrides \
		ClusterName="${APP_NAME}-cluster" \
		AppImage="${IMAGE}" \
		NginxImage="${NGINX_IMAGE}"


.PHONY: teardown
teardown:

	aws cloudformation delete-stack \
	--stack-name ${STACK_NAME}

