# task 1: generate HTTP requests for the model
# collect Iter8's built-in latency and error related metrics
- task: gen-load-and-collect-metrics
  with:
    errorRanges:
    - lower: 400
    versionInfo:
    - url: {{ .url }}

# task 2: validate service level objectives 
# using the metrics collected in the above task
- task: assess-app-versions
  with:
    SLOs:
      # error rate must be 0
    - metric: built-in/error-rate
      upperLimit: 0
      # 95th percentile latency must be under 100 msec
    - metric: built-in/p95.0
      upperLimit: 150
