#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <company_name>"
  exit 1
fi

COMPANY=$1
COMPANY_DIR="companies/$COMPANY"

if [ -d "$COMPANY_DIR" ]; then
  echo "Company directory already exists: $COMPANY_DIR"
  exit 1
fi

# Create company directories
mkdir -p $COMPANY_DIR/src
mkdir -p $COMPANY_DIR/output

# Copy master files to company directory
cp -r master/src/* $COMPANY_DIR/src/

echo "Created company resume template for $COMPANY"
echo "Customize the files in $COMPANY_DIR/src for this specific company"
echo "Build the resume with pdflatex or your preferred LaTeX compiler"

# Update CHANGELOG automatically
TEMP_FILE=$(mktemp)
echo -e "# Resume Changelog\n\n## [$(date +"%Y-%m-%d")]\n- Created company-specific resume for $COMPANY\n" > $TEMP_FILE
if [ -f CHANGELOG.md ]; then
  cat CHANGELOG.md | grep -v "^# Resume Changelog" >> $TEMP_FILE
  mv $TEMP_FILE CHANGELOG.md
else
  mv $TEMP_FILE CHANGELOG.md
fi

echo "CHANGELOG.md has been updated"