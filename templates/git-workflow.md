# Git Workflow for Cross-Platform Projects

## Branch Strategy

### Main Branches
- **main**: Production-ready code, protected branch
- **develop**: Integration branch for features, auto-deploys to staging
- **release/x.x.x**: Release preparation branches
- **hotfix/**: Critical production fixes

### Feature Branches
- **feature/**: New features and enhancements
- **bugfix/**: Non-critical bug fixes
- **platform/**: Platform-specific implementations
- **sync/**: Cloud sync and offline functionality
- **security/**: Security improvements and fixes
- **perf/**: Performance optimizations
- **chore/**: Maintenance tasks (dependencies, refactoring)

### Branch Naming Convention
```
feature/offline-data-encryption
feature/dropbox-sync-integration
platform/electron-file-dialogs
platform/ios-biometric-auth
bugfix/sync-conflict-resolution
security/key-derivation-improvement
perf/database-query-optimization
chore/update-react-native-dependencies
release/v2.1.0
hotfix/critical-sync-bug
```

## Commit Message Standards

### Conventional Commits Format
```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Commit Types
- **feat**: New feature for the user
- **fix**: Bug fix for the user
- **security**: Security-related changes
- **perf**: Performance improvements
- **platform**: Platform-specific changes
- **sync**: Cloud synchronization changes
- **ui**: User interface changes
- **db**: Database-related changes
- **crypto**: Cryptography and encryption changes
- **offline**: Offline functionality changes
- **docs**: Documentation changes
- **style**: Code style changes (formatting, etc.)
- **refactor**: Code refactoring without changing functionality
- **test**: Adding or updating tests
- **chore**: Build process, dependency updates, or tooling changes
- **ci**: CI/CD configuration changes

### Scope Examples for Cross-Platform
- **core**: Core business logic
- **services**: Service layer changes
- **components**: UI component changes
- **screens**: Screen-level changes
- **auth**: Authentication/authorization
- **sync**: Synchronization logic
- **encryption**: Encryption/decryption
- **database**: Database operations
- **cloud**: Cloud provider integrations
- **electron**: Electron-specific changes
- **ios**: iOS-specific changes
- **android**: Android-specific changes
- **web**: Web platform changes
- **windows**: Windows platform changes
- **macos**: macOS platform changes

### Commit Message Examples
```bash
feat(sync): implement Dropbox delta sync with conflict resolution
fix(encryption): resolve key derivation memory leak on mobile
security(auth): add biometric authentication for iOS and Android
perf(database): optimize PouchDB queries with proper indexing
platform(electron): add secure file picker with sandboxing
ui(components): improve collection grid performance with virtualization
sync(cloud): add OneDrive integration with client-side encryption
offline(database): implement robust conflict resolution for offline changes
crypto(core): migrate from AES-128 to AES-256 encryption
db(models): add validation schemas for collection data
docs(readme): update cross-platform setup instructions
test(sync): add comprehensive tests for sync conflict scenarios
chore(deps): update React Native to version 0.73
ci(build): add automated builds for all platforms
```

## Pull Request Guidelines

### PR Requirements
- [ ] Branch is up to date with target branch
- [ ] All tests pass on all platforms
- [ ] Code follows project style guidelines (ESLint + Prettier)
- [ ] Security considerations reviewed
- [ ] Performance impact assessed on all platforms
- [ ] Offline functionality tested
- [ ] Sync conflicts handled properly
- [ ] Documentation updated if needed
- [ ] Breaking changes documented

### Cross-Platform PR Template
```markdown
## Description
Brief description of what this PR does and which platforms are affected.

## Platforms Affected
- [ ] Web (React Native Web)
- [ ] iOS (React Native iOS)
- [ ] Android (React Native Android)
- [ ] Windows (Electron/React Native Windows)
- [ ] macOS (Electron/React Native macOS)

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Performance improvement
- [ ] Security enhancement
- [ ] Platform-specific implementation
- [ ] Sync/offline functionality
- [ ] UI/UX improvement

## Testing Checklist
- [ ] Unit tests added/updated and passing
- [ ] Integration tests added/updated and passing
- [ ] End-to-end tests passing on affected platforms
- [ ] Manual testing completed on all affected platforms
- [ ] Offline functionality tested
- [ ] Sync conflict resolution tested
- [ ] Performance impact assessed
- [ ] Security implications reviewed

## Cross-Platform Compatibility
- [ ] Code works consistently across all platforms
- [ ] Platform-specific code properly isolated
- [ ] Shared components render correctly on all platforms
- [ ] Navigation works properly on all platforms
- [ ] Data synchronization works across platforms

## Security Checklist
- [ ] Input validation implemented
- [ ] Data encryption verified
- [ ] Authentication/authorization verified
- [ ] No sensitive data exposed in logs
- [ ] Secure storage used for sensitive data
- [ ] Network requests use proper security headers
- [ ] Key management follows best practices

## Sync & Offline Checklist
- [ ] Works properly when offline
- [ ] Sync conflicts handled gracefully
- [ ] Data consistency maintained across devices
- [ ] Performance acceptable with large datasets
- [ ] Error handling for sync failures

## Related Issues
Closes #123
Relates to #456

## Breaking Changes
None / [Describe breaking changes and migration path]

## Performance Impact
[Describe any performance implications, especially for mobile platforms]

## Screenshots/Videos
[Add screenshots or videos showing the changes on different platforms]

## Platform-Specific Notes
### iOS
[Any iOS-specific considerations or testing notes]

### Android
[Any Android-specific considerations or testing notes]

### Web
[Any web platform specific considerations]

### Desktop (Electron)
[Any desktop-specific considerations]
```

### Code Review Checklist
- [ ] Code follows React Native and TypeScript best practices
- [ ] Proper error handling implemented
- [ ] Security best practices followed
- [ ] Performance considerations addressed
- [ ] Tests cover new functionality adequately
- [ ] Documentation is clear and accurate
- [ ] No hardcoded secrets or sensitive data
- [ ] Logging is appropriate and secure
- [ ] Platform-specific code properly isolated
- [ ] Offline functionality works correctly
- [ ] Sync logic handles conflicts properly

## Git Workflow Process

### Starting New Work
```bash
# Start from develop branch
git checkout develop
git pull origin develop

# Create feature branch with descriptive name
git checkout -b feature/offline-collection-encryption

# Work on feature with regular commits
git add src/core/encryption/
git commit -m "feat(crypto): add AES-256 encryption for collection data"

# Continue development
git add src/services/database/
git commit -m "feat(database): implement encrypted storage for PouchDB"

# Push feature branch
git push -u origin feature/offline-collection-encryption
```

### Platform-Specific Development
```bash
# Create platform-specific branch if needed
git checkout -b platform/ios-keychain-integration

# Make platform-specific changes
git add src/platforms/ios/
git commit -m "platform(ios): add Keychain integration for secure key storage"

# Test on specific platform
npm run ios
npm run test:ios

# Push platform branch
git push -u origin platform/ios-keychain-integration
```

### Multi-Platform Feature Development
```bash
# Work on core functionality first
git add src/core/
git commit -m "feat(core): add collection sharing logic"

# Add platform-specific implementations
git add src/platforms/ios/
git commit -m "platform(ios): implement iOS-specific sharing UI"

git add src/platforms/android/
git commit -m "platform(android): implement Android-specific sharing UI"

git add src/platforms/web/
git commit -m "platform(web): implement web sharing with Web Share API"

# Keep branch updated with develop
git checkout develop
git pull origin develop
git checkout feature/collection-sharing
git rebase develop

# Push updates
git push origin feature/collection-sharing --force-with-lease
```

### Sync and Conflict Resolution Development
```bash
# Create sync-specific branch
git checkout -b sync/advanced-conflict-resolution

# Implement sync logic
git add src/services/cloud/
git commit -m "sync(cloud): implement three-way merge for conflict resolution"

# Add tests for sync scenarios
git add __tests__/sync/
git commit -m "test(sync): add comprehensive conflict resolution tests"

# Test offline scenarios
git add src/services/offline/
git commit -m "offline(services): improve offline queue with retry logic"
```

### Creating Pull Request
```bash
# Ensure branch is ready and tested on all platforms
git checkout feature/offline-collection-encryption
git rebase develop
npm run test
npm run test:e2e
npm run build:all-platforms

# Push final changes
git push origin feature/offline-collection-encryption

# Create PR with comprehensive template
gh pr create \
  --title "feat(crypto): implement AES-256 encryption for offline collections" \
  --body "Implements client-side encryption for collection data with secure key derivation. Tested on all platforms. Closes #123" \
  --base develop \
  --head feature/offline-collection-encryption \
  --reviewer @security-team,@mobile-team
```

### Hotfix Process for Cross-Platform
```bash
# Create hotfix from main
git checkout main
git pull origin main
git checkout -b hotfix/sync-data-corruption

# Make critical fix
git add src/services/sync/
git commit -m "fix(sync): prevent data corruption during simultaneous sync"

# Test on all critical platforms
npm run test
npm run build:web
npm run build:android
npm run build:ios

# Create PR to main
gh pr create \
  --title "hotfix(sync): prevent data corruption during sync" \
  --body "Critical fix for sync data corruption. Affects all platforms. Resolves #789" \
  --base main \
  --head hotfix/sync-data-corruption \
  --reviewer @lead-developer

# After merge, back-merge to develop
git checkout develop
git merge main
git push origin develop
```

## Release Process

### Preparing Cross-Platform Release
```bash
# Create release branch from develop
git checkout develop
git pull origin develop
git checkout -b release/v2.1.0

# Update version numbers across platforms
npm version minor  # Updates package.json
# Update iOS version in ios/ProjectName/Info.plist
# Update Android version in android/app/build.gradle
# Update Electron version in electron/package.json

# Update changelog
git add CHANGELOG.md
git commit -m "chore(release): update changelog for v2.1.0"

# Final testing on all platforms
npm run test:all-platforms
npm run build:all-platforms
npm run test:e2e:all-platforms

# Commit version updates
git add .
git commit -m "chore(release): bump version to 2.1.0"
git push -u origin release/v2.1.0
```

### Platform-Specific Release Notes
```bash
# Create release notes with platform-specific information
git add docs/RELEASE_NOTES_v2.1.0.md
git commit -m "docs(release): add comprehensive release notes for v2.1.0"

# Include:
# - New features by platform
# - Bug fixes and improvements
# - Security updates
# - Performance improvements
# - Breaking changes and migration guide
# - Known issues by platform
```

### Finalizing Release
```bash
# Merge to main
git checkout main
git merge release/v2.1.0

# Create release tag with platform info
git tag -a v2.1.0 -m "Release version 2.1.0

Platforms supported:
- Web (React Native Web)
- iOS (React Native iOS)
- Android (React Native Android)  
- Windows (Electron)
- macOS (Electron)

Major features:
- Enhanced offline encryption
- Improved sync performance
- New biometric authentication
- Better conflict resolution"

git push origin main --tags

# Merge back to develop
git checkout develop
git merge main
git push origin develop

# Delete release branch
git branch -d release/v2.1.0
git push origin --delete release/v2.1.0
```

## Platform-Specific Git Hooks

### Pre-commit Hook for Cross-Platform
```bash
#!/bin/sh
# Cross-platform pre-commit hook

echo "Running cross-platform pre-commit checks..."

# Run TypeScript type checking
echo "🔍 Type checking..."
npm run type-check
if [ $? -ne 0 ]; then
  echo "❌ TypeScript errors found. Commit aborted."
  exit 1
fi

# Run linting
echo "🔍 Linting..."
npm run lint
if [ $? -ne 0 ]; then
  echo "❌ Linting errors found. Commit aborted."
  exit 1
fi

# Run unit tests
echo "🧪 Running unit tests..."
npm test -- --watchAll=false
if [ $? -ne 0 ]; then
  echo "❌ Tests failed. Commit aborted."
  exit 1
fi

# Check for platform-specific code in shared directories
echo "🔍 Checking for platform-specific code in shared directories..."
if grep -r "Platform\.OS" src/core/ src/components/ --exclude-dir=platforms; then
  echo "❌ Platform-specific code found in shared directories. Move to src/platforms/"
  exit 1
fi

# Check for hardcoded secrets
echo "🔍 Checking for hardcoded secrets..."
if grep -r "API_KEY\|SECRET\|PASSWORD" src/ --exclude-dir=__tests__ --exclude="*.md"; then
  echo "❌ Potential hardcoded secrets found. Use environment variables."
  exit 1
fi

echo "✅ All pre-commit checks passed!"
```

### Commit Message Validation
```bash
#!/bin/sh
# Validate commit message format for cross-platform projects

commit_regex='^(feat|fix|security|perf|platform|sync|ui|db|crypto|offline|docs|style|refactor|test|chore|ci)(\(.+\))?: .{1,72}'

if ! grep -qE "$commit_regex" "$1"; then
  echo "❌ Invalid commit message format!"
  echo "Use: <type>(<scope>): <description>"
  echo ""
  echo "Types: feat, fix, security, perf, platform, sync, ui, db, crypto, offline, docs, style, refactor, test, chore, ci"
  echo "Scopes: core, services, components, screens, auth, sync, encryption, database, cloud, electron, ios, android, web, windows, macos"
  echo ""
  echo "Examples:"
  echo "  feat(sync): add Dropbox integration"
  echo "  fix(encryption): resolve key derivation issue"
  echo "  platform(ios): add biometric authentication"
  exit 1
fi
```

## Issue Linking and Automation

### Automatic Issue Management
```bash
# Use these keywords in commit messages or PR descriptions:
# - closes #123, fixes #123, resolves #123 - Closes the issue
# - relates to #123, references #123, see #123 - Links but doesn't close

# Examples:
git commit -m "feat(sync): implement conflict resolution (closes #123, relates to #124)"
git commit -m "fix(encryption): resolve memory leak on iOS (fixes #456)"
```

### Branch to Issue Workflow
```bash
# Create branch from issue
gh issue develop 123 --checkout

# Or manually with issue reference
git checkout -b feature/123-offline-encryption

# All commits in this branch automatically link to issue #123
git commit -m "feat(crypto): add encryption service"
git commit -m "test(crypto): add encryption tests"

# PR automatically references issue
gh pr create --title "feat: offline encryption implementation" --body "Closes #123"
```

## Multi-Platform CI/CD Integration

### Platform-Specific Workflows
```bash
# Trigger builds for affected platforms only
# Use GitHub Actions path filters:

# .github/workflows/ios.yml - triggers on ios/ changes
# .github/workflows/android.yml - triggers on android/ changes  
# .github/workflows/electron.yml - triggers on electron/ changes
# .github/workflows/web.yml - triggers on web-specific changes

# Smart commit messages can trigger specific platform builds:
git commit -m "platform(ios): add biometric auth [build:ios]"
git commit -m "feat(core): add encryption [build:all]"
git commit -m "fix(web): resolve routing issue [build:web]"
```

### Cross-Platform Testing Strategy
```bash
# Test matrix for different platforms and scenarios
# - Unit tests run on all commits
# - Integration tests run on PR
# - E2E tests run on platform-specific changes
# - Performance tests run on release branches

# Platform-specific test commands
npm run test:ios          # iOS-specific tests
npm run test:android      # Android-specific tests
npm run test:electron     # Electron-specific tests
npm run test:web          # Web-specific tests
npm run test:cross        # Cross-platform compatibility tests
```

## Security-Focused Git Practices

### Sensitive Data Protection
```bash
# Never commit sensitive data - use git-secrets or similar
git secrets --install
git secrets --register-aws

# Check for secrets before commit
git secrets --scan

# Common patterns to avoid:
# - API keys in source code
# - Private keys or certificates
# - Database connection strings
# - OAuth client secrets
# - Encryption keys or passwords
```

### Secure Branch Protection
```bash
# Set up branch protection rules via GitHub CLI
gh api repos/{owner}/{repo}/branches/main/protection \
  --method PUT \
  --field required_status_checks='{"strict":true,"contexts":["ci/build","ci/test","ci/security-scan"]}' \
  --field enforce_admins=true \
  --field required_pull_request_reviews='{"required_approving_review_count":2,"require_code_owner_reviews":true}' \
  --field restrictions='{"users":[],"teams":["security-team"]}'
```

## Performance Monitoring in Git Workflow

### Performance Regression Detection
```bash
# Add performance tests to pre-push hook
echo "🚀 Running performance tests..."
npm run test:performance

# Compare bundle sizes
npm run bundle-analyzer
npm run size-check

# Memory leak detection
npm run test:memory-leaks

# Database performance tests
npm run test:database-performance
```

### Performance Tracking
```bash
# Track performance metrics in commit messages
git commit -m "perf(database): optimize queries - 40% faster sync"
git commit -m "perf(ui): reduce bundle size by 150KB with lazy loading"
git commit -m "perf(memory): fix memory leak in collection rendering"
```

## Documentation in Git Workflow

### Architecture Decision Records (ADRs)
```bash
# Create ADR for significant architectural decisions
git add docs/adr/ADR-001-offline-first-architecture.md
git commit -m "docs(adr): document offline-first architecture decision"

git add docs/adr/ADR-002-end-to-end-encryption.md
git commit -m "docs(adr): document E2E encryption implementation"
```

### API Documentation Updates
```bash
# Update API docs with code changes
git add docs/api/
git commit -m "docs(api): update sync API documentation"

# Update README for new platform support
git add README.md
git commit -m "docs(readme): add Windows setup instructions"
```

## Emergency Response Procedures

### Critical Security Issues
```bash
# For critical security vulnerabilities:
# 1. Create private security advisory first
gh api repos/{owner}/{repo}/security-advisories \
  --method POST \
  --field summary="Critical encryption vulnerability" \
  --field description="Private advisory for security issue"

# 2. Create private branch for fix
git checkout -b security/critical-encryption-fix

# 3. Implement fix with minimal public exposure
git commit -m "security: fix critical vulnerability (private)"

# 4. Create private PR for security team review
gh pr create --title "Security Fix" --body "Private security fix" --draft
```

### Production Hotfixes
```bash
# Emergency production fix process
git checkout main
git pull origin main
git checkout -b hotfix/production-sync-failure

# Implement minimal fix
git commit -m "hotfix(sync): resolve production sync failures"

# Fast-track review process
gh pr create \
  --title "HOTFIX: Production sync failure" \
  --body "Emergency fix for production issue. Minimal change to resolve sync failures." \
  --label "hotfix,urgent,production" \
  --reviewer @on-call-team

# After merge, immediately deploy and monitor
```

## Cross-Platform Release Coordination

### Coordinated Multi-Platform Releases
```bash
# Coordinate releases across app stores and platforms
git tag -a v2.1.0-web -m "Web release v2.1.0"
git tag -a v2.1.0-ios -m "iOS App Store release v2.1.0"  
git tag -a v2.1.0-android -m "Google Play Store release v2.1.0"
git tag -a v2.1.0-desktop -m "Desktop (Electron) release v2.1.0"

# Push all release tags
git push origin --tags
```

### Platform-Specific Release Branches
```bash
# Create platform-specific release branches if needed
git checkout -b release/v2.1.0-ios
git checkout -b release/v2.1.0-android
git checkout -b release/v2.1.0-desktop

# Apply platform-specific fixes
git checkout release/v2.1.0-ios
# Apply iOS-specific fixes
git commit -m "platform(ios): fix App Store submission issue"

git checkout release/v2.1.0-android
# Apply Android-specific fixes  
git commit -m "platform(android): fix Google Play policy compliance"
```

## Collaboration Guidelines

### Cross-Platform Team Coordination
```bash
# Use consistent branch naming for team coordination
feature/{team-name}/{feature-name}
# Examples:
feature/mobile-team/biometric-auth
feature/desktop-team/file-system-access
feature/sync-team/conflict-resolution
```

### Code Ownership and Reviews
```bash
# Use CODEOWNERS file for automatic review assignment
# .github/CODEOWNERS
src/platforms/ios/           @ios-team
src/platforms/android/       @android-team  
src/platforms/electron/      @desktop-team
src/platforms/web/           @web-team
src/core/                    @architecture-team
src/services/sync/           @sync-team
src/services/encryption/     @security-team
```

### Communication in Commits
```bash
# Include relevant team mentions in commit messages
git commit -m "feat(ios): add biometric auth

Implements Touch ID and Face ID authentication for iOS.
Tested on iOS 14+ devices.

@ios-team please review the Keychain integration
@security-team please verify the key storage implementation"
```

Remember: Cross-platform development requires careful coordination between different platforms and teams. Use Git workflow to maintain consistency while allowing platform-specific customizations when necessary.