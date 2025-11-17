#!/bin/bash

FILE="/home/nitdgp-bt11/lab2/PDB_FINAL/*.pdb"

for f in $FILE
	do
		grep 'CHAIN: ' $f | head -1 | cut -d ':' -f 2| cut -d ';' -f 1 > Chain_1
		VAR=$(cat Chain_1)
		for j in ${VAR}
					do
						pdb_selchain -$j $f| grep ^"ATOM " >> $f"_1.pdb"
					done
	done

mv *_1.pdb /home/nitdgp-bt11/lab2/PDB_FINAL/Entity1
