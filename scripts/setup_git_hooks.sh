#!/bin/bash

# Script to set up git hooks for the resume management system

echo "🔧 Setting up git hooks for resume management..."

# Check if we're in a git repository
if [ ! -d ".git" ]; then
  echo "❌ Error: This script must be run from the root of the git repository"
  exit 1
fi

# Create hooks directory if it doesn't exist
mkdir -p .git/hooks

# Copy the pre-push hook
if [ -f "git-hooks/pre-push" ]; then
  cp git-hooks/pre-push .git/hooks/pre-push
  chmod +x .git/hooks/pre-push
  echo "✅ Pre-push hook installed and made executable"
else
  echo "❌ Error: git-hooks/pre-push not found"
  exit 1
fi

echo "🎉 Git hooks setup complete!"
echo
echo "📝 The pre-push hook will now:"
echo "   • Check for changelog updates when pushing resume changes"
echo "   • Prevent pushes if CHANGELOG.md is not updated"
echo "   • Provide clear instructions on how to fix issues"
echo
echo "💡 To update the changelog manually, run: ./scripts/update_changelog.sh"
