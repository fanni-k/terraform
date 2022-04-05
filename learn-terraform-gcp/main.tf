provider "google" {
  credentials = file(var.credentials_file)
  project = var.project
  region  = "europe-central2"
  zone    = "europe-central2-a"
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "example_dataset"
}
resource "google_service_account" "bqowner" {
  account_id = "bqowner"
}

resource "google_bigquery_table" "default" {
  dataset_id = "example_dataset"
  table_id   = "bar"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "permalink",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "The Permalink"
  },
  {
    "name": "state",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "State where the head office is located"
  }
]
EOF

}

resource "google_bigquery_table" "test" {
  dataset_id = "example_dataset"
  table_id   = "foo"

}
