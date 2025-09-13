# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v1.1.0] - 2025-09-13

### 🎯 Major Release - Complete Chart Collection with Issue Tracking

### Added
- **Comprehensive README**: Complete overhaul with usage examples, troubleshooting, and integration guides
- **Chart Status Tracking**: Clear indicators for working vs. blocked Krateo integrations
- **Known Issues Section**: Professional documentation of MariaDB composition CRD generation failure
- **Troubleshooting Guide**: Common problems, solutions, and debug commands
- **Enhanced Chart Details**: Comprehensive feature descriptions for all three charts
- **Resource Links**: Complete platform and technology documentation
- **GitHub Issue #10**: Professional tracking of MariaDB composition problem

### Changed
- **Repository Structure**: Organized documentation with expanded chart information
- **Usage Examples**: Detailed installation examples for all chart types
- **Krateo Integration**: Updated with working and blocked integration status
- **Chart Documentation**: Enhanced descriptions with enterprise features
- **Professional Standards**: Enterprise-ready documentation and support

### Fixed
- **Documentation Clarity**: Clear communication about current capabilities and limitations
- **Issue Transparency**: Open reporting of known problems with workarounds
- **User Guidance**: Comprehensive troubleshooting and alternative deployment methods

## [v1.0.2] - 2025-09-13

### Fixed
- **MariaDB Schema**: Remove problematic accessModes field from JSON schema
- **Krateo Compatibility**: Attempt to resolve CRD generation errors (upstream issue remains)

## [v1.0.1] - 2025-09-13

### Fixed
- **MariaDB Schema**: Simplified JSON schema for Krateo compatibility
- **Schema Validation**: Reduced complex field validations and patterns

## [v1.0.0] - 2025-09-13

### Added
- **MariaDB Chart**: Complete MariaDB cluster Helm chart with operator CRDs
- **Galera Clustering**: High availability MariaDB with multi-master support
- **Auto-generated Secrets**: Password management and connection credentials
- **Monitoring Integration**: Prometheus metrics and ServiceMonitor support
- **JSON Schema**: Krateo UI generation schema (with known CRD generation issue)

## [v0.3.0] - 2025-09-13

### Added
- **KubeVirt Chart**: Virtual machine lifecycle management chart
- **Cloud-Init Support**: Automated VM configuration and initialization
- **VM Storage**: Persistent disk allocation and management
- **Network Services**: VM networking and service discovery
- **JSON Schema**: Dynamic form generation for VM configuration

## [v0.2.0] - 2025-09-13

### Added
- **JSON Schema Compatibility**: Schema definitions for Krateo UI generation
- **Dynamic Forms**: Enable self-service deployment through Krateo dashboard
- **OpenAPI v3 Support**: Standard schema validation and documentation
- **Field Validation**: User-friendly titles, descriptions, and default values

## [v0.1.0] - 2025-09-13

### Added
- **Initial Repository**: Setup with GitHub Pages and Helm repository
- **CNPG PostgreSQL Chart**: CloudNativePG PostgreSQL cluster implementation
- **Production Ready**: High-availability database clustering
- **Connection Pooling**: PgBouncer integration for performance
- **Monitoring**: PostgreSQL metrics and backup configuration
- **Krateo Integration**: CompositionDefinition support and labels

---

## Release Statistics

- **Total Releases**: 6
- **Charts Available**: 3 (PostgreSQL, MariaDB, KubeVirt)
- **Krateo Ready**: 2 fully functional integrations
- **Known Issues**: 1 (MariaDB composition CRD generation)
- **Documentation**: Complete with troubleshooting and examples

## Links

- **Repository**: https://github.com/brunseba/krateo-composition-helm
- **Chart Repository**: https://brunseba.github.io/krateo-composition-helm
- **Latest Release**: https://github.com/brunseba/krateo-composition-helm/releases/latest
- **Issues**: https://github.com/brunseba/krateo-composition-helm/issues