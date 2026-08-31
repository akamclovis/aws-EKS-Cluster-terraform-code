# Production Environment

Production infrastructure is not implemented yet.

When production is introduced, it should follow the same layered pattern as development:

```text
environments/prod/
├── core/
├── platform/
└── kubernetes/
```

The production roots should reuse the same modules with production-specific variables and separate remote-state keys.

Likely production differences include:

- One NAT Gateway per Availability Zone instead of a single shared development NAT Gateway
- Higher managed node group capacity
- Production-appropriate instance types
- Stricter EKS public endpoint CIDR policy, or private-only access with private administrative connectivity
- Longer backup, retention, and recovery requirements
- More formal add-on version pinning and upgrade windows

Do not create production Terraform roots until the production architecture and operational requirements are explicitly approved.
