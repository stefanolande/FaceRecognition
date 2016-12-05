
for d in */ 
do
	echo $d
	cd $d
	##conta il numero di file 
	a=$(ls -1| wc -l)
	##disordina i file
	##sposta il 20 perc dei file
	a=$(($a*20/100));
	for file in $(ls -1|shuf | tail -n $a)
	do
		mv $file $HOME/test/
	done
	
	cd ..

done
