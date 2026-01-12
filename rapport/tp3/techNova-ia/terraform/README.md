# TechNova Phase 2 - Infrastructure as Code

## Déploiement Terraform réussi

**Date :** $(date)
**Ressources créées :** 8

### Instances EC2
- Instance 1 : web-technova-1
- Instance 2 : web-technova-2

### VPC
- ID VPC : $(terraform output -raw vpc_id)
- CIDR : 10.0.0.0/16

### IPs Publiques
$(terraform output instance_ips)

## Prochaine étape
Lancer TP3.2 (Ansible) pour configurer les serveurs.
