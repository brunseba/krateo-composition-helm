# Krateo Composition Helm Repository

A Helm chart repository containing custom charts optimized for use with Krateo PlatformOps compositions.

## 📦 Available Charts

### CNPG PostgreSQL Cluster
- **Chart Name**: `cnpg-postgres-cluster`
- **Version**: `1.0.0`
- **Description**: A simplified CloudNativePG (CNPG) PostgreSQL cluster chart optimized for Krateo compositions
- **Features**:
  - PostgreSQL high-availability clustering
  - Connection pooling with PgBouncer
  - Monitoring integration
  - Backup configuration support
  - Krateo-optimized labels and structure

## 🚀 Usage

### Add Repository
```bash
helm repo add krateo-composition https://brunseba.github.io/krateo-composition-helm
helm repo update
```

### Search Charts
```bash
helm search repo krateo-composition
```

### Install Chart
```bash
helm install my-postgres krateo-composition/cnpg-postgres-cluster
```

## 🎯 Krateo Integration

These charts are specifically designed for use with Krateo PlatformOps CompositionDefinitions:

```yaml
apiVersion: core.krateo.io/v1alpha1
kind: CompositionDefinition
metadata:
  name: cnpg-postgresql
  namespace: krateo-system
spec:
  chart:
    repo: cnpg-postgres-cluster
    url: https://brunseba.github.io/krateo-composition-helm
    version: "1.0.0"
```

## 📋 Chart Details

### CNPG PostgreSQL Cluster

#### Key Components
- **CNPG Cluster**: High-availability PostgreSQL cluster
- **PgBouncer Pooler**: Connection pooling for improved performance
- **Monitoring**: PostgreSQL metrics and monitoring support
- **Security**: Pod security contexts and affinity rules

#### Default Configuration
- **Instances**: 3 PostgreSQL replicas
- **Resources**: 1Gi memory, 500m CPU (requests)
- **Storage**: 50Gi main storage, 10Gi WAL storage
- **Pooling**: Transaction-level connection pooling
- **Anti-affinity**: Spread pods across different nodes

#### Customizable Parameters
- Cluster topology (instances, update strategy)
- Resource allocation (CPU, memory)
- Storage configuration (size, storage class)
- PostgreSQL parameters (connections, buffers, etc.)
- Connection pooling settings
- Monitoring and backup options

## 🔄 Chart Development

### Repository Structure
```
krateo-composition-helm/
├── charts/                 # Chart packages (.tgz files)
├── docs/                   # GitHub Pages content
│   └── index.yaml         # Helm repository index
├── src/                   # Source chart directories
│   └── cnpg-postgres-cluster/
└── README.md
```

### Adding New Charts
1. Place source charts in `src/` directory
2. Package charts: `helm package src/chart-name -d charts/`
3. Update repository index: `helm repo index docs/ --url https://brunseba.github.io/krateo-composition-helm --merge docs/index.yaml`
4. Commit and push changes

## 🌟 Features

### Krateo-Optimized
- Pre-configured with `krateo.io/managed: "true"` labels
- Simplified parameter structure for easy UI generation
- Reduced complexity compared to upstream charts
- Compatible with Krateo's controller-gen requirements

### Production-Ready
- High-availability PostgreSQL clustering
- Automated failover and backup capabilities
- Connection pooling for performance
- Security best practices included
- Resource management and scheduling optimization

## 📚 Documentation

For detailed information about individual charts, see:
- [CNPG PostgreSQL Cluster Chart](./src/cnpg-postgres-cluster/README.md)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Add or modify charts in the `src/` directory
4. Test charts locally with Krateo
5. Submit a pull request

## 📄 License

Apache 2.0 License - see LICENSE file for details.

## 🔗 Links

- [Krateo PlatformOps](https://krateo.io/)
- [CloudNativePG](https://cloudnative-pg.io/)
- [Helm Charts Best Practices](https://helm.sh/docs/chart_best_practices/)