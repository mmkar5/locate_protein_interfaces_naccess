#!/bin/bash

FILE="/home/nitdgp-bt11/lab2/PDB_FINAL/*.pdb"

for f in $FILE
	do
		grep 'CHAIN: ' $f | head -2 | tail -1| cut -d ':' -f 2| cut -d ';' -f 1 > Chain_2
		VAR=$(cat Chain_2)
		for j in ${VAR}
					do
						pdb_selchain -$j $f| grep ^"ATOM " >> $f"_2.pdb"
					done
	done

mv *_2.pdb /home/nitdgp-bt11/lab2/PDB_FINAL/Entity2
