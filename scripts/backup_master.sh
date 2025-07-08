#!/bin/bash

# Create backup with today's date
DATE=$(date +%Y%m%d)
BACKUP_DIR="backups/$DATE"

if [ -d "$BACKUP_DIR" ]; then
  echo "Backup directory already exists: $BACKUP_DIR"
  exit 1
fi

# Create backup directories
mkdir -p $BACKUP_DIR/src
mkdir -p $BACKUP_DIR/output

# Copy master files to backup directory
cp -r master/src/* $BACKUP_DIR/src/
cp -r master/output/* $BACKUP_DIR/output/ 2>/dev/null

# Rename output PDF with date
if [ -f "$BACKUP_DIR/output/resume.pdf" ]; then
  mv "$BACKUP_DIR/output/resume.pdf" "$BACKUP_DIR/output/resume_$DATE.pdf"
fi

echo "Created backup of master resume at $BACKUP_DIR"

# Update CHANGELOG automatically for backup
TEMP_FILE=$(mktemp)
echo -e "# Resume Changelog\n\n## [$(date +"%Y-%m-%d")]\n- Created backup: $DATE\n" > $TEMP_FILE
if [ -f CHANGELOG.md ]; then
  cat CHANGELOG.md | grep -v "^# Resume Changelog" >> $TEMP_FILE
  mv $TEMP_FILE CHANGELOG.md
else
  mv $TEMP_FILE CHANGELOG.md
fi

echo "CHANGELOG.md has been updated with the backup entry"