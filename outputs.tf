output "name" {
  description = "Name of the cluster"
  value       = var.name
  depends_on  = [google_container_node_pool.node_pool]
}