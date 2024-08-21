import numpy as np
from IPython import embed


# Clear all (not necessary in Python, but we'll just start with a clean slate)
# Clear Command Window in MATLAB is equivalent to not carrying over variables in Python

# Experimental coordinates
data_exp = np.loadtxt('outputR-2000000.txt', skiprows=9)
Natoms = data_exp.shape[0]
exp_cords = []

for line in range(Natoms):
    atom_id = data_exp[line, 0]
    x = data_exp[line, 2]
    y = data_exp[line, 3]
    z = data_exp[line, 4]
    exp_cords.append([atom_id, x, y, z])

exp_cords = np.array(exp_cords)

# Read the final equilibrated state of FS potential
# readfile = 326
# textFileName = f'output-{readfile}.txt'

textFileName = 'relaxed_fin.lmp'
Natoms = 8214

try:
    data = np.loadtxt(textFileName, skiprows=16, max_rows=Natoms)
    # data = np.loadtxt(textFileName, skiprows=9)
    # Natoms = data.shape[0]
    # Natoms = 8214

    # Calculate the least square distance
    obj = 0
    for line in range(Natoms):
        atom_id = data[line, 0]
        x = data[line, 2]
        y = data[line, 3]
        z = data[line, 4]

        # Find corresponding experimental coordinates
        idx = np.abs(exp_cords[:, 0] - atom_id) < 1e-5
        x_exp = exp_cords[idx, 1][0]
        y_exp = exp_cords[idx, 2][0]
        z_exp = exp_cords[idx, 3][0]

        # Calculate the objective function
        obj += np.sqrt((x - x_exp) ** 2 + (y - y_exp) ** 2 + (z - z_exp) ** 2)

    obj /= Natoms
    print(f'Objective function value: {obj}')

except FileNotFoundError:
    print(f'File {textFileName} does not exist.')

