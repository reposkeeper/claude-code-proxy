#!/bin/bash

# Installation script for ccr command
# This script installs ccr to ~/bin directory

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the current script directory (where this install.sh is located)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CCR_PATH="${SCRIPT_DIR}/ccr"
INSTALL_DIR="$HOME/bin"
INSTALL_PATH="${INSTALL_DIR}/ccr"

echo -e "${YELLOW}Installing ccr command...${NC}"

# Check if ccr exists in current directory
if [ ! -f "$CCR_PATH" ]; then
    echo -e "${RED}Error: ccr script not found at $CCR_PATH${NC}"
    exit 1
fi

# Create ~/bin directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Creating $INSTALL_DIR directory..."
    mkdir -p "$INSTALL_DIR"
fi

# Create the wrapper script
echo "Creating wrapper script at $INSTALL_PATH..."
cat > "$INSTALL_PATH" << EOF
#!/bin/bash
bash "$CCR_PATH" \$@
EOF

# Make it executable
chmod +x "$INSTALL_PATH"

echo -e "${GREEN}✓ ccr command installed successfully!${NC}"
echo ""
echo "Installation details:"
echo "  Source script: $CCR_PATH"
echo "  Installed to:  $INSTALL_PATH"
echo ""

# Check if ~/bin is in PATH
if [[ ":$PATH:" == *":$HOME/bin:"* ]]; then
    echo -e "${GREEN}✓ ~/bin is already in your PATH${NC}"
    echo "You can now use: ccr [ucloud|glm]"
else
    echo -e "${YELLOW}⚠ ~/bin is not in your PATH${NC}"
    echo "To use the ccr command from anywhere, add ~/bin to your PATH:"
    echo ""
    echo "For bash, add this line to ~/.bashrc or ~/.bash_profile:"
    echo "  export PATH=\"\$HOME/bin:\$PATH\""
    echo ""
    echo "For zsh, add this line to ~/.zshrc:"
    echo "  export PATH=\"\$HOME/bin:\$PATH\""
    echo ""
    echo "Then restart your terminal or run: source ~/.zshrc (or ~/.bashrc)"
    echo ""
    echo "Alternatively, you can use the full path: $INSTALL_PATH"
fi

echo ""
echo "Test the installation:"
echo "  ccr --help"
