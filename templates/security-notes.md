# Security Implementation Guidelines for Cross-Platform Projects

## Core Security Principles

### Zero-Knowledge Architecture
- **Service providers cannot access user data**: All data encrypted client-side before upload
- **No plaintext data in cloud**: Only encrypted blobs stored remotely
- **User owns encryption keys**: Keys derived from user password, never stored on servers
- **Privacy by design**: Minimize data collection and maximize user control

### End-to-End Encryption Standards
- **Algorithm**: AES-256-GCM for symmetric encryption
- **Key Derivation**: PBKDF2 (100,000+ iterations) or Argon2id
- **Key Exchange**: Secure multi-device key distribution
- **Perfect Forward Secrecy**: Regular key rotation for long-term security

## Platform-Specific Security Implementation

### React Native (iOS/Android)

#### Secure Storage
```javascript
// iOS: Use Keychain Services
import { Keychain } from 'react-native-keychain';

const storeSecureData = async (key, value) => {
  await Keychain.setInternetCredentials(key, 'user', value, {
    accessControl: Keychain.ACCESS_CONTROL.BIOMETRY_CURRENT_SET,
    authenticatePrompt: 'Please authenticate to access your data',
    service: 'MyAppSecureStorage',
  });
};

// Android: Use Android Keystore
import EncryptedStorage from 'react-native-encrypted-storage';

const storeSecureData = async (key, value) => {
  await EncryptedStorage.setItem(key, value);
};
```

#### Biometric Authentication
```javascript
import TouchID from 'react-native-touch-id';

const authenticateUser = async () => {
  const optionalConfigObject = {
    title: 'Authentication Required',
    imageColor: '#e00606',
    imageErrorColor: '#ff0000',
    sensorDescription: 'Touch sensor',
    sensorErrorDescription: 'Failed',
    cancelText: 'Cancel',
    fallbackLabel: 'Show Passcode',
    unifiedErrors: false,
    passcodeFallback: false,
  };

  try {
    const biometryType = await TouchID.isSupported(optionalConfigObject);
    if (biometryType) {
      const isAuthenticated = await TouchID.authenticate('Access your secure data', optionalConfigObject);
      return isAuthenticated;
    }
  } catch (error) {
    console.error('Biometric authentication failed:', error);
  }
  return false;
};
```

#### App Transport Security (iOS)
```xml
<!-- ios/YourApp/Info.plist -->
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <false/>
  <key>NSExceptionDomains</key>
  <dict>
    <key>your-api-domain.com</key>
    <dict>
      <key>NSExceptionRequiresForwardSecrecy</key>
      <false/>
      <key>NSExceptionMinimumTLSVersion</key>
      <string>TLSv1.2</string>
      <key>NSIncludesSubdomains</key>
      <true/>
    </dict>
  </dict>
</dict>
```

#### Network Security Config (Android)
```xml
<!-- android/app/src/main/res/xml/network_security_config.xml -->
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
  <domain-config cleartextTrafficPermitted="false">
    <domain includeSubdomains="true">your-api-domain.com</domain>
    <pin-set expiration="2025-12-31">
      <pin digest="SHA-256">your-certificate-pin</pin>
      <pin digest="SHA-256">backup-certificate-pin</pin>
    </pin-set>
  </domain-config>
</network-security-config>
```

### Electron Desktop Security

#### Context Isolation and Security
```javascript
// electron/main.js
const { app, BrowserWindow } = require('electron');
const path = require('path');

const createWindow = () => {
  const mainWindow = new BrowserWindow({
    width: 1200,
    height: 800,
    webPreferences: {
      nodeIntegration: false,           // Disable Node.js in renderer
      contextIsolation: true,           // Enable context isolation
      enableRemoteModule: false,        // Disable remote module
      preload: path.join(__dirname, 'preload.js'),
      sandbox: true,                    // Enable sandbox mode
      webSecurity: true,                // Enable web security
    },
  });

  // Content Security Policy
  mainWindow.webContents.session.webRequest.onHeadersReceived((details, callback) => {
    callback({
      responseHeaders: {
        ...details.responseHeaders,
        'Content-Security-Policy': [
          "default-src 'self'; " +
          "script-src 'self' 'unsafe-inline'; " +
          "style-src 'self' 'unsafe-inline'; " +
          "img-src 'self' data: https:; " +
          "connect-src 'self' https://your-api-domain.com;"
        ]
      }
    });
  });
};
```

#### Secure IPC Communication
```javascript
// electron/preload.js
const { contextBridge, ipcRenderer } = require('electron');

// Expose secure API to renderer process
contextBridge.exposeInMainWorld('electronAPI', {
  // File operations
  readFile: (filePath) => ipcRenderer.invoke('file:read', filePath),
  writeFile: (filePath, data) => ipcRenderer.invoke('file:write', filePath, data),
  
  // Secure storage
  getSecureData: (key) => ipcRenderer.invoke('secure:get', key),
  setSecureData: (key, value) => ipcRenderer.invoke('secure:set', key, value),
  
  // System integration
  showNotification: (title, body) => ipcRenderer.invoke('notification:show', title, body),
});

// Validate all IPC messages
ipcRenderer.on('message', (event, ...args) => {
  // Validate message structure and content
  if (validateMessage(args)) {
    handleMessage(args);
  }
});
```

### React Native Web Security

#### Content Security Policy
```javascript
// Configure CSP headers for web deployment
const cspDirectives = {
  'default-src': ["'self'"],
  'script-src': ["'self'", "'unsafe-inline'", 'https://trusted-cdn.com'],
  'style-src': ["'self'", "'unsafe-inline'", 'https://fonts.googleapis.com'],
  'font-src': ["'self'", 'https://fonts.gstatic.com'],
  'img-src': ["'self'", 'data:', 'https:'],
  'connect-src': ["'self'", 'https://your-api-domain.com'],
  'media-src': ["'self'"],
  'object-src': ["'none'"],
  'base-uri': ["'self'"],
  'form-action': ["'self'"],
  'frame-ancestors': ["'none'"],
  'upgrade-insecure-requests': []
};

const cspString = Object.entries(cspDirectives)
  .map(([directive, sources]) => `${directive} ${sources.join(' ')}`)
  .join('; ');

// Apply CSP header
response.setHeader('Content-Security-Policy', cspString);
```

#### Service Worker Security
```javascript
// sw.js - Secure service worker implementation
const CACHE_NAME = 'secure-app-v1';
const ALLOWED_ORIGINS = ['https://your-domain.com'];

self.addEventListener('fetch', (event) => {
  // Validate request origin
  const requestUrl = new URL(event.request.url);
  if (!ALLOWED_ORIGINS.includes(requestUrl.origin)) {
    return;
  }

  // Handle secure caching
  event.respondWith(
    caches.match(event.request).then((response) => {
      if (response) {
        return response;
      }
      
      return fetch(event.request).then((response) => {
        // Only cache secure responses
        if (response.status === 200 && response.type === 'basic') {
          const responseToCache = response.clone();
          caches.open(CACHE_NAME).then((cache) => {
            cache.put(event.request, responseToCache);
          });
        }
        return response;
      });
    })
  );
});
```

## Data Encryption Implementation

### Client-Side Encryption Service
```javascript
import CryptoJS from 'crypto-js';
import { PBKDF2 } from 'crypto-js';

class EncryptionService {
  constructor() {
    this.algorithm = 'AES';
    this.keySize = 256;
    this.iterationCount = 100000;
  }

  // Derive encryption key from password
  deriveKey(password, salt) {
    return PBKDF2(password, salt, {
      keySize: this.keySize / 32,
      iterations: this.iterationCount
    });
  }

  // Generate secure random salt
  generateSalt() {
    return CryptoJS.lib.WordArray.random(256 / 8);
  }

  // Encrypt data with AES-256-GCM
  encrypt(data, password, salt = null) {
    if (!salt) {
      salt = this.generateSalt();
    }
    
    const key = this.deriveKey(password, salt);
    const iv = CryptoJS.lib.WordArray.random(128 / 8);
    
    const encrypted = CryptoJS.AES.encrypt(JSON.stringify(data), key, {
      iv: iv,
      mode: CryptoJS.mode.GCM,
      padding: CryptoJS.pad.NoPadding
    });

    return {
      encrypted: encrypted.toString(),
      salt: salt.toString(),
      iv: iv.toString()
    };
  }

  // Decrypt data
  decrypt(encryptedData, password) {
    const { encrypted, salt, iv } = encryptedData;
    const key = this.deriveKey(password, CryptoJS.enc.Hex.parse(salt));
    
    const decrypted = CryptoJS.AES.decrypt(encrypted, key, {
      iv: CryptoJS.enc.Hex.parse(iv),
      mode: CryptoJS.mode.GCM,
      padding: CryptoJS.pad.NoPadding
    });

    return JSON.parse(decrypted.toString(CryptoJS.enc.Utf8));
  }

  // Secure key storage using platform-specific secure storage
  async storeKey(keyId, keyData) {
    // Platform-specific implementation
    if (Platform.OS === 'ios' || Platform.OS === 'android') {
      // Use react-native-keychain or encrypted storage
      await Keychain.setInternetCredentials(keyId, 'user', keyData);
    } else if (isElectron()) {
      // Use Electron's safeStorage API
      window.electronAPI.setSecureData(keyId, keyData);
    } else {
      // Web: Use IndexedDB with additional encryption
      await this.storeInIndexedDB(keyId, keyData);
    }
  }
}
```

### Field-Level Encryption
```javascript
class FieldEncryption {
  constructor(encryptionService) {
    this.encryptionService = encryptionService;
    this.sensitiveFields = ['email', 'phone', 'address', 'notes'];
  }

  // Encrypt sensitive fields in an object
  encryptSensitiveFields(obj, password) {
    const encrypted = { ...obj };
    
    this.sensitiveFields.forEach(field => {
      if (encrypted[field]) {
        encrypted[field] = this.encryptionService.encrypt(
          encrypted[field], 
          password
        );
        encrypted[`${field}_encrypted`] = true;
      }
    });
    
    return encrypted;
  }

  // Decrypt sensitive fields
  decryptSensitiveFields(obj, password) {
    const decrypted = { ...obj };
    
    this.sensitiveFields.forEach(field => {
      if (decrypted[`${field}_encrypted`]) {
        decrypted[field] = this.encryptionService.decrypt(
          decrypted[field], 
          password
        );
        delete decrypted[`${field}_encrypted`];
      }
    });
    
    return decrypted;
  }
}
```

## Secure Database Operations

### PouchDB with Encryption
```javascript
import PouchDB from 'pouchdb';
import PouchDBFind from 'pouchdb-find';
import { EncryptionService } from './EncryptionService';

PouchDB.plugin(PouchDBFind);

class SecureDatabase {
  constructor(dbName, password) {
    this.db = new PouchDB(dbName);
    this.encryption = new EncryptionService();
    this.password = password;
  }

  // Store encrypted document
  async put(doc) {
    const encryptedDoc = {
      _id: doc._id,
      _rev: doc._rev,
      type: doc.type,
      encrypted_data: this.encryption.encrypt(doc, this.password),
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString()
    };
    
    return await this.db.put(encryptedDoc);
  }

  // Retrieve and decrypt document
  async get(id) {
    const encryptedDoc = await this.db.get(id);
    const decryptedData = this.encryption.decrypt(
      encryptedDoc.encrypted_data, 
      this.password
    );
    
    return {
      ...decryptedData,
      _id: encryptedDoc._id,
      _rev: encryptedDoc._rev
    };
  }

  // Search encrypted documents (metadata only)
  async find(selector) {
    const result = await this.db.find({
      selector: {
        type: selector.type,
        created_at: { $gte: selector.created_after || '1970-01-01' }
      }
    });

    const decryptedDocs = await Promise.all(
      result.docs.map(doc => this.get(doc._id))
    );

    return {
      docs: decryptedDocs.filter(doc => 
        this.matchesSelector(doc, selector)
      )
    };
  }

  // Helper to match selector against decrypted data
  matchesSelector(doc, selector) {
    return Object.keys(selector).every(key => {
      if (key === 'type' || key === 'created_after') return true;
      return doc[key] === selector[key];
    });
  }
}
```

## Cloud Sync Security

### Secure Cloud Sync Implementation
```javascript
class SecureCloudSync {
  constructor(cloudProvider, encryptionService) {
    this.cloudProvider = cloudProvider;
    this.encryption = encryptionService;
  }

  // Upload encrypted data
  async uploadDocument(doc, password) {
    // Encrypt entire document
    const encryptedDoc = this.encryption.encrypt(doc, password);
    
    // Add metadata for sync (unencrypted)
    const syncDoc = {
      id: doc._id,
      type: 'encrypted_document',
      encrypted_data: encryptedDoc,
      last_modified: new Date().toISOString(),
      device_id: await this.getDeviceId(),
      checksum: await this.calculateChecksum(encryptedDoc)
    };

    return await this.cloudProvider.upload(
      `documents/${doc._id}.json`, 
      JSON.stringify(syncDoc)
    );
  }

  // Download and verify document
  async downloadDocument(docId, password) {
    const syncDoc = JSON.parse(
      await this.cloudProvider.download(`documents/${docId}.json`)
    );

    // Verify checksum
    const expectedChecksum = await this.calculateChecksum(syncDoc.encrypted_data);
    if (expectedChecksum !== syncDoc.checksum) {
      throw new Error('Document integrity check failed');
    }

    // Decrypt and return
    return this.encryption.decrypt(syncDoc.encrypted_data, password);
  }

  // Secure conflict resolution
  async resolveConflict(localDoc, remoteDoc, password) {
    // Decrypt both documents
    const localDecrypted = this.encryption.decrypt(localDoc.encrypted_data, password);
    const remoteDecrypted = this.encryption.decrypt(remoteDoc.encrypted_data, password);

    // Present conflict resolution UI to user
    const resolution = await this.presentConflictResolution(
      localDecrypted, 
      remoteDecrypted
    );

    // Return resolved document
    return resolution;
  }

  async calculateChecksum(data) {
    const encoder = new TextEncoder();
    const dataBuffer = encoder.encode(JSON.stringify(data));
    const hashBuffer = await crypto.subtle.digest('SHA-256', dataBuffer);
    const hashArray = Array.from(new Uint8Array(hashBuffer));
    return hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
  }

  async getDeviceId() {
    // Platform-specific device identification
    if (Platform.OS === 'ios' || Platform.OS === 'android') {
      return await DeviceInfo.getUniqueId();
    } else if (isElectron()) {
      return await window.electronAPI.getDeviceId();
    } else {
      // Web: Generate and store persistent device ID
      return await this.getWebDeviceId();
    }
  }
}
```

## Authentication & Authorization

### Multi-Platform Authentication
```javascript
class AuthenticationService {
  constructor(encryptionService) {
    this.encryption = encryptionService;
  }

  // Platform-agnostic login
  async login(email, password) {
    try {
      // Validate input
      if (!this.validateEmail(email) || !this.validatePassword(password)) {
        throw new Error('Invalid credentials format');
      }

      // Check for biometric authentication availability
      const biometricAvailable = await this.isBiometricAvailable();
      
      if (biometricAvailable) {
        const useBiometric = await this.promptBiometricAuth();
        if (useBiometric) {
          return await this.authenticateWithBiometric(email);
        }
      }

      // Standard password authentication
      const userKey = this.encryption.deriveKey(password, email);
      const encryptedCredentials = await this.getStoredCredentials(email);
      
      if (encryptedCredentials) {
        const credentials = this.encryption.decrypt(encryptedCredentials, password);
        return await this.validateAndCreateSession(credentials);
      }

      throw new Error('Invalid credentials');
    } catch (error) {
      // Log security event without exposing sensitive data
      this.logSecurityEvent('login_failure', { email: email.substring(0, 3) + '***' });
      throw error;
    }
  }

  // Biometric authentication
  async authenticateWithBiometric(email) {
    const biometricResult = await this.performBiometricAuth();
    
    if (biometricResult.success) {
      const storedCredentials = await this.getSecurelyStoredCredentials(email);
      return await this.validateAndCreateSession(storedCredentials);
    }
    
    throw new Error('Biometric authentication failed');
  }

  // Platform-specific biometric check
  async isBiometricAvailable() {
    if (Platform.OS === 'ios' || Platform.OS === 'android') {
      return await TouchID.isSupported();
    } else if (isElectron()) {
      // Check for Windows Hello or macOS Touch ID via Electron
      return await window.electronAPI.isBiometricAvailable();
    } else {
      // Web: Check for WebAuthn support
      return window.PublicKeyCredential && 
             await PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable();
    }
  }

  // Secure session management
  async createSecureSession(user) {
    const sessionToken = await this.generateSecureToken();
    const sessionData = {
      userId: user.id,
      email: user.email,
      createdAt: new Date().toISOString(),
      expiresAt: new Date(Date.now() + 24 * 60 * 60 * 1000).toISOString(), // 24 hours
      deviceId: await this.getDeviceId()
    };

    // Store session securely
    await this.storeSecureSession(sessionToken, sessionData);
    
    return sessionToken;
  }

  // Token generation
  async generateSecureToken() {
    const array = new Uint8Array(32);
    if (typeof window !== 'undefined' && window.crypto) {
      window.crypto.getRandomValues(array);
    } else {
      // Node.js environment (Electron)
      const crypto = require('crypto');
      crypto.randomFillSync(array);
    }
    return Array.from(array, byte => byte.toString(16).padStart(2, '0')).join('');
  }
}
```

### OAuth 2.0 with PKCE Implementation
```javascript
class OAuth2Service {
  constructor() {
    this.codeVerifier = null;
    this.codeChallenge = null;
  }

  // Generate PKCE challenge
  async generatePKCE() {
    // Generate code verifier
    const array = new Uint8Array(32);
    crypto.getRandomValues(array);
    this.codeVerifier = this.base64URLEncode(array);

    // Generate code challenge
    const encoder = new TextEncoder();
    const data = encoder.encode(this.codeVerifier);
    const digest = await crypto.subtle.digest('SHA-256', data);
    this.codeChallenge = this.base64URLEncode(new Uint8Array(digest));
  }

  // OAuth 2.0 authorization URL
  getAuthorizationUrl(clientId, redirectUri, scope, provider) {
    const params = new URLSearchParams({
      response_type: 'code',
      client_id: clientId,
      redirect_uri: redirectUri,
      scope: scope,
      code_challenge: this.codeChallenge,
      code_challenge_method: 'S256',
      state: crypto.randomUUID()
    });

    const baseUrls = {
      dropbox: 'https://www.dropbox.com/oauth2/authorize',
      google: 'https://accounts.google.com/o/oauth2/v2/auth',
      microsoft: 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize'
    };

    return `${baseUrls[provider]}?${params.toString()}`;
  }

  // Exchange authorization code for token
  async exchangeCodeForToken(code, clientId, redirectUri, provider) {
    const tokenEndpoints = {
      dropbox: 'https://api.dropboxapi.com/oauth2/token',
      google: 'https://oauth2.googleapis.com/token',
      microsoft: 'https://login.microsoftonline.com/common/oauth2/v2.0/token'
    };

    const response = await fetch(tokenEndpoints[provider], {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        grant_type: 'authorization_code',
        client_id: clientId,
        code: code,
        redirect_uri: redirectUri,
        code_verifier: this.codeVerifier
      })
    });

    if (!response.ok) {
      throw new Error('Token exchange failed');
    }

    return await response.json();
  }

  base64URLEncode(array) {
    return btoa(String.fromCharCode.apply(null, array))
      .replace(/\+/g, '-')
      .replace(/\//g, '_')
      .replace(/=/g, '');
  }
}
```

## Security Monitoring & Logging

### Security Event Logging
```javascript
class SecurityLogger {
  constructor() {
    this.events = [];
    this.sensitiveFields = ['password', 'token', 'key', 'secret'];
  }

  // Log security events without exposing sensitive data
  logSecurityEvent(eventType, metadata = {}) {
    const sanitizedMetadata = this.sanitizeMetadata(metadata);
    
    const event = {
      type: eventType,
      timestamp: new Date().toISOString(),
      platform: this.getPlatform(),
      appVersion: this.getAppVersion(),
      metadata: sanitizedMetadata,
      sessionId: this.getCurrentSessionId()
    };

    this.events.push(event);
    
    // Store locally for analysis
    this.storeSecurityEvent(event);
    
    // Send to monitoring service (without sensitive data)
    this.sendToMonitoringService(event);
  }

  // Remove sensitive data from logs
  sanitizeMetadata(metadata) {
    const sanitized = { ...metadata };
    
    Object.keys(sanitized).forEach(key => {
      if (this.sensitiveFields.some(field => 
        key.toLowerCase().includes(field.toLowerCase())
      )) {
        sanitized[key] = '[REDACTED]';
      }
      
      // Redact email addresses partially
      if (key === 'email' && sanitized[key]) {
        const email = sanitized[key];
        const [username, domain] = email.split('@');
        sanitized[key] = `${username.substring(0, 2)}***@${domain}`;
      }
    });
    
    return sanitized;
  }

  // Security metrics
  getSecurityMetrics() {
    const recent = this.events.filter(event => 
      new Date(event.timestamp) > new Date(Date.now() - 24 * 60 * 60 * 1000)
    );

    return {
      totalEvents: this.events.length,
      recentEvents: recent.length,
      eventTypes: this.groupBy(recent, 'type'),
      platforms: this.groupBy(recent, 'platform'),
      suspiciousActivity: this.detectSuspiciousActivity(recent)
    };
  }

  // Detect suspicious patterns
  detectSuspiciousActivity(events) {
    const suspicious = [];
    
    // Multiple failed login attempts
    const failedLogins = events.filter(e => e.type === 'login_failure');
    if (failedLogins.length > 5) {
      suspicious.push({
        type: 'multiple_failed_logins',
        count: failedLogins.length,
        severity: 'high'
      });
    }

    // Unusual platform access patterns
    const platforms = [...new Set(events.map(e => e.platform))];
    if (platforms.length > 3) {
      suspicious.push({
        type: 'multiple_platform_access',
        platforms: platforms,
        severity: 'medium'
      });
    }

    return suspicious;
  }
}
```

## Privacy & Compliance

### GDPR Compliance Implementation
```javascript
class PrivacyService {
  constructor(database, encryptionService) {
    this.db = database;
    this.encryption = encryptionService;
  }

  // Export user data (GDPR Article 20)
  async exportUserData(userId, password) {
    const userData = await this.getAllUserData(userId);
    
    // Decrypt sensitive data for export
    const decryptedData = await Promise.all(
      userData.map(doc => this.encryption.decrypt(doc.encrypted_data, password))
    );

    // Structure data for export
    const exportData = {
      exportDate: new Date().toISOString(),
      userId: userId,
      personalData: this.categorizePersonalData(decryptedData),
      metadata: {
        accountCreated: userData.accountCreated,
        lastLogin: userData.lastLogin,
        dataCategories: this.getDataCategories(decryptedData)
      }
    };

    return {
      format: 'json',
      data: exportData,
      filename: `user_data_export_${userId}_${Date.now()}.json`
    };
  }

  // Delete user data (GDPR Article 17 - Right to Erasure)
  async deleteUserData(userId, reason = 'user_request') {
    try {
      // Log deletion request
      this.logDataDeletion(userId, reason);

      // Delete all user documents
      const userDocs = await this.getAllUserData(userId);
      await Promise.all(
        userDocs.map(doc => this.db.remove(doc._id, doc._rev))
      );

      // Delete from cloud storage
      await this.deleteCloudUserData(userId);

      // Clear secure storage
      await this.clearUserSecureStorage(userId);

      // Anonymize logs (keep aggregated data for analytics)
      await this.anonymizeUserLogs(userId);

      return {
        success: true,
        deletedRecords: userDocs.length,
        deletionDate: new Date().toISOString()
      };
    } catch (error) {
      throw new Error(`Data deletion failed: ${error.message}`);
    }
  }

  // Data minimization - automatic cleanup
  async performDataMinimization() {
    // Delete old temporary data
    await this.deleteExpiredTempData();
    
    // Clean up old log entries
    await this.cleanupOldLogs();
    
    // Remove unused encryption keys
    await this.cleanupUnusedKeys();
    
    // Optimize storage
    await this.optimizeStorage();
  }

  // Consent management
  async updateConsent(userId, consentType, granted) {
    const consentRecord = {
      userId: userId,
      consentType: consentType,
      granted: granted,
      timestamp: new Date().toISOString(),
      ipAddress: await this.getHashedIP(), // Store hashed IP for legal compliance
      userAgent: this.getUserAgent()
    };

    await this.db.put({
      _id: `consent_${userId}_${consentType}_${Date.now()}`,
      type: 'consent_record',
      ...consentRecord
    });

    // Update user preferences
    await this.updateUserPreferences(userId, consentType, granted);
  }
}
```

## Incident Response & Recovery

### Security Incident Detection
```javascript
class SecurityIncidentDetector {
  constructor(securityLogger) {
    this.logger = securityLogger;
    this.alertThresholds = {
      failedLogins: 10,
      multipleDevices: 5,
      dataAccessSpike: 1000,
      suspiciousPatterns: 3
    };
  }

  // Real-time threat detection
  async detectThreats() {
    const recentEvents = this.logger.getRecentEvents(1); // Last hour
    const threats = [];

    // Brute force attack detection
    const failedLogins = recentEvents.filter(e => e.type === 'login_failure');
    if (failedLogins.length > this.alertThresholds.failedLogins) {
      threats.push({
        type: 'brute_force_attack',
        severity: 'critical',
        affectedUsers: [...new Set(failedLogins.map(e => e.userId))],
        eventCount: failedLogins.length
      });
    }

    // Credential stuffing detection
    const uniqueFailures = this.groupBy(failedLogins, 'userId');
    Object.keys(uniqueFailures).forEach(userId => {
      if (uniqueFailures[userId].length > 5) {
        threats.push({
          type: 'credential_stuffing',
          severity: 'high',
          affectedUser: userId,
          attempts: uniqueFailures[userId].length
        });
      }
    });

    // Unusual access patterns
    const accessEvents = recentEvents.filter(e => e.type === 'data_access');
    const accessByUser = this.groupBy(accessEvents, 'userId');
    
    Object.keys(accessByUser).forEach(userId => {
      const userAccess = accessByUser[userId];
      const platforms = [...new Set(userAccess.map(e => e.platform))];
      
      if (platforms.length > this.alertThresholds.multipleDevices) {
        threats.push({
          type: 'suspicious_multi_platform_access',
          severity: 'medium',
          affectedUser: userId,
          platforms: platforms
        });
      }
    });

    return threats;
  }

  // Automated incident response
  async respondToIncident(threat) {
    switch (threat.type) {
      case 'brute_force_attack':
        await this.handleBruteForceAttack(threat);
        break;
      case 'credential_stuffing':
        await this.handleCredentialStuffing(threat);
        break;
      case 'suspicious_multi_platform_access':
        await this.handleSuspiciousAccess(threat);
        break;
    }
  }

  async handleBruteForceAttack(threat) {
    // Temporarily lock affected accounts
    await Promise.all(
      threat.affectedUsers.map(userId => this.temporaryAccountLock(userId))
    );

    // Rate limit by IP (if available)
    await this.implementRateLimiting(threat);

    // Send security notifications
    await this.sendSecurityAlert(threat);

    // Log incident response
    this.logger.logSecurityEvent('incident_response', {
      incidentType: threat.type,
      action: 'account_lock_and_rate_limit',
      affectedUsers: threat.affectedUsers.length
    });
  }

  async handleCredentialStuffing(threat) {
    // Force password reset for affected user
    await this.forcePasswordReset(threat.affectedUser);

    // Send security notification to user
    await this.sendUserSecurityAlert(threat.affectedUser, threat.type);

    // Log incident
    this.logger.logSecurityEvent('credential_stuffing_response', {
      affectedUser: threat.affectedUser,
      action: 'force_password_reset'
    });
  }
}
```

## Security Testing & Validation

### Automated Security Testing
```javascript
class SecurityTestSuite {
  constructor() {
    this.encryptionService = new EncryptionService();
    this.testData = this.generateTestData();
  }

  // Test encryption/decryption
  async testEncryption() {
    const tests = [];
    
    // Test AES-256 encryption
    const testData = { sensitive: 'test data', number: 12345 };
    const password = 'test-password-123!';
    
    const encrypted = this.encryptionService.encrypt(testData, password);
    const decrypted = this.encryptionService.decrypt(encrypted, password);
    
    tests.push({
      name: 'AES-256 Encryption/Decryption',
      passed: JSON.stringify(testData) === JSON.stringify(decrypted),
      details: 'Data integrity maintained through encryption cycle'
    });

    // Test key derivation
    const key1 = this.encryptionService.deriveKey(password, 'salt1');
    const key2 = this.encryptionService.deriveKey(password, 'salt1');
    const key3 = this.encryptionService.deriveKey(password, 'salt2');
    
    tests.push({
      name: 'Key Derivation Consistency',
      passed: key1.toString() === key2.toString() && key1.toString() !== key3.toString(),
      details: 'Same password+salt produces same key, different salt produces different key'
    });

    return tests;
  }

  // Test input validation
  async testInputValidation() {
    const tests = [];
    const maliciousInputs = [
      '<script>alert("xss")</script>',
      "'; DROP TABLE users; --",
      '../../../etc/passwd',
      '%00%00%00%00',
      'a'.repeat(10000),
      null,
      undefined,
      {},
      []
    ];

    maliciousInputs.forEach((input, index) => {
      try {
        const validated = this.validateInput(input);
        tests.push({
          name: `Malicious Input ${index + 1}`,
          passed: validated === false || this.isSafeInput(validated),
          details: `Input: ${typeof input === 'string' ? input.substring(0, 50) : typeof input}`
        });
      } catch (error) {
        tests.push({
          name: `Malicious Input ${index + 1}`,
          passed: true,
          details: 'Properly rejected malicious input'
        });
      }
    });

    return tests;
  }

  // Test secure storage
  async testSecureStorage() {
    const tests = [];
    const testKey = 'test-secure-key';
    const testValue = 'sensitive-test-data';

    try {
      // Test storage
      await this.storeSecureData(testKey, testValue);
      const retrieved = await this.getSecureData(testKey);
      
      tests.push({
        name: 'Secure Storage Round-trip',
        passed: retrieved === testValue,
        details: 'Data stored and retrieved securely'
      });

      // Test data deletion
      await this.deleteSecureData(testKey);
      const deletedData = await this.getSecureData(testKey);
      
      tests.push({
        name: 'Secure Data Deletion',
        passed: deletedData === null,
        details: 'Data properly deleted from secure storage'
      });
    } catch (error) {
      tests.push({
        name: 'Secure Storage Error',
        passed: false,
        details: `Storage test failed: ${error.message}`
      });
    }

    return tests;
  }

  // Generate security test report
  async generateSecurityReport() {
    const encryptionTests = await this.testEncryption();
    const validationTests = await this.testInputValidation();
    const storageTests = await this.testSecureStorage();

    const allTests = [...encryptionTests, ...validationTests, ...storageTests];
    const passedTests = allTests.filter(test => test.passed);
    
    return {
      summary: {
        total: allTests.length,
        passed: passedTests.length,
        failed: allTests.length - passedTests.length,
        passRate: Math.round((passedTests.length / allTests.length) * 100)
      },
      details: allTests,
      recommendations: this.generateSecurityRecommendations(allTests),
      timestamp: new Date().toISOString()
    };
  }
}
```

Remember: Security is not a feature to be added later—it must be designed into the architecture from the beginning. Regular security audits, testing, and updates are essential for maintaining a secure cross-platform application. Always assume that attackers have access to the client-side code and design your security accordingly.