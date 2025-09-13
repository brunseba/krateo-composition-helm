#!/bin/bash

set -e

echo "🔄 Updating Krateo Composition Helm Repository..."

# Create directories if they don't exist
mkdir -p charts docs

# Package all charts from src directory
echo "📦 Packaging charts..."
for chart_dir in src/*/; do
    if [ -f "${chart_dir}Chart.yaml" ]; then
        chart_name=$(basename "$chart_dir")
        echo "  📦 Packaging $chart_name..."
        helm package "$chart_dir" --destination charts/
    fi
done

# Copy packaged charts to docs directory for GitHub Pages
echo "📋 Copying charts to docs..."
cp charts/*.tgz docs/

# Generate/update repository index
echo "📝 Generating repository index..."
helm repo index docs/ --url https://brunseba.github.io/krateo-composition-helm --merge docs/index.yaml

echo "✅ Repository updated successfully!"
echo ""
echo "📊 Charts in repository:"
helm repo index docs/ --url https://brunseba.github.io/krateo-composition-helm --dry-run | grep -A 10 "entries:" | grep "name:"

echo ""
echo "🚀 Next steps:"
echo "  1. Commit and push changes to GitHub"
echo "  2. GitHub Pages will automatically update"
echo "  3. Test with: helm repo add krateo-composition https://brunseba.github.io/krateo-composition-helm"