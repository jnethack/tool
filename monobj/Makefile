all: monstj.c objectsj.c

monstj.c: monst.c jtrnsmon.dat
	perl patchmonst.pl

objectsj.c: objects.c jtrnsobj.dat
	perl patchobject.pl

clean:
	rm monstj.c objectsj.c
