#!/bin/bash

GO_FILE=$1
C_FILE=$(echo $GO_FILE | sed 's/go$/transpiled.cpp/g')
TMP=tmp
/walkngo/walkngo -lang=c $GO_FILE | /walkngo/post-process-rewrites.sed > $TMP

# if file is empty, transpile failed.
if [ -s $TMP ]
then
	echo 'int main() { return 0; }' >> $TMP
	mv tmp $C_FILE
else
	rm $TMP
fi
