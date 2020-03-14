#! /bin/sh
for i in `echo *.c`; do
  perl ../../tool/trivial/patch.pl $i
  mv $i.new $i
done
