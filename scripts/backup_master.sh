#!/bin/bash

# Create backup with full timestamp (YYYYMMDD_HHMMSS)
# This allows multiple backups in the same day
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="backups/$TIMESTAMP"
SOURCE_DIR="master/src"
PDF_NAME="sumit_kumar.pdf"

# This check is now extremely unlikely to trigger, but good to keep
if [ -d "$BACKUP_DIR" ]; then
  echo "Backup directory already exists: $BACKUP_DIR"
  exit 1
fi

# Create backup directories
mkdir -p "$BACKUP_DIR/src"

# Copy source files (including the generated PDF which is now in src)
# We exclude log files explicitly just in case any are lingering
cp "$SOURCE_DIR"/* "$BACKUP_DIR/src/" 2>/dev/null
# Remove any logs that might have been copied if they weren't cleaned up
rm -f "$BACKUP_DIR/src/"*.log

# Rename the PDF if it exists to include the timestamp
if [ -f "$BACKUP_DIR/src/$PDF_NAME" ]; then
  mv "$BACKUP_DIR/src/$PDF_NAME" "$BACKUP_DIR/src/${PDF_NAME%.pdf}_$TIMESTAMP.pdf"
fi

echo "Created backup of master resume at $BACKUP_DIR"

# Update CHANGELOG automatically for backup
# We still group by Day in the header, but list the specific backup timestamp
CURRENT_DATE=$(date +"%Y-%m-%d")
TEMP_FILE=$(mktemp)
echo -e "# Resume Changelog\n\n## [$CURRENT_DATE]\n- Created backup: $TIMESTAMP\n" > "$TEMP_FILE"

if [ -f CHANGELOG.md ]; then
  cat CHANGELOG.md | grep -v "^# Resume Changelog" >> "$TEMP_FILE"
  mv "$TEMP_FILE" CHANGELOG.md
else
  mv "$TEMP_FILE" CHANGELOG.md
fi

echo "CHANGELOG.md has been updated with the backup entry"