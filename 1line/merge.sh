#! /bin/sh
for i in `echo *.c`; do
  perl ../../tool/1line/patch.pl $i
  mv $i.new $i
done
