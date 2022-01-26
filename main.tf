terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}
provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "front_end_deployment" {
  metadata {
    name = "front-end-deployment"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "front-end"
      }
    }
    template {
      metadata {
          labels = {
            app = "front-end"
        }
      }
      spec {
        container {
          image = "efrei/front-end:1"
          name  = "front-end-container"
          image_pull_policy = "Always"
        }
      }
    }
  }
}

resource "kubernetes_service" "front_end_service" {
  metadata {
    name = "front-end-service"
  }
  
  spec {
    selector = {
      app = "front-end"
    }
    port {
      name = "http"
      port = 8181
      target_port = 8080
    }
    type = "NodePort"
  }
}

resource "kubernetes_deployment" "back_end_deployment" {
  metadata {
    name = "back-end-deployment"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "back-end"
      }
    }
    template {
      metadata {
          labels = {
            app = "back-end"
        }
      }
      spec {
        container {
          image = "efrei/back-end:1"
          name  = "back-end-container"
          image_pull_policy = "Always"
        }
      }
    }
  }
}


resource "kubernetes_service" "back_end_service" {
  metadata {
    name = "back-end-service"
  }
  
  spec {
    selector = {
      app = "back-end"
    }
    port {
      name = "http"
      port = 80
      target_port = 8080
    }
    type = "ClusterIP"
  }
}
