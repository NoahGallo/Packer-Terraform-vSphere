# Virtual Machine Automation Project

## Description
This project focuses on using Hashicorp Packer and Terraform for automating the creation and deployment of virtual machine templates.

## Approach and Problems Encountered

### Hashicorp Packer: Creating Virtual Machine Templates
- **Objective**: Automate the installation of operating systems through code.
- **Process**:
  - Utilize existing nested vmware infrastructure.
  - Modify open-source code to meet project specifications.
  - Employ data files, shell scripts, and configuration files.
  - Use Ansible for additional configurations, like webserver installation.

### Automation Process
- **Steps**:
  - Launch a VM from a specified ISO.
  - Set up a local webserver for OS configuration files.
  - Execute unattended OS installation using boot commands.
  - Integrate Ansible for advanced automation tasks.

#### Command used to launch the Packer build process
Example for Ubuntu22.04:  
You first need to be in the packer/ubuntu22.04 folder  
Launch the build:
```bash
packer build -var-file credentials.json ubuntu.json
```

### Hashicorp Terraform: Deploying VMs
- **Objective**: Automate the deployment of VMs from templates.
- **Process**:
  - Clone VMs from templates.
  - Configure network settings like static IPs and hostnames.
  - Deploy multiple VMs with incremental variables.
  - Write infrastructure code in a JSON-like syntax.

### Workflow
- **Terraform Commands**:
  - `terraform plan` to validate configurations.
  - `terraform apply` to execute the configurations.
  - Monitor the VM cloning process.
  - Verify the correct assignment of network settings.

### Challenges Faced
- Adapting open-source code for specific needs.
- Mastering the automation of various operating systems.
- Handling resource usage variations during deployment.

## Future Implementations
- **Planned Technologies**:
  - Implement credential management solutions.
  - Integrate load balancing for efficient traffic distribution.
