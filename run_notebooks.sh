#!/bin/bash
# Launch Jupyter Lab for cyecca notebooks

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Create venv if it doesn't exist (Ubuntu 24.04+ requires this)
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
    source venv/bin/activate
    echo "Installing dependencies..."
    pip install -r requirements.txt
else
    source venv/bin/activate
fi

# Check if in ROS environment
if [ -n "$ROS_DISTRO" ]; then
    echo "✓ ROS $ROS_DISTRO environment detected"
fi

# Check if cyecca is available
python3 -c "import cyecca" 2>/dev/null && echo "✓ cyecca found" || echo "⚠ cyecca not found - install it first!"

# Launch Jupyter Lab
echo ""
echo "Starting Jupyter Lab..."
jupyter lab
