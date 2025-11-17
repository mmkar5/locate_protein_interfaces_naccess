import pandas as pd
import glob
import os
import re

def read_asa_file(file_path):
    with open(file_path, 'r') as file:
        data = []
        for line in file.readlines():
            if line.startswith('ATOM'):
                match = re.match(r"ATOM\s+(\d+)\s+\S+\s+(\S+)\s+(\S)\s+(\d+)\s+[\d\s\.-]+\s+(\d+\.\d+)", line)
                if match:
                    fields = {
                        'atom_number': int(match.group(1)),
                        'residue': match.group(2),
                        'chain_id': match.group(3),
                        'residue_number': int(match.group(4)),
                        'asa': float(match.group(5))
                    }
                    data.append(fields)
    return pd.DataFrame(data)

# Paths to your .asa files (using glob to match file patterns)
complex_files = glob.glob('*complex.asa')
subunit1_files = glob.glob('*subunit1.asa')
subunit2_files = glob.glob('*subunit2.asa')

# Initialize an empty DataFrame to store results
all_results = pd.DataFrame()

# Process each set of files
for complex_file, subunit1_file, subunit2_file in zip(complex_files, subunit1_files, subunit2_files):
    df_complex = read_asa_file(complex_file)
    df_subunit1 = read_asa_file(subunit1_file)
    df_subunit2 = read_asa_file(subunit2_file)
    
    # Concatenate subunit data
    df_subunit = pd.concat([df_subunit1, df_subunit2], axis=0)

    # Merge the data on atom_number, residue, chain_id, and residue_number
    df_merged = pd.merge(df_subunit, df_complex, on=['atom_number', 'residue', 'chain_id', 'residue_number'], suffixes=('_sub','_complex'))

    # Calculate the BSA
    df_merged['bsa'] = df_merged['asa_sub'] - df_merged['asa_complex']

    # Filter residues with positive BSA
    df_filtered = df_merged[df_merged['bsa'] > 0]

    # Remove duplicate residues
    df_unique = df_filtered.drop_duplicates(subset=['residue', 'residue_number', 'chain_id'])

    # Add file name to the results
    df_unique['file_name'] = complex_file

    # Append results to all_results DataFrame
    all_results = pd.concat([all_results, df_unique[['atom_number', 'residue', 'residue_number', 'chain_id', 'bsa', 'file_name']]])

    # Save the results to a TSV file
    base_name = os.path.basename(complex_file).replace('complex.asa', '')
    output_file = f'{base_name}_interface.tsv'
    df_unique.to_csv(output_file, index=False, sep='\t')

print(all_results)
