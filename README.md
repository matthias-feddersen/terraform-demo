# Terraform hands-on demo (no cloud)

Two folders, same providers, no accounts or extra setup:

| Folder | What it is |
| --- | --- |
| `hands-on/` | Start here. Providers and variables are ready; uncomment resources as you go. |
| `complete/` | The finished version. Peek when stuck, or `terraform apply` to see the end state. |

## Why these providers

Nothing to log into. You still touch the core Terraform loop: plan → apply → state → outputs.

- **random** — create values Terraform remembers in state (`random_pet`, `random_password`)
- **local** — write real files to disk (your “infrastructure”)
- **tls** — generate a key and self-signed cert (feels like infra, still local)
- **http** — a **data source**: read from the public internet, do not create anything

You will also use variables, locals, `for_each`, sensitive values, and outputs.

## Prereqs

Terraform on the PATH. From this repo:

```bash
./setup.sh
terraform version
```

## Follow along (`hands-on/`)

```bash
cd hands-on
terraform init
terraform plan
```

Open `main.tf` and work **step 1 → 6**. After each uncommented block:

```bash
terraform plan
terraform apply
```

Useful extras:

```bash
terraform state list
terraform output
terraform output -raw db_password   # after the password output exists
ls -R generated/
terraform destroy
```

Compare with `complete/main.tf` if a step fails.

## See the finished project (`complete/`)

```bash
cd complete
terraform init
terraform apply
ls -R generated/
terraform output
terraform destroy
```

Generated files live under `generated/` (gitignored). State is local `terraform.tfstate` (also gitignored).
