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

This will install a pre-push hook that ensures your CHANGELOG.md is updated when you make resume changes.

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

## CHANGELOG Management

This repository maintains a CHANGELOG.md file to track significant changes to your resume.

### Automatic CHANGELOG Updates

The CHANGELOG is automatically updated when you:
- Run `./scripts/backup_master.sh` to create a backup (timestamped, supports multiple per day)
- Run `./scripts/create_company_resume.sh` to create a company resume

### Manual CHANGELOG Updates

You can manually update the CHANGELOG with:

```bash
./scripts/update_changelog.sh
```

### Git Integration

A pre-push hook ensures CHANGELOG.md is updated when you push changes.
The hook is installed via `./scripts/setup_git_hooks.sh`.

If you make changes to resume files without updating the CHANGELOG,
the hook will prevent the push and provide clear instructions on how to update it.

**Note**: If you're setting up this repository on a new machine, make sure to run the setup script to install the git hooks.


## Complete Workflow

With these tools in place, your workflow becomes:

1. **Make changes** to your resume files
2. **Run scripts** to create backups or company versions (CHANGELOG updates automatically)
3. **Stage and commit** your changes
4. When you **push**, the hook checks if you've updated the CHANGELOG
5. If not, it **prompts you** to add a CHANGELOG entry through an interactive menu
6. After updating the CHANGELOG, the **push proceeds**

This setup ensures your CHANGELOG stays current with minimal effort, while the menu-based approach makes it easy to add standardized entries. The Git integration makes the workflow seamless while still giving you flexibility to describe changes in a meaningful way.