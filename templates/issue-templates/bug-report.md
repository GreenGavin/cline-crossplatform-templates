---
name: Bug Report
about: Report a bug in the cross-platform application
title: 'Bug: [Brief Description]'
labels: bug, needs-triage
assignees: ''
---

## Bug Description
Clear and concise description of the bug.

## Affected Platforms
Select all platforms where this bug occurs:
- [ ] **Web** (React Native Web)
- [ ] **iOS** (React Native iOS)
- [ ] **Android** (React Native Android)
- [ ] **Windows** (Electron/React Native Windows)
- [ ] **macOS** (Electron/React Native macOS)

## Platform Versions
**Web:**
- Browser: [e.g., Chrome 120, Safari 17, Firefox 118]
- OS: [e.g., Windows 11, macOS Sonoma, Ubuntu 22.04]

**iOS:**
- iOS Version: [e.g., iOS 17.1]
- Device: [e.g., iPhone 15 Pro, iPad Air]
- React Native iOS Version: [e.g., 0.73.2]

**Android:**
- Android Version: [e.g., Android 14]
- Device: [e.g., Pixel 8, Samsung Galaxy S23]
- React Native Android Version: [e.g., 0.73.2]

**Desktop:**
- OS: [e.g., Windows 11, macOS Sonoma]
- Electron Version: [e.g., 27.1.3]
- Node.js Version: [e.g., 18.17.1]

## Application Environment
- **App Version**: [e.g., 2.1.0]
- **Build Type**: [Debug/Release]
- **Network Status**: [Online/Offline/Limited connectivity]
- **Sync Status**: [Synced/Pending/Conflict/Error]
- **Authentication**: [Logged in/Guest/Multi-user]

## Steps to Reproduce
1. 
2. 
3. 
4. 

## Expected Behavior
What should happen.

## Actual Behavior
What actually happens.

## Frequency
- [ ] Always reproducible
- [ ] Intermittent (happens sometimes)
- [ ] Rare (happened once or twice)
- [ ] Only under specific conditions

## Data State
- [ ] Fresh installation
- [ ] Existing data
- [ ] Large dataset (>1000 items)
- [ ] Multiple users/collections
- [ ] Sync conflicts present

## Code/Configuration
```javascript
// Relevant code snippet or configuration
```

## Error Messages/Logs
```
Error logs here (redact sensitive information)
```

## Console Output
```
Console logs from browser/metro/electron (redact sensitive data)
```

## Screenshots/Videos
If applicable, add screenshots or screen recordings to help explain the problem.
- Please include screenshots from affected platforms
- Consider recording a video for complex reproduction steps

## Network/Sync Information
- **Cloud Provider**: [Dropbox/OneDrive/iCloud/Google Drive/Custom]
- **Sync Status**: [Working/Failed/Partial]
- **Network Conditions**: [WiFi/Cellular/Slow/Offline]
- **Conflict Resolution**: [Manual/Automatic/Failed]

## Performance Impact
- [ ] App crashes
- [ ] App becomes unresponsive
- [ ] Slow performance
- [ ] High memory usage
- [ ] High battery usage
- [ ] Network usage concerns
- [ ] No noticeable performance impact

## Security/Privacy Impact
- [ ] Data corruption
- [ ] Data loss
- [ ] Privacy leak
- [ ] Security vulnerability
- [ ] Encryption failure
- [ ] Authentication bypass
- [ ] No security implications

## Offline Behavior
- [ ] Bug occurs only when online
- [ ] Bug occurs only when offline
- [ ] Bug occurs during sync
- [ ] Bug affects offline data
- [ ] Bug prevents sync
- [ ] Not applicable

## Workaround
If you found a way to work around this issue, please describe it here.

## Additional Context
Any other context about the problem here.

## Possible Solution
If you have ideas on how to fix the bug, describe them here.

## Related Issues
- Similar to: #
- Blocks: #
- Blocked by: #

## Testing Checklist for Developers
- [ ] Bug reproduced on reported platform(s)
- [ ] Bug reproduced on other platforms
- [ ] Root cause identified
- [ ] Fix implemented
- [ ] Fix tested on all affected platforms
- [ ] Fix tested in offline mode
- [ ] Fix tested with sync conflicts
- [ ] Regression tests added
- [ ] Performance impact assessed
- [ ] Security implications reviewed

## Acceptance Criteria
- [ ] Bug no longer occurs on affected platforms
- [ ] No regression introduced on other platforms
- [ ] Offline functionality works correctly
- [ ] Sync functionality works correctly
- [ ] Performance remains acceptable
- [ ] Security/privacy maintained
- [ ] User data integrity preserved