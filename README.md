# Shop API

Example app created for the following blog post
https://kyan.com/news/accessing-a-gke-internal-service-from-the-api-gateway

if you wish to test the application's deployment on the **GKE (Google Kubernetes Engine)**. The ``K8-deployment-config`` directory contains the configuration information.

### GKE Deployment Steps:
If you already have a GCP project setup and ``gcloud`` cli is configured, use the following steps to deploy the application
- Create a GKE Cluster with your desired config.
`` gcloud container --project "YOUR_PROJECT_ID" clusters create "example-cluster" --zone "europe-west2" --machine-type "e2-micro" --disk-type "pd-standard" --disk-size "99" --num-nodes "2"``
- Build and deploy your application image to the Google Container Registry.
``gcloud builds submit --tag=gcr.io/YOUR_PROJECT_ID/APP_IMAGE .``
- Create a Cloud SQL Postgres database.
- Generate service account credentials.json.
- Connect to the DB instance using Cloud SQL proxy(Proxy container details are given in the deployment.yml file).
- Apply your application deployment file using kubectl.
`` kubectl apply -f deployment.yml``




