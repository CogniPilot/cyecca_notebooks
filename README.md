# Cyecca Notebooks

[![Test Notebooks](https://github.com/cognipilot/cyecca_notebooks/actions/workflows/test-notebooks.yml/badge.svg)](https://github.com/cognipilot/cyecca_notebooks/actions/workflows/test-notebooks.yml)

Interactive Jupyter notebooks demonstrating cyecca library usage for estimation, control, and path planning.

## Setup

### Option 1: VS Code (Recommended)
1. Install the [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python) and [Jupyter](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter) extensions
2. Open any `.ipynb` file in VS Code
3. Select the Python kernel when prompted
4. VS Code will prompt to install dependencies - click "Install" or manually run:
   ```bash
   pip install -r requirements.txt
   ```

**With ROS workspace:**
1. Run the kernel setup script (creates venv_ros, installs dependencies, and configures the kernel):
   ```bash
   ./scripts/setup_kernel.sh
   ```

2. In VS Code, open a notebook and select the kernel:
   - Click on the kernel name in the top right corner of the notebook
   - Select "Cyecca (ROS)" from the list

3. The notebook will now use the cyecca version from your ROS workspace at `../../install/`

### Option 2: Jupyter Lab (Automated)
```bash
# Standalone - installs cyecca from PyPI
./scripts/run_notebooks.sh

# With ROS 2 - uses workspace cyecca
source /path/to/ros_ws/install/setup.bash
./scripts/run_notebooks.sh
```

### Option 3: Manual Setup
```bash
# Create virtual environment (Ubuntu 24.04+)
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Launch Jupyter
jupyter lab
```

## Notes

- **VS Code**: Python path from ROS workspace (if sourced) takes precedence
- **Ubuntu 24.04+**: Use `python3 -m venv venv` for isolated environment if needed
- Most users can just open notebooks in VS Code and install dependencies when prompted

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
