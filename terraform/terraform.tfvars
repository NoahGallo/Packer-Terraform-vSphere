# =================================== #
# VMware VMs configuration for Ubuntu #
# =================================== #

vm-count = 1
vm-name = "ubuntu2204"
vm-template-name = "Ubuntu2204Template"
vm-cpu = 2
vm-ram = 4096
vm-guest-id = "ubuntu64Guest"

# ==================================== #
# VMware VMs configuration for Windows #
# ==================================== #

win-vm-count = 2
win-vm-name = "WinServer2022"
win-vm-template-name = "WinServer2022Template"
win-vm-cpu = 2
win-vm-ram = 4096
win-vm-guest-id = "windows9Server64Guest"

# ============================ #
# VMware vSphere configuration #
# ============================ #

# VMware vCenter IP/FQDN
vsphere-vcenter = "10.168.192.41"

# VMware vSphere username used to deploy the infrastructure
vsphere-user = "administrator@vsphere.local"

# VMware vSphere password used to deploy the infrastructure
vsphere-password = "Test..123"

# Skip the verification of the vCenter SSL certificate (true/false)
vsphere-unverified-ssl = "true"

# vSphere datacenter name where the infrastructure will be deployed
vsphere-datacenter = "Datacenter"

# vSphere cluster name where the infrastructure will be deployed
vsphere-cluster = "Cluster"

#vsphere-host = "10.168.192.40"

# vSphere Datastore used to deploy VMs 
vm-datastore = "storage"

# vSphere Network used to deploy VMs 
vm-network = "Other"
win-vm-network = "value"

# Linux virtual machine domain name
vm-domain = ""