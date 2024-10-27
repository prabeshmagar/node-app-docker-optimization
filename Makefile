# Image name and version
img=myapp
VERSION=latest  # Set this to a fixed version or dynamically get it if needed

.PHONY: build push run-all ping-all clean-containers

# Build the Docker image
build:
	docker build --no-cache=true -t $(img):$(VERSION) .

# Clean up old containers
clean-containers:
	@echo "Stopping and removing old containers..."
	docker stop service1 service2 service3 service4 service5 || true
	docker rm servic1 service2 service3 service4 service5 || true

# Run all services in separate containers
run-all: clean-containers
	@echo "Running all services..."
	@echo "Starting service1 on port 3000"
	docker run -d --name service1 -e SERVER_PORT=3000 -e COMMAND=start-service1 -p 3000:3000 $(img):$(VERSION)
	@echo "Starting service2 on port 3001"
	docker run -d --name service2 -e SERVER_PORT=3001 -e COMMAND=start-service2 -p 3001:3001 $(img):$(VERSION)
	@echo "Starting service3  on port 3002"
	docker run -d --name service3 -e SERVER_PORT=3002 -e COMMAND=star-service3 -p 3002:3002 $(img):$(VERSION)
	@echo "Starting  service4 on port 3003"
	docker run -d --name service4 -e SERVER_PORT=3003 -e COMMAND=start-service4 -p 3003:3003 $(img):$(VERSION)
	@echo "Starting service5 on port 3005"
	docker run -d --name service5 -e SERVER_PORT=3005 -e COMMAND=start-service4 -p 3005:3005 $(img):$(VERSION)

# Push the Docker image to GitHub Container Registry
push:
	@echo "Pushing image $(img):$(VERSION) to GitHub Container Registry"
	docker tag $(img):$(VERSION) ghcr.io/<YOUR_GITHUB_USERNAME>/$(img):$(VERSION)
	docker push ghcr.io/<YOUR_GITHUB_USERNAME>/$(img):$(VERSION)

# Ping all services to check if they are running
ping-all:
	@echo "Pinging all services..."
	@curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 || echo "servic1 service not reachable"
	@curl -s -o /dev/null -w "%{http_code}" http://localhost:3001 || echo "service2 service not reachable"
	@curl -s -o /dev/null -w "%{http_code}" http://localhost:3002 || echo "service3 service not reachable"
	@curl -s -o /dev/null -w "%{http_code}" http://localhost:3003 || echo "service4 not reachable"
	@curl -s -o /dev/null -w "%{http_code}" http://localhost:3005 || echo "service5 service not reachable"
