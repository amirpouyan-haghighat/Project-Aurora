# Azure Infrastructure Automation with Terraform and Ansible

Welcome to the Aurora Project! This repository helps you automate the provisioning and configuration of Azure resources using Terraform, Ansible, and CI/CD.

## Overview

This project focuses on creating a scalable and resilient cloud infrastructure in Microsoft Azure, featuring:

- **Auto-Scaling VMSS**: Implements an Azure Virtual Machine Scale Set that automatically scales based on CPU load.
- **Azure Load Balancer**: Distributes network traffic to VMSS instances, ensuring high availability.
- **Storage Solutions**: Provisions Azure Storage accounts for VM instances (used for diagnostics).
- **Script Automation via VMSS Extensions**: Automates initialization script execution across VM instances to run Ansible.
- **Ansible Configuration**: Uses Ansible for configuration management, installing and configuring Nginx, and customizing `index.html`.

## Getting Started

To get started with the Aurora Project, follow these steps:

1. **Prerequisites**: Install Terrafom (only if you want to customize project) and set up an Azure account.

2. **Configuration**:

   - Configure Azure credentials as GitHub Secrets (follow [Microsoft instructions](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux), focusing on the "Service Principal Secret" method).
   - Customize the Terraform configuration as needed.
   - Set up Terraform-specific secrets (`ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_SUBSCRIPTION_ID`, `ARM_TENANT_ID`).

3. **Deployment**: Commit and push your changes to GitHub to trigger the deployment process.

4. **Customization**: Modify the project to suit your environment and requirements.

## Documentation

For full documentation, usage guides, and examples, visit [wiki](https://github.com/amirpouyan-haghighat/Project-Aurora/wiki).

## Contributing

We welcome contributions! Please see [Contribution Guidelines](CONTRIBUTING.md) for how to get involved.

## License

The project is under the [MIT License](LICENSE).

## Acknowledgments

- Thanks to all contributors and the open-source community.

## Support

For questions or support, please [open an issue](https://github.com/amirpouyan-haghighat/Project-Aurora/issues) or contact us directly.

Happy automating!
