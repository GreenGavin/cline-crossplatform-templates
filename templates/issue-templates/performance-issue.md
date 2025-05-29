---
name: Performance Issue
about: Report a performance problem in the cross-platform application
title: 'Performance: [Brief Description]'
labels: performance, needs-investigation
assignees: ''
---

## Performance Issue Summary
Brief description of the performance problem you're experiencing.

## Affected Platforms
Select all platforms where this performance issue occurs:
- [ ] **Web** (React Native Web)
- [ ] **iOS** (React Native iOS)
- [ ] **Android** (React Native Android)
- [ ] **Windows** (Electron/React Native Windows)
- [ ] **macOS** (Electron/React Native macOS)

## Performance Issue Type
Select the primary performance problem:
- [ ] **App Launch**: Slow app startup/initialization
- [ ] **UI Responsiveness**: Laggy or unresponsive user interface
- [ ] **Memory Usage**: High memory consumption or memory leaks
- [ ] **CPU Usage**: High CPU usage or excessive processing
- [ ] **Battery Drain**: Excessive battery consumption (mobile)
- [ ] **Network Performance**: Slow network requests or sync
- [ ] **Database Performance**: Slow database queries or operations
- [ ] **Rendering Performance**: Slow screen transitions or animations
- [ ] **Background Performance**: Issues with background processing
- [ ] **Sync Performance**: Slow cloud synchronization
- [ ] **Large Dataset**: Performance degrades with large amounts of data

## Device/System Information

### Web Platform
- **Browser**: [e.g., Chrome 120, Safari 17, Firefox 118]
- **OS**: [e.g., Windows 11, macOS Sonoma, Ubuntu 22.04]
- **RAM**: [e.g., 16GB]
- **CPU**: [e.g., Intel i7, M1 Pro, AMD Ryzen 7]
- **Connection**: [e.g., WiFi, Ethernet, 4G]

### iOS Platform
- **Device**: [e.g., iPhone 15 Pro, iPad Air 5th gen]
- **iOS Version**: [e.g., iOS 17.1]
- **Storage Available**: [e.g., 128GB available out of 256GB]
- **RAM**: [Device-specific, e.g., 8GB for iPhone 15 Pro]
- **Connection**: [e.g., WiFi, 5G, LTE]

### Android Platform
- **Device**: [e.g., Pixel 8, Samsung Galaxy S23]
- **Android Version**: [e.g., Android 14]
- **RAM**: [e.g., 8GB]
- **Storage Available**: [e.g., 64GB available out of 128GB]
- **Connection**: [e.g., WiFi, 5G, LTE]

### Desktop Platform
- **OS**: [e.g., Windows 11, macOS Sonoma 14.1]
- **RAM**: [e.g., 16GB DDR4]
- **CPU**: [e.g., Intel i7-12700K, Apple M2]
- **Storage**: [e.g., 512GB SSD with 200GB available]
- **Connection**: [e.g., Gigabit Ethernet, WiFi 6]

## Application Context
- **App Version**: [e.g., 2.1.0]
- **Build Type**: [Debug/Release]
- **Data Volume**: [e.g., 500 collections, 10,000 items total]
- **User Account**: [Single user/Family account with X users]
- **Cloud Sync**: [Enabled with Dropbox/OneDrive/etc., or Disabled]
- **Offline Mode**: [Frequently offline/Always online/Mixed usage]

## Performance Measurements

### Quantitative Data (if available)
- **Time to Launch**: [e.g., 8 seconds from tap to usable]
- **Memory Usage**: [e.g., 250MB RAM usage]
- **CPU Usage**: [e.g., 80% CPU during sync]
- **Network Usage**: [e.g., 50MB data transfer for 100 items]
- **Battery Impact**: [e.g., 15% battery drain in 1 hour]
- **Frame Rate**: [e.g., 30fps instead of 60fps during animations]
- **Response Time**: [e.g., 3 seconds to load collection list]

### Performance Tools Used
- [ ] **Browser DevTools** (Performance tab, Network tab)
- [ ] **React DevTools Profiler**
- [ ] **Flipper** (React Native debugging)
- [ ] **Xcode Instruments** (iOS profiling)
- [ ] **Android Studio Profiler**
- [ ] **Electron DevTools**
- [ ] **Third-party monitoring** (specify tool)
- [ ] **Manual timing** (stopwatch measurements)

## Steps to Reproduce Performance Issue
1. 
2. 
3. 
4. 

## Expected Performance
Describe what performance you expect (e.g., "App should launch in under 3 seconds", "UI should be responsive during sync").

## Actual Performance
Describe the actual performance you're experiencing.

## Performance Comparison
- **Worked better in version**: [e.g., v2.0.0 was faster]
- **Comparison with competitors**: [e.g., Similar apps load in 2 seconds]
- **Device comparison**: [e.g., Works fine on newer devices]
- **Platform comparison**: [e.g., iOS version is faster than Android]

## Data Set Size Impact
- **Small Dataset** (< 100 items): [Performance with small data]
- **Medium Dataset** (100-1000 items): [Performance with medium data]
- **Large Dataset** (1000+ items): [Performance with large data]
- **Specific Problematic Size**: [e.g., Performance degrades after 500 collections]

## Network Conditions Impact
- **Fast WiFi** (>50 Mbps): [Performance on fast connection]
- **Slow WiFi** (<5 Mbps): [Performance on slow connection]
- **Mobile Data**: [Performance on cellular]
- **Offline Mode**: [Performance when completely offline]
- **Intermittent Connection**: [Performance with unstable connection]

## User Impact Assessment
- [ ] **Critical**: App is unusable
- [ ] **High**: Significantly impacts productivity
- [ ] **Medium**: Noticeable but workable
- [ ] **Low**: Minor annoyance

## Frequency
- [ ] **Always**: Occurs every time
- [ ] **Usually**: Occurs most of the time (>75%)
- [ ] **Sometimes**: Occurs occasionally (25-75%)
- [ ] **Rarely**: Occurs infrequently (<25%)

## Performance Logs/Screenshots

### Performance Profiles
[Attach performance profiles from browser DevTools, Instruments, etc.]

### Screenshots
[Include screenshots of performance monitoring tools, memory usage, CPU usage, etc.]

### Log Output
```
Performance-related log entries (with sensitive data removed)
```

### Error Messages
```
Any error messages related to performance issues
```

## Potential Root Causes
If you have insights into what might be causing the performance issue:
- [ ] **Memory leaks** in specific components
- [ ] **Inefficient database queries**
- [ ] **Too many re-renders** in React components
- [ ] **Large bundle size** affecting load time
- [ ] **Unoptimized images** or assets
- [ ] **Inefficient sync algorithm**
- [ ] **Blocking operations** on main thread
- [ ] **Inefficient list rendering** (not using virtualization)
- [ ] **Too many network requests**
- [ ] **Heavy computations** not optimized

## Workarounds Found
If you've found ways to work around the performance issue:

## Performance Regression
- **Previously worked better**: [Describe when performance was better]
- **Suspected cause**: [Changes that might have caused regression]
- **First noticed in version**: [When the issue first appeared]

## Additional Context
Any other context about the performance issue, including:
- Usage patterns that trigger the issue
- Time of day when issue is worse/better
- Other apps running simultaneously
- System load during the issue

## Suggested Improvements
If you have ideas for performance improvements:

## Related Issues
- **Similar performance issues**: #
- **Related bugs**: #
- **Blocked by**: #

## Development Investigation Checklist
For developers investigating this issue:

### Analysis
- [ ] Performance issue reproduced on reported platform(s)
- [ ] Performance profiling completed
- [ ] Memory usage analyzed
- [ ] CPU usage analyzed
- [ ] Network performance analyzed
- [ ] Database performance analyzed
- [ ] Root cause identified

### Testing
- [ ] Performance benchmarks created
- [ ] Regression tests added
- [ ] Cross-platform performance compared
- [ ] Different dataset sizes tested
- [ ] Various network conditions tested

### Resolution
- [ ] Performance optimization implemented
- [ ] Performance improvement measured and documented
- [ ] No performance regression on other platforms
- [ ] Memory usage optimized
- [ ] Battery impact minimized (mobile platforms)
- [ ] User experience improved

## Acceptance Criteria for Resolution
- [ ] Performance meets or exceeds expected benchmarks
- [ ] No performance regression introduced
- [ ] Improvement is consistent across affected platforms
- [ ] Memory usage is within acceptable limits
- [ ] CPU usage is optimized
- [ ] Battery impact is minimized (mobile)
- [ ] User experience is significantly improved