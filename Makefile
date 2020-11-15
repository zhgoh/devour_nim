all: 
	nimble build

install: 
	cp devour /usr/local/bin/devour

deinstall:
	rm /usr/local/bin/devour

.PHONY: clean

clean:
	rm devour
