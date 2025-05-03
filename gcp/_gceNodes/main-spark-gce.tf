resource "google_compute_instance" "default" {
  name         = "spark-instance"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update -y

    # Install Java
    apt-get install -y openjdk-11-jdk

    # Install Scala
    apt-get install -y scala

    # Install Spark
    cd /opt
    curl -O https://downloads.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz
    tar xvf spark-3.5.1-bin-hadoop3.tgz
    mv spark-3.5.1-bin-hadoop3 spark

    # Set environment variables
    echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> /etc/profile.d/spark.sh
    echo 'export SCALA_HOME=/usr/share/scala' >> /etc/profile.d/spark.sh
    echo 'export SPARK_HOME=/opt/spark' >> /etc/profile.d/spark.sh
    echo 'export PATH=$PATH:$JAVA_HOME/bin:$SCALA_HOME/bin:$SPARK_HOME/bin' >> /etc/profile.d/spark.sh
    chmod +x /etc/profile.d/spark.sh
    source /etc/profile.d/spark.sh
  EOT

  tags = ["spark", "dev"]
}
