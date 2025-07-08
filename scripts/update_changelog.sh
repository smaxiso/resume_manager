#!/bin/bash
# scripts/update_changelog.sh

# Function to generate CHANGELOG entry
generate_changelog_entry() {
  # Get today's date
  DATE=$(date +"%Y-%m-%d")
  
  # Display menu for change type
  echo "Select the type of changes made:"
  OPTIONS=("Updated master resume" "Created backup" "Created company-specific resume" "Modified resume template" "Other changes (specify)")
  
  select opt in "${OPTIONS[@]}"; do
    case $REPLY in
      1)
        # Updated master
        echo "Describe what was updated (e.g., 'Added new job', 'Updated skills'):"
        read -e DETAILS
        ENTRY="## [$DATE]\n- Updated master resume: $DETAILS"
        break
        ;;
      2)
        # Created backup
        echo "Which backup was created? (Date or description)"
        read -e BACKUP_NAME
        if [ -z "$BACKUP_NAME" ]; then
          BACKUP_NAME=$(date +"%Y%m%d")
        fi
        ENTRY="## [$DATE]\n- Created backup: $BACKUP_NAME"
        break
        ;;
      3)
        # Company-specific resume
        echo "For which company?"
        read -e COMPANY
        ENTRY="## [$DATE]\n- Created company-specific resume for $COMPANY"
        break
        ;;
      4)
        # Modified template
        echo "Which template was modified?"
        read -e TEMPLATE
        ENTRY="## [$DATE]\n- Modified resume template: $TEMPLATE"
        break
        ;;
      5)
        # Other
        echo "Describe the changes:"
        read -e CUSTOM
        ENTRY="## [$DATE]\n- $CUSTOM"
        break
        ;;
      *)
        echo "Invalid option. Try again."
        ;;
    esac
  done

  # Update CHANGELOG.md
  if [ -f CHANGELOG.md ]; then
    # Add entry to CHANGELOG.md (prepend)
    TEMP_FILE=$(mktemp)
    echo -e "# Resume Changelog\n\n$ENTRY\n" > $TEMP_FILE
    cat CHANGELOG.md | grep -v "^# Resume Changelog" >> $TEMP_FILE
    mv $TEMP_FILE CHANGELOG.md
  else
    # Create CHANGELOG.md if it doesn't exist
    echo -e "# Resume Changelog\n\n$ENTRY\n" > CHANGELOG.md
  fi
  
  echo "CHANGELOG.md has been updated."
}

generate_changelog_entry