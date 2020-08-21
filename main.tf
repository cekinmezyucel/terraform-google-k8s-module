resource "google_container_cluster" "cluster" {
  name                     = var.name
  project                  = var.project_id
  location                 = var.location
  network                  = var.network_self_link
  subnetwork               = var.subnetwork_self_link
  remove_default_node_pool = true
  enable_kubernetes_alpha  = false
  initial_node_count       = var.initial_node_count
}

resource "google_container_node_pool" "node_pool" {
  for_each = var.node_pools

  name               = each.key
  project            = var.project_id
  cluster            = google_container_cluster.cluster.name
  location           = var.location
  initial_node_count = each.value["min_node_count"]

  autoscaling {
    min_node_count = each.value["min_node_count"]
    max_node_count = each.value["max_node_count"]
  }

  node_config {
    preemptible  = each.value["preemptible"]
    machine_type = each.value["machine_type"]
    image_type   = each.value["image_type"]
  }
}
