# Cyecca Notebooks

[![Test Notebooks](https://github.com/jgoppert/cyecca_notebooks/actions/workflows/test-notebooks.yml/badge.svg)](https://github.com/jgoppert/cyecca_notebooks/actions/workflows/test-notebooks.yml)

Interactive Jupyter notebooks demonstrating cyecca library usage for estimation, control, and path planning.

## Setup

### Option 1: Standalone (Ubuntu 24.04+)
```bash
# Run script creates venv and installs dependencies automatically
# This installs cyecca from PyPI
./run_notebooks.sh
```

### Option 2: With ROS 2 (use workspace cyecca)
```bash
# Source ROS workspace with cyecca first
source /path/to/ros_ws/install/setup.bash

# Run notebooks (ROS cyecca takes precedence over PyPI version)
./run_notebooks.sh
```

### Manual Setup (if needed)
```bash
# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Launch Jupyter
jupyter lab
```

## Notes

- If you source a ROS workspace before running, Python will use the cyecca version from ROS (via PYTHONPATH)
- Otherwise, cyecca is installed from PyPI into the venv
- This allows development with local ROS changes while keeping standalone usage simple

## Contents

- `estimation/` - State estimation examples
- `ins/` - Inertial navigation system notebooks
- `lie/` - Lie group examples
- `path_planning/` - Path planning demonstrations
- `sim/` - Simulation examples

## Dependencies

- cyecca (install from ROS workspace or `pip install cyecca`)
- jupyter
- matplotlib
- numpy
