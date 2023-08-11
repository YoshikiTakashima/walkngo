#!/bin/bash

GO_FILE=$1
C_FILE=$(echo $GO_FILE | sed 's/go$/cpp/g')

/walkngo/walkngo -lang=c $GO_FILE | /walkngo/post-process-rewrites.sed > $C_FILE
echo 'int main() { return 0; }' >> $C_FILE

