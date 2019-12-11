#! /bin/sh
rm -rf ../../1line
mkdir ../../1line
for i in `echo *.c`; do
  perl ../../tool/1line/diff.pl $i
done
rm *.bak
