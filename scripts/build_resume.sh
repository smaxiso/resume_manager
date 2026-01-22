#!/bin/bash

# Default values
ROOT_DIR="$(pwd)"
SOURCE_DIR="master/src"
MAIN_FILE="main.tex"
DEFAULT_OUTPUT_NAME="sumit_kumar.pdf"
DEFAULT_OUTPUT_DIR="$(pwd)/$SOURCE_DIR" # Absolute path to source directory

# Help function
print_usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -o, --output-dir <dir>    Specify output directory (default: same as source files)"
    echo "  -n, --name <filename>     Specify output filename (default: sumit_kumar.pdf)"
    echo "  -h, --help                Show this help message"
}

# Parse arguments
OUTPUT_DIR="$DEFAULT_OUTPUT_DIR"
OUTPUT_NAME="$DEFAULT_OUTPUT_NAME"

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -o|--output-dir)
            OUTPUT_DIR="$(realpath -m "$2")" # Get absolute path, even if it doesn't exist yet
            shift
            shift
            ;;
        -n|--name)
            OUTPUT_NAME="$2"
            shift
            shift
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            print_usage
            exit 1
            ;;
    esac
done

# Ensure .pdf extension
if [[ "$OUTPUT_NAME" != *.pdf ]]; then
    OUTPUT_NAME="${OUTPUT_NAME}.pdf"
fi

# Check for pdflatex
if ! command -v pdflatex &> /dev/null; then
    echo "Error: pdflatex is not installed."
    echo "Run: sudo apt-get install -y texlive-latex-base texlive-fonts-recommended texlive-latex-extra"
    exit 1
fi

# Create output directory if it doesn't exist
if [ ! -d "$OUTPUT_DIR" ]; then
    echo "Creating output directory: $OUTPUT_DIR"
    mkdir -p "$OUTPUT_DIR"
fi

echo "Building resume..."
echo "Output Directory: $OUTPUT_DIR"
echo "Output Filename:  $OUTPUT_NAME"

# Go to source directory
cd "$SOURCE_DIR" || exit 1

# Run pdflatex
# We use -output-directory to direct the build artifacts
# We run twice for cross-references
pdflatex -interaction=nonstopmode -output-directory="$OUTPUT_DIR" -jobname="${OUTPUT_NAME%.pdf}" "$MAIN_FILE" > /dev/null
pdflatex -interaction=nonstopmode -output-directory="$OUTPUT_DIR" -jobname="${OUTPUT_NAME%.pdf}" "$MAIN_FILE" | grep "Output written"

EXIT_CODE=$?

# Handle log files
LOGS_DIR="$ROOT_DIR/logs"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_FILENAME="${OUTPUT_NAME%.pdf}_${TIMESTAMP}.log"

# Ensure logs directory exists
if [ ! -d "$LOGS_DIR" ]; then
    mkdir -p "$LOGS_DIR"
fi

# Clean up auxiliary files (aux, out) but MOVE logs
# Removing common LaTeX generated files for the specific jobname
rm -f "$OUTPUT_DIR/${OUTPUT_NAME%.pdf}.aux" "$OUTPUT_DIR/${OUTPUT_NAME%.pdf}.out"

if [ -f "$OUTPUT_DIR/${OUTPUT_NAME%.pdf}.log" ]; then
    mv "$OUTPUT_DIR/${OUTPUT_NAME%.pdf}.log" "$LOGS_DIR/$LOG_FILENAME"
fi

if [ $EXIT_CODE -eq 0 ]; then
    echo "✅ Success! PDF saved to: $OUTPUT_DIR/$OUTPUT_NAME"
    echo "📝 Log saved to: logs/$LOG_FILENAME"
else
    echo "❌ Build failed. Check output."
    echo "📝 Check log at: logs/$LOG_FILENAME"
fi
