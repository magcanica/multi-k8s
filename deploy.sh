docker build -t tatocar/multi-client:latest -t tatocar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tatocar/multi-server:latest -t tatocar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tatocar/multi-worker:latest -t tatocar/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tatocar/multi-client:latest
docker push tatocar/multi-server:latest
docker push tatocar/multi-worker:latest
docker push tatocar/multi-client:$SHA
docker push tatocar/multi-server:$SHA
docker push tatocar/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tatocar/multi-server:$SHA
kubectl set image deployments/client-deployment server=tatocar/multi-client:$SHA
kubectl set image deployments/worker-deployment server=tatocar/multi-worker:$SHA
