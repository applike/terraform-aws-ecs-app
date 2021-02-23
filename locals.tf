module "locals_label" {
  source      = "applike/label/aws"
  version     = "1.0.2"
  context     = module.label.context
  label_order = ["application", "family", "environment"]
  delimiter   = "."
}

locals {
  docker_labels = merge(var.docker_labels, {
    "traefik.enable"                                                             = var.traefik_enabled
    "traefik.http.routers.metadata-${module.label.id}.entrypoints"               = "metadata"
    "traefik.http.routers.metadata-${module.label.id}.service"                   = "metadata-${module.label.id}"
    "traefik.http.services.metadata-${module.label.id}.loadbalancer.server.port" = var.port_metadata
    "traefik.http.routers.metadata-${module.label.id}.rule"                      = "Host(`${module.locals_label.id}.${var.traefik_domain}`)"
    "traefik.http.routers.gateway-${module.label.id}.entrypoints"                = "gateway"
    "traefik.http.routers.gateway-${module.label.id}.service"                    = "gateway-${module.label.id}"
    "traefik.http.services.gateway-${module.label.id}.loadbalancer.server.port"  = var.port_gateway
    "traefik.http.routers.gateway-${module.label.id}.rule"                       = "Host(`${module.locals_label.id}.${var.traefik_domain}`)"
    "traefik.http.routers.health-${module.label.id}.entrypoints"                 = "health"
    "traefik.http.routers.health-${module.label.id}.service"                     = "health-${module.label.id}"
    "traefik.http.services.health-${module.label.id}.loadbalancer.server.port"   = var.port_health
    "traefik.http.routers.health-${module.label.id}.rule"                        = "Host(`${module.locals_label.id}.${var.traefik_domain}`)"
  })
}