# Questo script si occupa di prelevare in modo random una immagine per cartella
#!/bin/bash
var=`ls -1|wc -l`
a=1
for dir in `ls -d */`
do
	for file in $(ls $dir|gshuf | grep -v / | tail -$a)
	do
	mv $dir/$file ../test/
	done
done
