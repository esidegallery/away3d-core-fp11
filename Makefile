build: prepare
	compc -source-path=src -include-sources=src -optimize -output build/Away3d.swc
	@afplay /System/Library/Sounds/Submarine.aiff &

run: run-mobile

clean:
	/bin/rm -rf build

prepare:
	mkdir -p build
