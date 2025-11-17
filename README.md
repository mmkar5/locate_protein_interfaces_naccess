The Python script calculates the Buried Surface Area (BSA) for residues at the interface of a protein-protein complex. It identifies
interface residues by comparing the Accessible Surface Area (ASA) of each residue in the complexed state versus its uncomplexed (subunit)
state.

Description
The script processes .asa files, which contain surface accessibility data for protein structures. It's designed to work with a set of
three files for each protein complex: one for the entire complex and one for each of the two individual subunits.

 1. For each atom, find its ASA in the free subunit (asa_sub) and in the complex (asa_complex).
 2. Calculate the Buried Surface Area (BSA) as: bsa = asa_sub - asa_complex.
 3. Any residue with at least one atom showing a positive BSA is considered an "interface residue."
 4. The script aggregates these interface residues, removes duplicates, and saves the results.

Requirements
 - Pandas library

Input File Structure

The script requires .asa files to be present in the same directory where the script is run. The files must follow a specific naming
convention for the script to correctly associate them:

 - Complex: *_complex.asa
 - Subunit 1: *_subunit1.asa
 - Subunit 2: *_subunit2.asa


The * (wildcard) part of the name should be identical for all three files belonging to the same complex. For example:

 - 1a2b_complex.asa
 - 1a2b_subunit1.asa
 - 1a2b_subunit2.asa


The script parses ATOM lines from these files using a regular expression to extract key information. The expected format for ATOM lines
is:
ATOM    (Atom#) (AtomName) (ResName) (Chain) (Res#) ... (ASA)

Output

The script generates two forms of output:


 1. Individual TSV Files: For each complex processed, a tab-separated file named {base_name}_interface.tsv is created (e.g.,
    1a2b_interface.tsv). This file contains the unique interface residues for that specific complex, with the following columns:
     - atom_number
     - residue
     - residue_number
     - chain_id
     - bsa
     - file_name

 2. Console Output: After processing all file sets, the script prints a consolidated pandas DataFrame to the console. This DataFrame contains
    the interface residue data from all complexes that were analyzed.


