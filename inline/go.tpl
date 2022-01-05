apiVersion: apps/v1
kind: Deployment
metadata:
  name: myserver
  labels:
    app: myserver
spec:
  replicas: 1
  selector:
    matchLabels:
      app: myserver
  template:
    metadata:
      labels:
        app: myserver
    spec:
      containers:
        - name: myserver
          image: {{ .image }}
          imagePullPolicy: Always
          resources:
            {}
---
apiVersion: v1
kind: Service
metadata:
  name: myservice
  labels:
    app: myservice
spec:
  selector:
    app: myserver
  type: NodePort
  ports:
    - port: 8080
      targetPort: 8080
      protocol: TCP
      name: http
# ---
# apiVersion: v1
# kind: Service
# metadata:
#   name: myservice
#   labels:
#     app: myservice
# spec:
#   selector:
#     app: myserver
#   type: ClusterIP
#   ports:
#     - port: 8080
#       targetPort: 8080
#       protocol: TCP
#       name: http
