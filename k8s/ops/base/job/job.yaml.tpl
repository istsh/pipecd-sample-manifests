apiVersion: batch/v1
kind: Job
metadata:
#  annotations:
#    argocd.argoproj.io/hook: PreSync
#    argocd.argoproj.io/hook-delete-policy: BeforeHookCreation
#    argocd.argoproj.io/sync-wave: "2"
  name: start-continuous-delivery
  labels:
    job-name: start-continuous-delivery
spec:
  ttlSecondsAfterFinished: 10
  backoffLimit: 0
  template:
    spec:
      containers:
        - name: start-continuous-delivery
          image: gcr.io/PROJECT_ID/app:COMMIT_SHA
          command: ["/pipecd-sample-cli"]
          args: ["slack-notification", "<Trigger>", "<Env>"]
      restartPolicy: Never

---
apiVersion: batch/v1
kind: Job
metadata:
#  annotations:
#    argocd.argoproj.io/hook: PreSync
#    argocd.argoproj.io/hook-delete-policy: BeforeHookCreation
#    argocd.argoproj.io/sync-wave: "99"
  name: finish-migration
  labels:
    job-name: finish-migration
spec:
  ttlSecondsAfterFinished: 10
  backoffLimit: 0
  template:
    spec:
      containers:
        - name: finish-migration
          image: gcr.io/PROJECT_ID/app:COMMIT_SHA
          command: ["/pipecd-sample-cli"]
          args: ["slack-notification", "<Trigger>", "<Env>"]
      restartPolicy: Never

---
apiVersion: batch/v1
kind: Job
metadata:
#  annotations:
#    argocd.argoproj.io/hook: PostSync
#    argocd.argoproj.io/hook-delete-policy: BeforeHookCreation
#    argocd.argoproj.io/sync-wave: "99"
  name: finish-continuous-delivery
  labels:
    job-name: finish-continuous-delivery
spec:
  ttlSecondsAfterFinished: 10
  backoffLimit: 0
  template:
    spec:
      containers:
        - name: finish-continuous-delivery
          image: gcr.io/PROJECT_ID/app:COMMIT_SHA
          command: ["/pipecd-sample-cli"]
          args: ["slack-notification", "<Trigger>", "<Env>"]
      restartPolicy: Never
