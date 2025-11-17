#!/bin/bash
FILES="/home/nitdgp-bt11/lab2/PDB_FINAL/Entity1/*_1.pdb"
for f in $FILES
	do
		echo "running for"$f
		/home/nitdgp-bt11/lab/naccess_dir/naccess $f;
	done

mv *.asa /home/nitdgp-bt11/lab2/PDB_FINAL/Entity1/naccess_1/asa
mv *.rsa /home/nitdgp-bt11/lab2/PDB_FINAL/Entity1/naccess_1/rsa
mv *.log /home/nitdgp-bt11/lab2/PDB_FINAL/Entity1/naccess_1

#FILES="/home/nitdgp-bt11/lab1/ALL_PDB/Entity1/*"
#for f in $FILES
#	do
#	echo "running for"$f
#		/home/nitdgp-bt11/lab/naccess_dir/naccess $f;
#	done
#mv *.asa /home/nitdgp-bt11/lab1/ALL_PDB/naccess_1/asa
#mv *.rsa /home/nitdgp-bt11/lab1/ALL_PDB/naccess_1/rsa
#mv *.log /home/nitdgp-bt11/lab1/ALL_PDB/naccess_1

#FILES="/home/nitdgp-bt11/lab2/PDB_FINAL/Entity2/*_2.pdb"
#for f in $FILES
#	do
	#	echo "running for"$f
	#	/home/nitdgp-bt11/lab/naccess_dir/naccess $f;
#	done

#mv *.asa /home/nitdgp-bt11/lab2/PDB_FINAL/Entity2/naccess_2/asa
#mv *.rsa /home/nitdgp-bt11/lab2/PDB_FINAL/Entity2/naccess_2/rsa
#mv *.log /home/nitdgp-bt11/lab2/PDB_FINAL/Entity2/naccess_2
