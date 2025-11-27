#!/bin/bash
# Setup Jupyter kernel with ROS overlay for cyecca_notebooks

set -e  # Exit on error

# Get the directory of this script and the project root
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "${SCRIPT_DIR}/.." && pwd )"

# Check if ROS overlay exists
if [ ! -f "${PROJECT_ROOT}/../../install/setup.bash" ]; then
    echo "Error: ROS overlay not found at ${PROJECT_ROOT}/../../install/setup.bash"
    echo "Make sure you have built your ROS workspace before running this script."
    exit 1
fi

# Source the ROS overlay
echo "Sourcing ROS overlay from ${PROJECT_ROOT}/../../install/setup.bash"
source "${PROJECT_ROOT}/../../install/setup.bash"

# Create virtual environment if it doesn't exist
if [ ! -d "${PROJECT_ROOT}/venv_ros" ]; then
    echo "Creating virtual environment at ${PROJECT_ROOT}/venv_ros"
    python3 -m venv "${PROJECT_ROOT}/venv_ros"
fi

# Activate the virtual environment
source "${PROJECT_ROOT}/venv_ros/bin/activate"

# Install requirements if needed
if [ -f "${PROJECT_ROOT}/requirements.txt" ]; then
    echo "Installing requirements from requirements.txt"
    pip install -q -r "${PROJECT_ROOT}/requirements.txt"
    # Install additional dependencies that ROS packages might need
    pip install -q typeguard 2>/dev/null || true
fi

# Get all package paths from the ROS overlay
OVERLAY_PYTHONPATH=""
for pkg_dir in ${PROJECT_ROOT}/../../install/*/lib/python3.12/site-packages; do
    if [ -d "$pkg_dir" ]; then
        if [ -z "$OVERLAY_PYTHONPATH" ]; then
            OVERLAY_PYTHONPATH="$pkg_dir"
        else
            OVERLAY_PYTHONPATH="${OVERLAY_PYTHONPATH}:${pkg_dir}"
        fi
    fi
done

# Prepend overlay paths to existing PYTHONPATH
if [ -n "$PYTHONPATH" ]; then
    export PYTHONPATH="${OVERLAY_PYTHONPATH}:${PYTHONPATH}"
else
    export PYTHONPATH="${OVERLAY_PYTHONPATH}"
fi

# Install/update the Jupyter kernel with the correct environment
python -m ipykernel install --user --name=cyecca_ros --display-name="Cyecca (ROS)" --env PYTHONPATH "$PYTHONPATH" --env AMENT_PREFIX_PATH "$AMENT_PREFIX_PATH" --env LD_LIBRARY_PATH "$LD_LIBRARY_PATH"

# Create .env file for Pylance to use the same PYTHONPATH
echo "Creating .env file for Pylance..."
cat > "${PROJECT_ROOT}/.env" << EOF
PYTHONPATH=${PYTHONPATH}
AMENT_PREFIX_PATH=${AMENT_PREFIX_PATH}
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}
EOF

echo ""
echo "✓ Kernel 'cyecca_ros' installed successfully!"
echo "✓ Pylance environment configured in .env"
echo ""
echo "Next steps:"
echo "1. If VS Code is open, reload the window: Ctrl+Shift+P → 'Developer: Reload Window'"
echo "2. Open a notebook and click the kernel name in the top right corner"
echo "3. Select Kernel -> Jupyter Kernel -> Cyecca (ROS)
echo ""
echo "The notebook will now use cyecca from: ${PROJECT_ROOT}/../../install/cyecca"
