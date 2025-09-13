# Krateo Composition Helm Repository

A comprehensive Helm chart repository containing enterprise-grade charts optimized for use with Krateo PlatformOps compositions, featuring database clusters, virtualization, and infrastructure automation.

## 🚨 **Current Status**

- **PostgreSQL**: ✅ **Working** (Krateo integration functional)
- **KubeVirt VMs**: ✅ **Working** (Krateo integration functional)  
- **MariaDB**: ⚠️ **Partial** (Chart works, Krateo CRD generation blocked - [Issue #10](https://github.com/brunseba/krateo-composition-helm/issues/10))

## 📦 Available Charts

### 🐘 CNPG PostgreSQL Cluster
- **Chart Name**: `cnpg-postgres-cluster`
- **Version**: `1.0.0`
- **Status**: ✅ **Production Ready**
- **Description**: CloudNativePG (CNPG) PostgreSQL cluster with high availability
- **Features**:
  - PostgreSQL high-availability clustering
  - Connection pooling with PgBouncer
  - Monitoring integration
  - Backup configuration support
  - Krateo-optimized labels and structure

### 🗄️ MariaDB Cluster  
- **Chart Name**: `mariadb-cluster`
- **Version**: `1.0.2`
- **Status**: ⚠️ **Chart Ready, Krateo Integration Blocked**
- **Description**: MariaDB operator-based cluster with Galera support
- **Features**:
  - MariaDB operator CRD integration
  - Galera clustering for high availability
  - Configurable storage and resources
  - Prometheus monitoring support
  - Auto-generated connection secrets
- **Known Issue**: [Krateo CRD generation fails](https://github.com/brunseba/krateo-composition-helm/issues/10) due to upstream schema processing bug

### 💻 KubeVirt Virtual Machine
- **Chart Name**: `kubevirt-vm`
- **Version**: `1.0.0`  
- **Status**: ✅ **Production Ready**
- **Description**: KubeVirt-based virtual machine deployment
- **Features**:
  - VM lifecycle management
  - Cloud-init configuration
  - Storage and networking setup
  - Resource allocation control
  - Infrastructure as Code capabilities

## 🚀 Usage

### Add Repository
```bash
helm repo add krateo-composition https://brunseba.github.io/krateo-composition-helm
helm repo update
```

### Search Charts
```bash
helm search repo krateo-composition
# Expected output:
# NAME                                           CHART VERSION   APP VERSION     DESCRIPTION
# krateo-composition/cnpg-postgres-cluster      1.0.0           15              CloudNativePG PostgreSQL cluster
# krateo-composition/kubevirt-vm                1.0.0           1.0.0           KubeVirt virtual machine
# krateo-composition/mariadb-cluster            1.0.2           11.4.2          MariaDB cluster with operator CRDs
```

### Install Charts

#### PostgreSQL Cluster
```bash
helm install my-postgres krateo-composition/cnpg-postgres-cluster
```

#### Virtual Machine
```bash
helm install my-vm krateo-composition/kubevirt-vm \
  --set vm.name=ubuntu-vm \
  --set vm.memory=2Gi \
  --set vm.cpu.cores=2
```

#### MariaDB Cluster (Direct Helm)
```bash
# Note: Krateo composition blocked (see Issue #10)
helm install my-mariadb krateo-composition/mariadb-cluster \
  --set cluster.name=my-mariadb \
  --set database=myapp \
  --set username=myuser
```

## 🎯 Krateo Integration

These charts are specifically designed for use with Krateo PlatformOps CompositionDefinitions with varying support levels:

### ✅ **Working Integrations**

#### PostgreSQL Cluster
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

#### KubeVirt VM
```yaml
apiVersion: core.krateo.io/v1alpha1
kind: CompositionDefinition
metadata:
  name: kubevirt-vm
  namespace: krateo-system
spec:
  chart:
    repo: kubevirt-vm
    url: https://brunseba.github.io/krateo-composition-helm
    version: "1.0.0"
```

### ⚠️ **Blocked Integration**

#### MariaDB Cluster
```yaml
# ⚠️ Currently fails due to Krateo CRD generation bug
# See: https://github.com/brunseba/krateo-composition-helm/issues/10
apiVersion: core.krateo.io/v1alpha1
kind: CompositionDefinition
metadata:
  name: mariadb-cluster
  namespace: krateo-system
spec:
  chart:
    repo: mariadb-cluster
    url: https://brunseba.github.io/krateo-composition-helm
    version: "1.0.2"
# Status: Fails with schema validation errors
```

**Workaround**: Use direct MariaDB operator CRDs or Helm installation until upstream issue resolved.

## 📋 Chart Details

### 🐘 CNPG PostgreSQL Cluster

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

### 🗄️ MariaDB Cluster

#### Key Components
- **MariaDB Operator CRD**: Native Kubernetes MariaDB management
- **Galera Clustering**: Multi-master high availability
- **Connection Secrets**: Auto-generated credentials
- **Monitoring**: Prometheus metrics integration
- **Storage Management**: Persistent volume configuration

#### Default Configuration
- **Replicas**: 3 MariaDB nodes (configurable 1-9)
- **Resources**: 512Mi memory, 250m CPU (requests)
- **Storage**: 10Gi persistent storage
- **Galera**: Enabled for HA (can be disabled for single instance)
- **Monitoring**: ServiceMonitor for Prometheus

#### Features
- Auto-generated root and user passwords
- Custom database and user creation
- Pod anti-affinity for node distribution
- Rolling update support
- Custom MariaDB configuration (my.cnf)
- Security contexts and non-root execution

### 💻 KubeVirt Virtual Machine

#### Key Components
- **VirtualMachine CRD**: KubeVirt VM lifecycle management
- **Cloud-Init**: Automated VM configuration
- **DataVolume**: Persistent VM disk storage
- **Service**: VM network access
- **ConfigMap**: Cloud-init configuration data

#### Default Configuration
- **Resources**: 2Gi memory, 1 CPU core
- **Storage**: 20Gi VM disk
- **OS**: Ubuntu 22.04 (configurable)
- **Network**: Pod networking with ClusterIP service
- **Boot**: Cloud-init enabled with SSH access

#### Customizable Parameters
- VM resource allocation (CPU, memory)
- Disk size and storage class
- Operating system image selection
- Cloud-init user configuration
- Network and service settings
- VM lifecycle policies

## 🐞 Known Issues

### MariaDB Composition CRD Generation Failure
- **Issue**: [#10](https://github.com/brunseba/krateo-composition-helm/issues/10)
- **Status**: 🔴 **Open** - Upstream Krateo platform bug
- **Impact**: MariaDB composition cannot be deployed via Krateo UI
- **Root Cause**: Krateo CRD generator incorrectly processes JSON schema array default values
- **Workaround**: Use direct Helm installation or MariaDB operator CRDs
- **Error**: `Invalid value: "string": in body must be of type array: "string"`

## 🔄 Chart Development

### Repository Structure
```
krateo-composition-helm/
├── charts/                 # Chart packages (.tgz files)
│   ├── cnpg-postgres-cluster-1.0.0.tgz
│   ├── kubevirt-vm-1.0.0.tgz
│   └── mariadb-cluster-1.0.2.tgz
├── docs/                   # GitHub Pages content
│   └── index.yaml         # Helm repository index
├── src/                   # Source chart directories
│   ├── cnpg-postgres-cluster/
│   ├── kubevirt-vm/
│   └── mariadb-cluster/
├── scripts/               # Automation scripts
└── README.md
```

### Adding New Charts
1. Place source charts in `src/` directory
2. Package charts: `helm package src/chart-name -d charts/`
3. Update repository index: `helm repo index docs/ --url https://brunseba.github.io/krateo-composition-helm --merge docs/index.yaml`
4. Test with Krateo CompositionDefinition
5. Commit and push changes

## 🌟 Features

### Krateo-Optimized
- Pre-configured with `krateo.io/managed: "true"` labels
- Simplified parameter structure for easy UI generation  
- JSON schemas for dynamic form generation
- Compatible with Krateo's CompositionDefinition CRDs
- Reduced complexity compared to upstream charts

### Production-Ready
- **Database Clustering**: PostgreSQL (CNPG) and MariaDB (Galera) HA clusters
- **Virtualization**: KubeVirt VM lifecycle management
- **Security**: Pod security contexts, auto-generated secrets, non-root execution
- **Monitoring**: Prometheus metrics and ServiceMonitor integration
- **Storage**: Configurable persistent volumes and storage classes
- **Networking**: Service discovery and load balancing
- **Automation**: Infrastructure as Code with Helm and Krateo

### Enterprise Features
- High-availability clustering and automated failover
- Connection pooling and performance optimization
- Comprehensive monitoring and observability
- Resource management and scheduling optimization
- Security best practices and compliance ready

## 📚 Documentation

For detailed information about individual charts, see:
- [CNPG PostgreSQL Cluster Chart](./src/cnpg-postgres-cluster/README.md)
- [MariaDB Cluster Chart](./src/mariadb-cluster/README.md) 
- [KubeVirt VM Chart](./src/kubevirt-vm/README.md)

### Issue Tracking
- [Current Issues](https://github.com/brunseba/krateo-composition-helm/issues)
- [MariaDB Composition Problem](https://github.com/brunseba/krateo-composition-helm/issues/10)

## 🔧 Troubleshooting

### MariaDB Composition Fails
**Error**: `CustomResourceDefinition.apiextensions.k8s.io "mariadbclusters.composition.krateo.io" is invalid`

**Solution**: Use direct deployment methods:
```bash
# Option 1: Direct Helm
helm install my-mariadb krateo-composition/mariadb-cluster

# Option 2: Direct MariaDB Operator CRD
kubectl apply -f - <<EOF
apiVersion: k8s.mariadb.com/v1alpha1
kind: MariaDB
metadata:
  name: my-mariadb
spec:
  database: myapp
  username: myuser
  storage:
    size: 10Gi
EOF
```

### Chart Installation Issues
**Error**: `repository not found`

**Solution**: Add the repository first:
```bash
helm repo add krateo-composition https://brunseba.github.io/krateo-composition-helm
helm repo update
```

### Krateo CompositionDefinition Not Ready
1. Check CompositionDefinition status:
   ```bash
   kubectl describe compositiondefinitions <name> -n krateo-system
   ```
2. Verify chart accessibility:
   ```bash
   helm template test-release krateo-composition/<chart-name>
   ```
3. Check Krateo controller logs:
   ```bash
   kubectl logs -l app=krateo-controller -n krateo-system
   ```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Add or modify charts in the `src/` directory
4. Test charts locally with Krateo
5. Submit a pull request

## 📄 License

Apache 2.0 License - see LICENSE file for details.

## 🔗 Links

### Platform & Tools
- [Krateo PlatformOps](https://krateo.io/) - Cloud-native platform orchestration
- [Helm](https://helm.sh/) - Kubernetes package manager
- [GitHub Pages](https://brunseba.github.io/krateo-composition-helm) - Chart repository

### Database Technologies
- [CloudNativePG](https://cloudnative-pg.io/) - PostgreSQL operator for Kubernetes
- [MariaDB Operator](https://github.com/mariadb-operator/mariadb-operator) - MariaDB CRD management
- [Galera Cluster](https://galeracluster.com/) - Multi-master MariaDB clustering

### Virtualization
- [KubeVirt](https://kubevirt.io/) - Virtual machines on Kubernetes
- [Cloud-Init](https://cloud-init.io/) - VM initialization and configuration

### Development Resources
- [Helm Charts Best Practices](https://helm.sh/docs/chart_best_practices/)
- [Kubernetes CRD Documentation](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/)
- [JSON Schema](https://json-schema.org/) - Schema validation standards

### Project Resources
- [Repository](https://github.com/brunseba/krateo-composition-helm) - Source code and issues
- [Releases](https://github.com/brunseba/krateo-composition-helm/releases) - Version history
- [Issues](https://github.com/brunseba/krateo-composition-helm/issues) - Bug reports and feature requests
