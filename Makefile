build: prepare
	compc -source-path=src -include-sources=src -optimize -output build/Away3d.swc

run: run-mobile

clean:
	/bin/rm -rf build

prepare:
	mkdir -p build
