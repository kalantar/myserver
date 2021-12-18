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
    - metric: built-in/p99.0
      upperLimit: 50

# task 3: if SLOs are satisfied, do something
- if: SLOs()
  run: |
    echo "Call promote"
    curl -X POST \
      -H "Accept: application/vnd.github.v3+json" \
      https://api.github.com/repos/kalantar/myserver/actions/workflows/promote.yaml/dispatches  \
      -d '{ "ref": "main", "inputs": { "image": "{{ .image }}" }}' \
      --user {{ .user }}:{{ .token }}


# task 4: if SLOs are not satisfied, do something else
- if: not SLOs()
  run: |
    echo "Call cleanup"
    curl -X POST \
      -H "Accept: application/vnd.github.v3+json" \
      https://api.github.com/repos/kalantar/myserver/actions/workflows/cleanup.yaml/dispatches  \
      -d '{ "ref": "main", "inputs": { "namespace": "{{ .namespace }}" }}' \
      --user {{ .user }}:{{ .token }}

