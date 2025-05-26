module "identity" {
  source  = "./Modules/Identity"
  project = var.project
}

module "network" {
  source          = "./Modules/Network"
  project         = var.project
  region          = var.region
  gke-master-cidr = module.cluster.gke-master-cidr
}

module "compute" {
  source                     = "./Modules/Compute"
  project                    = var.project
  region                     = var.region
  vpc-name                   = module.network.main-vpc-name
  subnet-name                = module.network.management-subnet
  management-service-account = module.identity.management-service-account
}

module "cluster" {
  source                  = "./Modules/Cluster"
  region                  = var.region
  project                 = var.project
  main-vpc-name           = module.network.main-vpc-name
  cluster-service-account = module.identity.cluster-service-account
  restricted-subnet       = module.network.restricted-subnet
  management-instance-ip  = module.compute.management-instance-ip
  my-public-ip            = var.my-public-ip
}
