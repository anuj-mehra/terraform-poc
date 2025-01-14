 gs:\\mybucket\myteam\PositionsData\20250101\ASD\
 gs:\\mybucket\myteam\PositionsData\20250102\ASD\
 gs:\\mybucket\myteam\PositionsData\20250103\ASD\
 gs:\\mybucket\myteam\PositionsData\20250104\ASD\

We want to create Big Query table at this level ===>  gs:\\mybucket\myteam\PositionsData\
We are using terraform to create BigQuery table


provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

resource "google_bigquery_dataset" "positions_dataset" {
  dataset_id = "positions_dataset"
  location   = "US"
}

resource "google_bigquery_table" "positions_table" {
  dataset_id = google_bigquery_dataset.positions_dataset.dataset_id
  table_id   = "positions_table"
  project    = "your-gcp-project-id"

  external_data_configuration {
    source_format = "AVRO"
    source_uris = [
      "gs://mybucket/myteam/PositionsData/*/ASD/*.avro"
    ]

    avro_options {
      use_avro_logical_types = true
    }

    autodetect = true # Enable schema autodetection, or define the schema explicitly
  }
}


