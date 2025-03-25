#Create a GCP Service Account

## Run the following commands in your GCP terminal to create a service account and download the key file:

## Set project ID
PROJECT_ID="spatial-edition-256713"

## Create a service account
gcloud iam service-accounts create qwiklabs-gcp-03-16f014a52625@qwiklabs-gcp-03-16f014a52625.iam.gserviceaccount.com  --description="Terraform Service Account" --display-name="Terraform SA"

qwiklabs-gcp-03-16f014a52625@qwiklabs-gcp-03-16f014a52625.iam.gserviceaccount.com

## Assign IAM roles (adjust based on need)
gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:qwiklabs-gcp-03-16f014a52625@qwiklabs-gcp-03-16f014a52625.iam.gserviceaccount.com" --role="roles/editor"

## Generate a JSON key file
gcloud iam service-accounts keys create terraform-sa-key.json \
--iam-account="terraform-sa@$PROJECT_ID.iam.gserviceaccount.com"

