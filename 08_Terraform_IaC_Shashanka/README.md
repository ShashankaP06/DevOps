# 08 — Infrastructure as Code (Terraform)

**Est. time:** 5-6 weeks @ 2-5 hrs/week
**Status:** 🔲 Not started

## Why this matters for you

Manually clicking around the AWS console doesn't scale and isn't
repeatable/auditable. Terraform lets you define infrastructure as versioned
code — reviewed via PRs, just like application code.

## Topics Checklist

- [ ] HCL syntax basics: resources, providers, variables, outputs
- [ ] State files: what they are, why remote state matters (S3 + DynamoDB
      locking), never editing state by hand
- [ ] Plan vs Apply workflow
- [ ] Modules: reusing infrastructure code
- [ ] Managing multiple environments (dev/staging/prod) cleanly
- [ ] Importing existing (manually-created) resources into Terraform
- [ ] Basic Ansible overview (config management vs provisioning — how it
      complements Terraform)

## Free Resources

- [HashiCorp Learn — Terraform on AWS](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)
- [Terraform Associate certification study guide](https://developer.hashicorp.com/terraform/tutorials/certification-associate-tutorials-003)

## Hands-on Mini Project

Recreate your Module 06 AWS mini-project (EC2 instance + S3 bucket) entirely
in Terraform:
1. Write `.tf` files defining the EC2 instance, security group, and S3 bucket.
2. Use variables for anything environment-specific.
3. Store state remotely in an S3 backend with DynamoDB locking.
4. Destroy and re-apply to prove it's fully reproducible.

Save the Terraform code + a `NOTES.md` in this folder (remember to `.gitignore`
`.tfstate` and `.terraform/`, and never commit AWS credentials).
