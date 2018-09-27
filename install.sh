#!/bin/bash

install_kubectl_playbook='ansible/install-kubectl.yml'
install_kops_playbook='ansible/install-kops.yml'
create_k8s_cluster='ansible/create-kubernetes-cluster.yml'
install_addons_playbook='ansible/install-addons.yml'
validate_kops_playbook='ansible/validate-kops.yml'

ansible-playbook $install_kubectl_playbook -i ansible/hosts -u admin
ansible-playbook $install_kops_playbook -i ansible/hosts -u admin
ansible-playbook $create_k8s_cluster -i ansible/hosts -u admin
ansible-playbook $install_addons_playbook -i ansible/hosts -u admin
ansible-playbook $validate_kops_playbook --extra-vars "name=$cluster_name state=s3://$s3_bucket_name" -i ansible/hosts -u $remote_user
