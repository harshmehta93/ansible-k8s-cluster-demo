# ansible-k8s-cluster-demo

This project demonstrates how Kubernetes cluster can be created on any host using Ansible playbooks.

- **Ansible**
  - Ansible is open source software that automates software provisioning, configuration management and application deployment.
  - Please refer https://docs.ansible.com/ansible/latest/index.html to learn more about Ansible.
- **Kubernetes**
  - Kubernetes is an open-source container-orchestration system for automating deployment, scaling and management of containerized applications.
  - Please refer https://kubernetes.io/docs/home/?path=users&persona=app-developer&level=foundational to learn more about Kubernetes.

**Directory Structure:**
```
.
├── ansible
│   ├── create-kubernetes-cluster.yml
│   ├── files
│   │   └── kube-dashboard-access.yaml
│   ├── install-addons.yml
│   ├── install-kops.yml
│   ├── install-kubectl.yml
│   ├── roles
│   │   ├── create-cluster
│   │   │   └── tasks
│   │   │       └── main.yml
│   │   ├── dashboard
│   │   │   ├── tasks
│   │   │   │   └── main.yml
│   │   │   └── vars
│   │   │       └── main.yml
│   │   ├── heapster
│   │   │   ├── tasks
│   │   │   │   └── main.yml
│   │   │   └── vars
│   │   │       └── main.yml
│   │   ├── kops-install
│   │   │   ├── tasks
│   │   │   │   └── main.yml
│   │   │   └── vars
│   │   │       └── main.yml
│   │   ├── kops-validate
│   │   │   └── tasks
│   │   │       └── main.yml
│   │   └── kubectl-install
│   │       ├── tasks
│   │       │   └── main.yml
│   │       └── vars
│   │           └── main.yml
│   ├── validate-kops.yml
│   └── vars
│       └── config.json
├── install.sh
└── README.md
```
- install.sh: Shell script to call ansible playbooks and setup the Kubernetes cluster.
- ansible/: Parent directory which stores all the Ansible playbooks.
- ansible/files: Directory to store all the configuration related files.
- ansible/roles: Ansible roles module which is used by Ansible playbooks.
  - Each role will have either one or two of the following directories:
    - tasks: Directory to store task files (which are executed when a particular role is called by playbooks).
    - vars: Directory used to store files containing variables which is used by a particular role.
- ansible/vars: Directory to store the files containing different variables which is used by Ansible playbooks.

**Ansible playbooks:**
- Following Ansible playbooks will be executed by **install.sh** in order to setup the Kubernetes cluster.
1. Install kubectl
    - Path: ansible/install-kubectl.yml
    - Role: ansible/roles/kubectl-install
    - Description: This playbook is used to install kubectl on host machine (kubectl is a CLI for running commands against Kubernetes clusters).
2. Install kops
    - Path: ansible/install-kops.yml
    - Role: ansible/roles/kops-install
    - Description: This playbook is used to install kops which is responsible to create the cluster.
3. Create Kubernetes cluster
    - Path: ansible/create-kubernetes-cluster.yml
    - Role: ansible/roles/create-cluster
    - Description: This playbook is used to create the Kubernetes cluster on a provided host machine.
4. Install add-ons
    - Path: ansible/install-addons.yml
    - Role: ansible/roles/dashboard, ansible/roles/heapster
    - Description: This playbook is used to install different Kubernetes add-ons like dashboard (UI), heapster (to gather cluster related health metrics) etc.
5. Validate kops
    - Path: ansible/validate-kops.yml
    - Role: ansible/roles/kops-validate
    - Description: This playbook is used to validate kops and to validate whether Kubernetes cluster is up and running or not.
