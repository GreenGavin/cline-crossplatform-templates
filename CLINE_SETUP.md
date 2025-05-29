# Cline Auto-Setup Instructions for Cross-Platform Projects

## Initial Setup vs Update Detection
1. Check if `.cline/documentation/TEMPLATE_VERSION` exists
2. If exists: Compare with remote VERSION to determine if update needed
3. If no version file or versions differ: Proceed with setup/update process

## Directory Structure to Create
1. Create `.cline/` directory
2. Create `.cline/templates/` directory  
3. Create `.cline/templates/issue-templates/` directory
4. Create `.cline/backups/` directory (for version management)
5. Create `.cline/documentation/` directory (for version tracking and user guides)

## Version Management Files
- `.cline/documentation/file-hashes.json` - Track original template file hashes
- `.cline/documentation/user-modifications.json` - Track which files user has modified
- `.cline/documentation/TEMPLATE_VERSION` - Current template version
- `.cline/documentation/github-automation-guide.md` - User guide for GitHub automation
- `.cline/documentation/setup-log.txt` - Setup and update logs

## Update Process (when version differs)
1. **Pre-Update Backup**
   - Create backup directory: `.cline/backups/backup-[current-version]-[timestamp]/`
   - Copy all current `.cline/` files to backup directory
   - Log backup location for user reference

2. **Change Detection**
   - Read `.cline/documentation/file-hashes.json` to get original template hashes
   - Calculate current file hashes and compare
   - Mark files as "user-modified" if hashes don't match originals
   - Store user modifications in `.cline/documentation/user-modifications.json`

3. **Smart Update Strategy**
   - Download new templates to temporary location first
   - For each file to update:
     - **If file not user-modified**: Auto-update and inform user
     - **If file user-modified**: 
       - Show file path and ask: "File [filename] has local changes. Options: (k)eep current, (u)pdate anyway, (s)how diff"
       - If user chooses show diff: Display key changes between versions
       - Respect user choice and log decision

## Files to Download/Update (in order)
1. `templates/instructions.md` → `.cline/instructions.md`
2. `templates/git-workflow.md` → `.cline/git-workflow.md`
3. `templates/github-integration.md` → `.cline/github-integration.md`
4. `templates/security-notes.md` → `.cline/security-notes.md`
5. `templates/issue-templates/bug-report.md` → `.cline/templates/issue-templates/bug-report.md`
6. `templates/issue-templates/feature-request.md` → `.cline/templates/issue-templates/feature-request.md`
7. `templates/issue-templates/performance-issue.md` → `.cline/templates/issue-templates/performance-issue.md`
8. `templates/issue-templates/security-issue.md` → `.cline/templates/issue-templates/security-issue.md`

## Hash Tracking (after each file download/update)
- Calculate SHA-256 hash of downloaded file
- Store in `.cline/file-hashes.json` format:
```json
{
  "instructions.md": "abc123...",
  "git-workflow.md": "def456...",
  "performance-issue.md": "ghi789...",
  "last_updated": "2025-05-29T10:30:00Z"
}
```

## Context Files to Create (if they don't exist)
- `.cline/context.md` - Current project state and recent progress
- `.cline/tasks.md` - Development tasks and priorities focusing on offline-first architecture
- `.cline/decisions.md` - Architecture decision records including privacy and encryption decisions

## Cross-Platform Specific Considerations
- When updating `.cline/tasks.md`, preserve any offline-first architecture notes and cross-platform compatibility requirements
- When updating `.cline/decisions.md`, maintain existing privacy and encryption decision records
- Alert user if security-related files are being updated: "Security templates updated - please review privacy and encryption configurations"

## Error Handling
- Create each directory individually before downloading files
- Report success/failure for each file download
- Continue with other downloads even if some fail
- Use existing local templates if downloads fail
- If backup creation fails, warn user and ask if they want to continue
- Log all errors to `.cline/documentation/setup-log.txt` with timestamps
- For cross-platform projects, note any platform-specific file handling issues

## Post Setup/Update
- Edit the `.cline/instructions.md` and update [Solution Name] with the correct project name (only if file was updated or newly created)
- If `.cline/instructions.md` was user-modified, prompt: "Instructions file has local changes. Would you like me to help merge the project name update?"
- Edit `.cline/context.md` and update with current project knowledge, preserving cross-platform architecture notes
- Edit `.cline/tasks.md` and update with current development status, maintaining offline-first architecture focus
- Update `.cline/documentation/TEMPLATE_VERSION` to match remote version
- **IMPORTANT: After setup/update completion, read and follow `.cline/instructions.md` for all development work**
- **Cross-Platform Specific Post-Setup:**
  - Verify platform compatibility notes are preserved in context
  - Ensure offline-first architecture priorities remain in tasks
  - Check that privacy/encryption decisions are maintained in decisions.md
  - Prompt user to review security configurations if security templates were updated

## Development Guidelines
- **Always read `.cline/instructions.md` at the start of any development task**
- Follow all guidelines, workflows, and standards specified in the instructions
- The instructions.md file will reference other relevant files (git-workflow.md, security-notes.md, github-integration.md) as needed
- Pay special attention to cross-platform considerations, offline-first architecture, and privacy/encryption requirements
- Use the downloaded templates for consistency in issues, documentation, and code structure

## Update Summary Report
After completion, show:
```
Cross-Platform Setup/Update Complete!
- Template Version: [old] → [new]
- Files Updated: [list]
- Files Preserved (user-modified): [list]  
- Backup Location: .cline/backups/backup-[version]-[timestamp]/
- Cross-Platform Notes: Offline-first and privacy configurations preserved
- Security Updates: [if any security templates updated]
- Next: Review updated files and merge any needed customizations
```

## Cross-Platform Template Validation
- After setup/update, verify that performance-issue.md template exists (specific to cross-platform projects)
- Ensure security-related templates are properly configured for cross-platform considerations
- Validate that offline-first architecture priorities are maintained in task files