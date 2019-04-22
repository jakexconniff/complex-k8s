docker build -t projectinflection/multi-client:latest -t projectinflection/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t projectinflection/multi-server:latest -t projectinflection/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t projectinflection/multi-worker:latest -t projectinflection/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push projectinflection/multi-client:latest
docker push projectinflection/multi-client:$SHA
docker push projectinflection/multi-server:latest
docker push projectinflection/multi-server:$SHA
docker push projectinflection/multi-worker:latest
docker push projectinflection/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=projectinflection/multi-client:$SHA
kubectl set image deployments/server-deployment server=projectinflection/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=projectinflection/multi-worker:$SHA