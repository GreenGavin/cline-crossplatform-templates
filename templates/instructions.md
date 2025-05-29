# [Project Name] - Cross-Platform Development Instructions

## Architecture Principles

### Core Design Philosophy
- **Offline-First**: All functionality must work without internet connection
- **Cross-Platform Unity**: Single codebase with platform-specific adaptations only when necessary
- **Security by Design**: End-to-end encryption and zero-knowledge architecture
- **Performance-Critical**: Optimized for each platform's capabilities
- **Family-Friendly**: Multi-user support with granular permissions
- **Privacy-First**: User data protection built into every feature

### Single Source Architecture
- **Core Logic**: All business logic in `src/core/` - platform agnostic
- **Shared Services**: Database, cloud sync, and utilities in `src/services/`
- **Platform Adaptation**: Platform-specific code isolated in `src/platforms/`
- **Component Library**: Reusable UI components in `src/components/`
- **Runtime Separation**: Keep Electron Node.js runtime separate from React source
- **Dependency Injection**: Use DI patterns for testability and modularity

## Tech Stack

### Primary Technologies
- **Framework**: React Native with React Native Web
- **Language**: TypeScript (strict mode throughout)
- **Database**: PouchDB (offline-first with CouchDB/cloud sync)
- **Navigation**: React Navigation v6+
- **State Management**: React Context API + custom hooks (avoid Redux complexity)
- **Desktop Runtime**: Electron (isolated in `electron/` directory)
- **Testing**: Jest + React Native Testing Library

### Platform Targets
- **Web**: React Native Web + Webpack
- **Windows**: React Native Windows + Electron fallback
- **macOS**: React Native macOS + Electron fallback
- **iOS**: React Native iOS
- **Android**: React Native Android

### Cloud Integration (Zero-Knowledge)
- **Dropbox**: Primary sync provider with client-side encryption
- **OneDrive**: Microsoft ecosystem integration
- **iCloud**: Apple ecosystem integration
- **Google Drive**: Google ecosystem integration
- **Custom Server**: Optional self-hosted sync

## Code Standards

### File Organization
```
project-name/
├── src/                     # React/React Native source code
│   ├── core/                # Platform-agnostic business logic
│   │   ├── types.ts         # Core type definitions
│   │   ├── constants.ts     # App-wide constants
│   │   ├── utils.ts         # Utility functions
│   │   ├── database.ts      # Database abstractions
│   │   ├── models/          # Data models and validation
│   │   └── operations/      # Core business operations
│   ├── services/            # External service integrations
│   │   ├── database/        # PouchDB operations & service layer
│   │   ├── cloud/           # Cloud provider sync & integrations
│   │   ├── encryption/      # Crypto operations (AES, RSA, key management)
│   │   └── auth/            # Authentication logic
│   ├── components/          # Reusable UI components (shared)
│   ├── screens/             # Application screens/pages
│   ├── navigation/          # Navigation configuration
│   ├── hooks/               # Custom React hooks
│   ├── types/               # Shared TypeScript definitions
│   └── platforms/           # Platform-specific implementations
│       ├── web/             # React Native Web components
│       ├── native/          # Shared React Native functionality
│       ├── windows/         # Windows React Native components
│       ├── macos/           # macOS React Native components
│       ├── ios/             # iOS React Native components
│       └── android/         # Android React Native components
├── electron/                # Electron-specific files (Node.js runtime)
│   ├── main.js              # Main Electron process
│   ├── preload.js           # Secure IPC bridge
│   └── assets/              # Electron app icons, resources
├── config/                  # Build configurations
├── __tests__/               # Test files
├── docs/                    # Project documentation
└── .cline/                  # Cline context files
```

### TypeScript Guidelines
- **Strict Mode**: Always enabled with comprehensive strict configuration
- **Explicit Types**: Avoid `any`, prefer explicit interfaces and proper generics
- **Null Safety**: Use optional chaining and nullish coalescing operators
- **Generic Constraints**: Use bounded generics for enhanced type safety
- **Branded Types**: Use branded types for IDs and sensitive data
- **Error Types**: Implement proper error types and Result/Either patterns
- **Discriminated Unions**: Use for robust state management

### Naming Conventions
- **Files**: PascalCase for components, camelCase for utilities
- **Components**: PascalCase (e.g., `CollectionDetailScreen.tsx`)
- **Services**: PascalCase with Service suffix (e.g., `DatabaseService.ts`)
- **Types**: PascalCase interfaces, camelCase for type aliases
- **Constants**: SCREAMING_SNAKE_CASE
- **Hooks**: camelCase starting with 'use' (e.g., `useCloudSync`)

### Component Patterns
- **Functional Components**: Use hooks exclusively, avoid class components
- **Custom Hooks**: Extract reusable logic into well-tested custom hooks
- **Context Usage**: Use for global state management, avoid prop drilling
- **Error Boundaries**: Implement comprehensive error boundaries for critical UI sections
- **Accessibility**: Implement proper accessibility features in all components

## Security Requirements

### Data Protection
- **End-to-End Encryption**: All sensitive data encrypted before leaving device
- **Field-Level Encryption**: Implement granular encryption for sensitive fields
- **Zero-Knowledge Architecture**: Cloud providers cannot access decrypted user data
- **Key Management**: Secure key derivation (PBKDF2/Argon2) and storage
- **Data Sanitization**: Sanitize all user inputs with comprehensive validation
- **Secure Random**: Use cryptographically secure random number generation
- **Memory Management**: Secure deletion of sensitive data from memory

### Authentication & Authorization
- **OAuth 2.0/PKCE**: Implement standard flows for all cloud providers
- **Token Management**: Secure storage with automatic refresh and proper expiration
- **Session Security**: Proper session timeout, refresh, and secure logout
- **Multi-Factor Auth**: Support MFA where available on platforms
- **Biometric Integration**: Use platform biometric authentication capabilities
- **Granular Permissions**: Implement fine-grained family sharing permissions

### Network Security
- **Certificate Pinning**: Implement for all API communications
- **Request/Response Validation**: Validate all network data exchanges
- **CORS Configuration**: Proper cross-origin resource sharing setup
- **Rate Limiting**: Client-side rate limiting with exponential backoff
- **Secure Headers**: HSTS, CSP, and other security headers for web platform

### Platform-Specific Security
- **Electron**: Context isolation, secure IPC bridge, no Node.js in renderer
- **Web**: CSP headers, Web Crypto API, secure cookies, service worker security
- **Mobile**: Keychain/Keystore integration, secure deep links, app transport security
- **Desktop**: File system validation, secure credential storage

## Development Workflow

### Testing Strategy
- **Unit Tests**: All core business logic (`src/core/`) with >90% coverage
- **Integration Tests**: Service layer testing with mock cloud providers
- **Component Tests**: React Native Testing Library for UI components
- **End-to-End Tests**: Detox for mobile, Playwright for web
- **Security Tests**: Encryption validation, input sanitization, auth flows
- **Performance Tests**: Load testing, memory usage, battery impact
- **Offline Tests**: Comprehensive offline scenarios and sync conflict resolution

### Code Quality
- **ESLint + Prettier**: Consistent code formatting and style
- **TypeScript Strict**: Maximum type safety with strict configuration
- **Pre-commit Hooks**: Automated formatting, linting, and testing
- **Code Reviews**: Security-focused reviews with architectural considerations
- **Documentation**: Clear README, API docs, architectural decision records

### Performance Optimization
- **Database Optimization**: Strategic indexing and efficient PouchDB queries
- **UI Performance**: Virtual lists, lazy loading, optimized rendering
- **Bundle Optimization**: Code splitting and platform-specific optimizations
- **Intelligent Caching**: Multi-layer caching with proper invalidation strategies
- **Image Optimization**: Efficient image loading, caching, and format optimization
- **Delta Sync**: Incremental synchronization to minimize data transfer
- **Background Processing**: Non-blocking background operations
- **Memory Efficiency**: Proper resource cleanup and memory management

## Platform Implementation Guidelines

### Electron (Windows/macOS Desktop)
- **Process Isolation**: Maintain strict separation between main and renderer processes
- **Context Isolation**: Enable contextIsolation and disable node integration in renderer
- **Secure IPC**: Implement secure communication via `electron/preload.js` bridge only
- **File System Security**: Validate all file operations with proper permissions
- **Auto-Update Security**: Secure update mechanism with signature verification
- **Resource Management**: Efficient handling of system resources and cleanup

### React Native Web
- **Progressive Web App**: Implement PWA features for app-like experience
- **Service Workers**: Background sync and offline functionality
- **Web Crypto API**: Use browser-native cryptographic operations
- **Responsive Design**: Adapt UI for different screen sizes and devices
- **Browser Compatibility**: Ensure compatibility across modern browsers

### React Native Mobile (iOS/Android)
- **Platform Guidelines**: Follow iOS HIG and Material Design principles
- **Native Performance**: Use platform-specific optimizations when necessary
- **Background Sync**: Efficient background processing within platform limits
- **Deep Link Security**: Secure handling of deep links and URL schemes
- **Biometric Auth**: Integration with platform biometric systems
- **Push Notifications**: Secure and privacy-respecting notification system

## Cloud Sync Architecture

### Sync Strategy
- **Conflict Resolution**: Last-write-wins with user conflict resolution UI
- **Delta Sync**: Only sync changed data to minimize bandwidth
- **Offline-First**: Full functionality without internet connection
- **Multi-Device**: Seamless sync across all user devices
- **Family Sharing**: Secure sharing with granular permissions

### Provider Integration
- **Dropbox**: Primary sync with robust API and conflict handling
- **OneDrive**: Microsoft ecosystem integration with Office compatibility
- **iCloud**: Apple ecosystem integration with seamless iOS/macOS experience
- **Google Drive**: Google ecosystem integration with smart categorization
- **Custom Server**: Self-hosted option for privacy-conscious users

### Sync Security
- **Client-Side Encryption**: All data encrypted before upload
- **Key Exchange**: Secure multi-device key distribution
- **Audit Trail**: Track all sync operations for debugging
- **Rate Limiting**: Respect provider API limits with intelligent backoff

## Error Handling & Resilience

### Error Patterns
- **Result/Either Types**: Consistent error handling throughout application
- **Structured Errors**: Well-defined error types with context and recovery suggestions
- **User-Friendly Messages**: Clear, actionable error messages for users
- **Silent Failures**: Graceful degradation when non-critical operations fail
- **Retry Logic**: Intelligent retry with exponential backoff for network operations

### Offline Resilience
- **Queue Operations**: Queue sync operations when offline
- **Conflict Detection**: Detect and resolve data conflicts on reconnection
- **State Persistence**: Maintain application state across app restarts
- **Background Sync**: Sync when connectivity is restored

## Monitoring & Analytics

### Privacy-Respecting Analytics
- **No Personal Data**: Analytics must not include any personal information
- **Aggregate Metrics**: Usage patterns, performance metrics, error rates
- **Opt-In Only**: Users must explicitly consent to analytics
- **Local Storage**: Store analytics data locally with periodic uploads
- **Data Minimization**: Collect only essential metrics for app improvement

### Performance Monitoring
- **React Native Performance**: Monitor JS thread performance, memory usage
- **Database Performance**: Track query times, sync performance
- **Network Performance**: Monitor API response times, failure rates
- **User Experience**: Track app launch time, screen transition performance

## Development Commands

### Primary Commands
```bash
# Development
npm start              # Start Metro bundler
npm run web           # Start web development server
npm run android       # Run Android version
npm run ios           # Run iOS version
npm run windows       # Run Windows version
npm run macos         # Run macOS version
npm run electron      # Run Electron desktop version

# Building
npm run build:web     # Build web version
npm run build:android # Build Android APK/Bundle
npm run build:ios     # Build iOS IPA
npm run build:electron # Build Electron desktop apps

# Testing
npm test              # Run all tests
npm run test:watch    # Run tests in watch mode
npm run test:e2e      # Run end-to-end tests
npm run test:coverage # Generate coverage report

# Quality Assurance
npm run lint          # Run ESLint
npm run format        # Run Prettier
npm run type-check    # TypeScript type checking
npm run audit         # Security audit
```

### Platform-Specific Setup
```bash
# iOS setup
cd ios && pod install && cd ..
npx react-native run-ios

# Android setup
npx react-native run-android

# Electron setup
npm run electron:install
npm run electron:dev
```

## Continuous Integration

### CI/CD Pipeline
- **Automated Testing**: Run all test suites on every commit
- **Code Quality**: ESLint, Prettier, TypeScript checks
- **Security Scanning**: Dependency vulnerability checks
- **Build Verification**: Ensure builds succeed for all platforms
- **Performance Testing**: Automated performance regression testing

### Deployment Strategy
- **Staging Environment**: Deploy to staging for testing
- **Gradual Rollout**: Progressive deployment to production
- **Rollback Capability**: Ability to quickly rollback problematic releases
- **Platform-Specific**: Different deployment strategies for each platform

## Best Practices Summary

### Code Organization
- Keep business logic platform-agnostic in `src/core/`
- Isolate platform-specific code in `src/platforms/`
- Use services for external integrations
- Implement proper separation of concerns

### Security First
- Encrypt all sensitive data client-side
- Use secure authentication flows
- Validate all inputs and sanitize outputs
- Implement proper key management
- Regular security audits and updates

### Performance & UX
- Optimize for offline-first experience
- Implement efficient caching strategies
- Use lazy loading and code splitting
- Monitor and optimize performance metrics
- Ensure smooth animations and transitions

### Maintainability
- Write comprehensive tests
- Document architectural decisions
- Use consistent coding standards
- Regular dependency updates
- Clear error messages and logging

Remember: This is a complex, multi-platform architecture. Prioritize getting core functionality working on one platform before expanding to others. Security and offline functionality should be built in from the beginning, not added later.