#!/bin/bash
# Cross-Platform Project Cline Setup Script

PROJECT_PATH=${1:-$(pwd)}
TEMPLATE_REPO=${2:-"https://raw.githubusercontent.com/GreenGavin/cline-crossplatform-templates/main"}

echo "🚀 Setting up Cline context for cross-platform project..."

# Ensure we're in the right directory
if [ ! -d "$PROJECT_PATH" ]; then
    echo "❌ Project path does not exist: $PROJECT_PATH"
    exit 1
fi

cd "$PROJECT_PATH"

# Create .cline directory if it doesn't exist
if [ ! -d ".cline" ]; then
    mkdir -p ".cline"
    echo "✅ Created .cline directory"
fi

# Create templates subdirectory
if [ ! -d ".cline/templates" ]; then
    mkdir -p ".cline/templates/issue-templates"
    echo "✅ Created templates directory structure"
fi

# Function to download template files
download_template() {
    local file_name="$1"
    local local_path="$2"
    local url="${TEMPLATE_REPO}/templates/${file_name}"
    
    if curl -f -s "$url" -o "$local_path"; then
        echo "✅ Downloaded: $file_name"
    else
        echo "❌ Failed to download $file_name"
    fi
}

# Download main template files
echo "📡 Downloading template files..."

download_template "instructions.md" ".cline/instructions.md"
download_template "git-workflow.md" ".cline/git-workflow.md"
download_template "github-integration.md" ".cline/github-integration.md"
download_template "security-notes.md" ".cline/security-notes.md"

# Download issue templates
download_template "issue-templates/bug-report.md" ".cline/templates/issue-templates/bug-report.md"
download_template "issue-templates/feature-request.md" ".cline/templates/issue-templates/feature-request.md"
download_template "issue-templates/performance-issue.md" ".cline/templates/issue-templates/performance-issue.md"
download_template "issue-templates/security-issue.md" ".cline/templates/issue-templates/security-issue.md"

# Create basic context files if they don't exist
if [ ! -f ".cline/context.md" ]; then
    cat > ".cline/context.md" << EOL
# Project Context - $(basename "$PROJECT_PATH")

## Current Status
New cross-platform project setup with Cline context initialized.

## Recent Progress
- Cline templates downloaded and configured
- Cross-platform architecture ready for development

## Active Development Areas
- Initial project setup
- Architecture planning
- Platform-specific implementations

## Known Issues
None at this time.

## Technical Debt
None at this time.

## Offline/Sync Status
- Offline-first architecture planned
- Cloud sync providers to be configured
- Encryption implementation pending
EOL
    echo "✅ Created context.md"
fi

if [ ! -f ".cline/tasks.md" ]; then
    cat > ".cline/tasks.md" << EOL
# Development Tasks

## High Priority
- [ ] Define project requirements and user stories
- [ ] Set up development environment for all target platforms
- [ ] Plan offline-first architecture and data models
- [ ] Design end-to-end encryption strategy

## Medium Priority
- [ ] Set up CI/CD pipeline for multi-platform builds
- [ ] Configure cloud sync providers
- [ ] Plan user interface and navigation
- [ ] Set up comprehensive testing strategy

## Low Priority
- [ ] Documentation and user guides
- [ ] Performance optimization planning
- [ ] Analytics and monitoring setup
- [ ] App store submission preparation

## Completed Recently
- [x] Cline context setup completed
- [x] Template files downloaded and configured
EOL
    echo "✅ Created tasks.md"
fi

if [ ! -f ".cline/decisions.md" ]; then
    cat > ".cline/decisions.md" << EOL
# Architecture Decision Record

## ADR-001: Cross-Platform Development with React Native
- **Decision**: Use React Native with platform-specific adaptations
- **Rationale**: Single codebase with native performance and platform integration
- **Status**: Implemented
- **Date**: $(date +%Y-%m-%d)
- **Consequences**: Faster development, consistent UX, easier maintenance

## ADR-002: Offline-First Architecture
- **Decision**: Implement offline-first architecture with local database
- **Rationale**: Ensure app functionality without internet dependency
- **Status**: Planned
- **Date**: $(date +%Y-%m-%d)
- **Consequences**: Better user experience, complex sync logic, higher development complexity

## ADR-003: End-to-End Encryption
- **Decision**: Implement client-side encryption before cloud storage
- **Rationale**: Ensure user privacy and data security
- **Status**: Planned
- **Date**: $(date +%Y-%m-%d)
- **Consequences**: Maximum privacy, complex key management, sync complexity

[Add more ADRs as architectural decisions are made]
EOL
    echo "✅ Created decisions.md"
fi

# Download and save template version
if curl -f -s "${TEMPLATE_REPO}/VERSION" -o ".cline/TEMPLATE_VERSION"; then
    version=$(cat ".cline/TEMPLATE_VERSION")
    echo "✅ Template version: $version"
else
    echo "1.0.0" > ".cline/TEMPLATE_VERSION"
    echo "⚠️ Could not retrieve template version, set to 1.0.0"
fi

# Check if this is a cross-platform project and provide guidance
if [ -f "package.json" ] && grep -q "react-native" package.json; then
    echo "🎯 React Native project detected!"
    echo "   Package.json found with React Native dependencies"
elif [ -d "electron" ] || [ -f "electron.js" ]; then
    echo "🎯 Electron project detected!"
    echo "   Electron directory or configuration found"
elif [ -d "src/platforms" ]; then
    echo "🎯 Cross-platform project structure detected!"
    echo "   Platform-specific directories found"
else
    echo "⚠️  No clear cross-platform indicators detected."
    echo "   Make sure you're in the correct directory or initialize your project first."
fi

echo ""
echo "🎉 Cline setup complete!"
echo "📁 Files created in .cline/ directory:"
find ".cline" -type f | sort

echo ""
echo "📋 Next steps:"
echo "1. Review and customize .cline/instructions.md for your project"
echo "2. Update .cline/context.md with your project specifics"
echo "3. Add your initial tasks to .cline/tasks.md"
echo "4. Configure your target platforms and development environment"
echo "5. Start using Cline with your standardized cross-platform workflow!"
EOF

chmod +x scripts/setup-project.sh
