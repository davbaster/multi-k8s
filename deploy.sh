docker build -t cajina/multi-client:latest -t cajina/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cajina/multi-server:latest -t cajina/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cajina/multi-worker:latest -t cajina/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cajina/multi-client:latest
docker push cajina/multi-server:latest
docker push cajina/multi-worker:latest

docker push cajina/multi-client:$SHA
docker push cajina/multi-server:$SHA
docker push cajina/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cajina/multi-server:$SHA
kubectl set image deployments/client-deployment client=cajina/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=cajina/multi-worker:$SHA

