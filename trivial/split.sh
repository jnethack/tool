#! /bin/sh
rm -rf ../../trivial
mkdir ../../trivial
for i in `echo *.c`; do
  perl ../../tool/trivial/split.pl $i
done
rm *.bak
