## RHACM setup and integration to manage Azure AKS and other K8S clusters

### Project Overview
Following project provides the instructions to setup and integrate RHACM (Red Hat Advanced Cluster Management for Kubernetes) operator to manage Azure AKS and other K8S clusters.
Managing all kubernetes clusters in one place is a big challenge, RHACM provides the easy and cost effective solution.

Topics covered:
- bastion host setup
- bastion host configuration (installation of required components)
- Red Hat OpenShift default installation at Azure (at the aro directory I provided ARO option)
- RHACM operator installation and setup (see: rhacm_important_notice.txt)
- Azure AKS cluster setup and integration

### Setup Instructions
Setup process could be done from your local machine, or from remote, Azure bastion host we can create with scripts provided in the [bastion](./bastion) directory.

1. Generate SSH key pair:

```
$ cd bastion
$ ./01_generate_ssh_key.sh
```


Once bastion host is ready we can ssh to it

### Project Screenshots

#### Image 1
![Image 1](img/1.png)

#### Image 2
![Image 2](img/2.png)

#### Image 3
![Image 3](img/3.png)

#### Image 4
![Image 4](img/4.png)

#### Image 5
![Image 5](img/5.png)

### Project Overview
[Add your project description here]

### Setup Instructions
[Add setup and installation instructions]
