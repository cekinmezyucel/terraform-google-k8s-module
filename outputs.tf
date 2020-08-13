output "gitops_namespace" {
  description = "GitOps namespace name."
  value       = var.gitops_enabled ? kubernetes_namespace.gitops[0].metadata.0.name : null
}

output "name" {
  description = "Name of the cluster"
  value       = var.name
  depends_on  = [google_container_node_pool.node_pool]
}