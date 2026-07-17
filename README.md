# Resume Management System

This repository contains my resume in various formats, versions, and customizations.

## Structure

- `master/`: Current working version of my resume
- `backups/`: Historical backups of my resume organized by date
- `companies/`: Company-specific versions of my resume
- `templates/`: Different resume templates/styles
- `scripts/`: Helper scripts for managing resumes
- `logs/`: Build logs (auto-generated)

## Setup

### Initial Setup (First Time)

After cloning this repository, run the setup script to install git hooks:

```bash
./scripts/setup_git_hooks.sh
```

This will install a `pre-commit` hook that fully automates the build, backup, and changelog process when you make resume changes.

## Usage

### Building the Resume

The primary build script handles LaTeX compilation, handles missing dependencies, and organizes output.

**Default Build** (Outputs to `master/src/sumit_kumar.pdf`):
```bash
./scripts/build_resume.sh
```

**Custom Build** (Specify output directory and filename):
```bash
./scripts/build_resume.sh -o my_output_dir -n my_resume.pdf
```

### Creating a company-specific resume

```bash
./scripts/create_company_resume.sh company_name
```

## CHANGELOG and Backup Management

This repository maintains a `CHANGELOG.md` file to track significant changes and a `backups/` directory for historical snapshots.

### Automatic Workflow (The pre-commit hook)

With the hooks installed (`./scripts/setup_git_hooks.sh`), your workflow is completely automated:

1. **Make changes** to your resume files in `master/src/`
2. **Stage your changes**: `git add .`
3. **Commit your changes**: `git commit`
4. The hook will interrupt and **prompt you** for a brief description of what changed.
5. The hook will then automatically:
   - Build the PDF to ensure it compiles
   - Create a backup in `backups/`
   - Update `CHANGELOG.md` with your description
   - Stage the newly created PDF, backup, and changelog
6. Your commit completes successfully with everything bundled!

### Manual Execution

If you wish to run the backup and changelog manually without committing:
```bash
./scripts/backup_master.sh "Your description here"
```