#script to install loki
# add loki chart repo to helm
helm repo add grafana https://grafana.github.io/helm-charts
#update the chart repo 
helm repo update
#deploy loki in default namespace 
#helm upgrade --install loki grafana/loki-stack

#to deploy loki in custom ns
#helm upgrade --install loki --namespace=loki grafana/loki

#deploy loki stack
helm upgrade --install loki grafana/loki-stack  --set grafana.enabled=true,prometheus.enabled=true,prometheus.alertmanager.persistentVolume.enabled=false,prometheus.server.persistentVolume.enabled=false

#edit grafana service from clusterIP to nodePort
kubectl patch svc loki-grafana -p '[{"op":"replace","path":"/spec/type","value":"NodePort"}]'
kubectl patch svc loki-grafana -p '[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30300}]'


#get grafana pwd ande decode it
kubectl get secret --namespace default loki-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
#access grafana UI
#minikubeIP:30300

