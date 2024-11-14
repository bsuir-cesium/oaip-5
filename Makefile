default: bnr;


build:
	fpc src/DELPHI.dpr -obin/DELPHI.o

run:
	./bin/DELPHI.o
	
bnr:
	@echo "\n\n---===---\nbuilding... \n---===---\n\n"
	make build
	@echo "\n\n---===---\nbuild done \ntrying to run:\n---===---\n\n"
	make run