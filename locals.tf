module "locals_label" {
  source  = "applike/label/aws"
  version = "1.1.0"

  label_order = ["application", "family", "environment"]
  delimiter   = "."

  context = module.this.context
}

locals {
  docker_labels = merge(var.docker_labels, {
    "traefik.enable"                                                            = var.traefik_enabled
    "traefik.http.routers.metadata-${module.this.id}.entrypoints"               = "metadata"
    "traefik.http.routers.metadata-${module.this.id}.service"                   = "metadata-${module.this.id}"
    "traefik.http.services.metadata-${module.this.id}.loadbalancer.server.port" = var.port_metadata
    "traefik.http.routers.metadata-${module.this.id}.rule"                      = "Host(`${module.locals_label.id}.${var.traefik_domain}`)"
    "traefik.http.routers.gateway-${module.this.id}.entrypoints"                = "gateway"
    "traefik.http.routers.gateway-${module.this.id}.service"                    = "gateway-${module.this.id}"
    "traefik.http.services.gateway-${module.this.id}.loadbalancer.server.port"  = var.port_gateway
    "traefik.http.routers.gateway-${module.this.id}.rule"                       = "Host(`${module.locals_label.id}.${var.traefik_domain}`)"
    "traefik.http.routers.health-${module.this.id}.entrypoints"                 = "health"
    "traefik.http.routers.health-${module.this.id}.service"                     = "health-${module.this.id}"
    "traefik.http.services.health-${module.this.id}.loadbalancer.server.port"   = var.port_health
    "traefik.http.routers.health-${module.this.id}.rule"                        = "Host(`${module.locals_label.id}.${var.traefik_domain}`)"
  })
  scheduled_task = length(var.schedule_expression) != 0 ? true : false
}