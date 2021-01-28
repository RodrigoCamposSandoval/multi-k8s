docker build -t rcamsan/multi-client:latest -t rcamsan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rcamsan/multi-server:latest -t rcamsan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rcamsan/multi-worker:latest -t rcamsan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rcamsan/multi-client:latest
docker push rcamsan/multi-server:latest
docker push rcamsan/multi-worker:latest

docker push rcamsan/multi-client:$SHA
docker push rcamsan/multi-server:$SHA
docker push rcamsan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rcamsan/multi-server:$SHA
kubectl set image deployments/client-deployment client=rcamsan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rcamsan/multi-worker:$SHA
