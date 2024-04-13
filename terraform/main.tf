# =================== #
# Deploying VMware VM #
# =================== #

# Connect to VMware vSphere vCenter
provider "vsphere" {
  vim_keep_alive = 30
  user           = var.vsphere-user
  password       = var.vsphere-password
  vsphere_server = var.vsphere-vcenter

  # If you have a self-signed cert
  allow_unverified_ssl = var.vsphere-unverified-ssl
}

# Define VMware vSphere 
data "vsphere_datacenter" "dc" {
  name = var.vsphere-datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vm-datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

#data "vsphere_host" "host" {
#  name          = var.vsphere-host
#  datacenter_id = "${data.vsphere_datacenter.dc.id}"
#}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere-cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vm-network
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Create a folder for the VMs
resource "vsphere_folder" "folder" {
  path          = "Terraform-VMs"
  type          = "vm"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = var.vm-template-name
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Create VMs
resource "vsphere_virtual_machine" "vm" {
  count = var.vm-count

  name             = "${var.vm-name}-${count.index + 1}"
  folder           = "Terraform-VMs"
  #resource_pool_id = data.vsphere_host.host.resource_pool_id
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm-cpu
  memory   = var.vm-ram
  guest_id = var.vm-guest-id

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "${var.vm-name}-${count.index + 1}-disk"
    thin_provisioned = true
    eagerly_scrub = false
    size  = 40
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "${var.vm-name}-${count.index + 1}"
        domain    = var.vm-domain
      }     
      network_interface {
        ipv4_address = "10.168.192.${20 + count.index}"
        ipv4_netmask = 24
      }
      timeout = 30
      ipv4_gateway = "10.168.192.1"
      dns_server_list = [ "8.8.8.8","8.8.4.4" ]
    }
  }
}

data "vsphere_virtual_machine" "win-template" {
  name          = var.win-vm-template-name
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "win_vm" {
  count = var.win-vm-count

  name             = "${var.win-vm-name}-${count.index + 1}"
  folder           = "Terraform-VMs"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  #resource_pool_id = data.vsphere_host.host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  # host_system_id = "${data.vsphere_datacenter.dc.id}"

  num_cpus                   = var.win-vm-cpu
  memory                     = var.win-vm-ram
  guest_id                   = var.win-vm-guest-id
  wait_for_guest_net_timeout = -1

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  disk {
    label             = "machine.vmdk"
    thin_provisioned = true
    eagerly_scrub    = false
    size             = 40
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.win-template.id

    customize {
      windows_options {
        computer_name = "${var.win-vm-name}-${count.index + 1}"
        # workgroup     = "test"
        #join_domain           = var.domain
        #domain_admin_user     = var.domain_admin_user
        #domain_admin_password = var.domain_admin_password
        #admin_password        = var.local_adminpass
        # product_key           = var.productkey
        # organization_name     = var.orgname
        # run_once_command_list = var.run_once
        # auto_logon            = var.auto_logon
        # auto_logon_count      = var.auto_logon_count
        # time_zone             = var.time_zone
        # product_key           = var.productkey
        # full_name             = var.full_name
      }
      network_interface {
        ipv4_address    = "10.168.192.${25 + count.index}"
        ipv4_netmask    = 24
      }
      timeout = 30
      ipv4_gateway = "10.168.192.1"
      dns_server_list = [ "8.8.8.8","8.8.4.4" ]
    }

  }
}