# Cross-Platform Project Cline Setup Script (PowerShell)
param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectPath,
    
    [Parameter(Mandatory=$false)]
    [string]$TemplateRepo = "https://raw.githubusercontent.com/GreenGavin/cline-crossplatform-templates/main"
)

Write-Host "🚀 Setting up Cline context for cross-platform project..." -ForegroundColor Green

# Ensure we're in the right directory
if (!(Test-Path $ProjectPath)) {
    Write-Error "Project path does not exist: $ProjectPath"
    exit 1
}

Set-Location $ProjectPath

# Create .cline directory if it doesn't exist
if (!(Test-Path ".cline")) {
    New-Item -ItemType Directory -Path ".cline" -Force
    Write-Host "✅ Created .cline directory" -ForegroundColor Green
}

# Create templates subdirectory
if (!(Test-Path ".cline\templates")) {
    New-Item -ItemType Directory -Path ".cline\templates" -Force
    New-Item -ItemType Directory -Path ".cline\templates\issue-templates" -Force
    Write-Host "✅ Created templates directory structure" -ForegroundColor Green
}

# Function to download template files
function Download-Template {
    param($FileName, $LocalPath)
    
    try {
        $url = "$TemplateRepo/templates/$FileName"
        
        # Ensure directory exists
        $dir = Split-Path $LocalPath -Parent
        if (!(Test-Path $dir)) {
            New-Item -ItemType Directory -Path $dir -Force
        }
        
        Invoke-WebRequest -Uri $url -OutFile $LocalPath -UseBasicParsing
        Write-Host "✅ Downloaded: $FileName" -ForegroundColor Green
    }
    catch {
        Write-Warning "❌ Failed to download $FileName`: $_"
    }
}

# Download main template files
Write-Host "📡 Downloading cross-platform template files..." -ForegroundColor Cyan

Download-Template "instructions.md" ".cline\instructions.md"
Download-Template "git-workflow.md" ".cline\git-workflow.md"
Download-Template "github-integration.md" ".cline\github-integration.md"
Download-Template "security-notes.md" ".cline\security-notes.md"

# Download issue templates (cross-platform specific)
Download-Template "issue-templates/bug-report.md" ".cline\templates\issue-templates\bug-report.md"
Download-Template "issue-templates/feature-request.md" ".cline\templates\issue-templates\feature-request.md"
Download-Template "issue-templates/performance-issue.md" ".cline\templates\issue-templates\performance-issue.md"
Download-Template "issue-templates/security-issue.md" ".cline\templates\issue-templates\security-issue.md"

# Create basic context files if they don't exist
if (!(Test-Path ".cline\context.md")) {
    $contextContent = @"
# Project Context - $(Split-Path $ProjectPath -Leaf)

## Current Status
New cross-platform project setup with Cline context initialized.

## Recent Progress
- Cline templates downloaded and configured
- Cross-platform architecture ready for development

## Active Development Areas
- Initial project setup
- Platform-specific implementations
- Offline-first architecture planning

## Known Issues
None at this time.

## Technical Debt
None at this time.

## Offline/Sync Status
- Offline-first architecture planned
- Cloud sync providers to be configured
- Encryption implementation pending
"@
    Set-Content -Path ".cline\context.md" -Value $contextContent
    Write-Host "✅ Created context.md" -ForegroundColor Green
}

if (!(Test-Path ".cline\tasks.md")) {
    $tasksContent = @"
# Development Tasks

## High Priority
- [ ] Define project requirements and user stories
- [ ] Set up development environment for target platforms
- [ ] Plan offline-first architecture and data models
- [ ] Design end-to-end encryption strategy

## Medium Priority
- [ ] Set up CI/CD pipeline for multi-platform builds
- [ ] Configure cloud sync providers (Dropbox, OneDrive, etc.)
- [ ] Plan user interface and navigation
- [ ] Set up comprehensive testing strategy

## Low Priority
- [ ] Documentation and user guides
- [ ] Performance optimization planning
- [ ] Analytics and monitoring setup
- [ ] App store submission preparation

## Completed Recently
- [x] Cline context setup completed
- [x] Cross-platform template files downloaded
"@
    Set-Content -Path ".cline\tasks.md" -Value $tasksContent
    Write-Host "✅ Created tasks.md" -ForegroundColor Green
}

if (!(Test-Path ".cline\decisions.md")) {
    $decisionsContent = @"
# Architecture Decision Record

## ADR-001: Cross-Platform Development with React Native
- **Decision**: Use React Native with platform-specific adaptations
- **Rationale**: Single codebase with native performance and platform integration
- **Status**: Implemented
- **Date**: $(Get-Date -Format 'yyyy-MM-dd')
- **Consequences**: Faster development, consistent UX, easier maintenance

## ADR-002: Offline-First Architecture
- **Decision**: Implement offline-first architecture with local database
- **Rationale**: Ensure app functionality without internet dependency
- **Status**: Planned
- **Date**: $(Get-Date -Format 'yyyy-MM-dd')
- **Consequences**: Better user experience, complex sync logic

## ADR-003: End-to-End Encryption
- **Decision**: Implement client-side encryption before cloud storage
- **Rationale**: Ensure user privacy and data security
- **Status**: Planned
- **Date**: $(Get-Date -Format 'yyyy-MM-dd')
- **Consequences**: Maximum privacy, complex key management

[Add more ADRs as architectural decisions are made]
"@
    Set-Content -Path ".cline\decisions.md" -Value $decisionsContent
    Write-Host "✅ Created decisions.md" -ForegroundColor Green
}

# Download and save template version
try {
    $version = Invoke-WebRequest -Uri "$TemplateRepo/VERSION" -UseBasicParsing
    Set-Content -Path ".cline\TEMPLATE_VERSION" -Value $version.Content.Trim()
    Write-Host "✅ Template version: $($version.Content.Trim())" -ForegroundColor Green
}
catch {
    Write-Warning "❌ Could not retrieve template version"
    Set-Content -Path ".cline\TEMPLATE_VERSION" -Value "1.0.0"
}

# Check if this is a cross-platform project
$hasPackageJson = Test-Path "package.json"
$hasElectron = Test-Path "electron"
$hasReactNative = $false

if ($hasPackageJson) {
    try {
        $packageContent = Get-Content "package.json" | ConvertFrom-Json
        $deps = @()
        if ($packageContent.dependencies) { $deps += $packageContent.dependencies.PSObject.Properties.Name }
        if ($packageContent.devDependencies) { $deps += $packageContent.devDependencies.PSObject.Properties.Name }
        
        $hasReactNative = $deps | Where-Object { $_ -like "*react-native*" -or $_ -eq "electron" }
    }
    catch {
        Write-Warning "Could not parse package.json"
    }
}

if ($hasPackageJson -and ($hasReactNative -or $hasElectron)) {
    Write-Host "🎯 Cross-platform project detected!" -ForegroundColor Cyan
    if ($hasReactNative) { Write-Host "   React Native dependencies found" -ForegroundColor Gray }
    if ($hasElectron) { Write-Host "   Electron directory found" -ForegroundColor Gray }
}
else {
    Write-Host "⚠️  No clear cross-platform indicators detected." -ForegroundColor Yellow
    Write-Host "   Make sure you're in the correct directory or initialize your project first." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🎉 Cline setup complete!" -ForegroundColor Green
Write-Host "📁 Files created in .cline\ directory:" -ForegroundColor Cyan
Get-ChildItem -Path ".cline" -Recurse | ForEach-Object {
    Write-Host "   $($_.FullName.Replace((Get-Location).Path, '.'))" -ForegroundColor Gray
}

Write-Host ""
Write-Host "📋 Next steps:" -ForegroundColor Cyan
Write-Host "1. Review and customize .cline\instructions.md for your project" -ForegroundColor Gray
Write-Host "2. Update .cline\context.md with your project specifics" -ForegroundColor Gray
Write-Host "3. Add your initial tasks to .cline\tasks.md" -ForegroundColor Gray
Write-Host "4. Configure your target platforms and development environment" -ForegroundColor Gray
Write-Host "5. Start using Cline with your standardized cross-platform workflow!" -ForegroundColor Gray