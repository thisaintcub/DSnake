# im just using make to make my life a little easier. you can avoid using it overall!
all: build copy_dlls

build:
	dub build --cache=local

copy_dlls:
	@echo "Copying SDL2 DLLs to bin/..."
	@mkdir -p bin/
	@cp /ucrt64/bin/SDL2.dll bin/ 2>/dev/null || echo "Warning: SDL2.dll not found"
	@cp /ucrt64/bin/SDL2_ttf.dll bin/ 2>/dev/null || true
	@cp /ucrt64/bin/SDL2_image.dll bin/ 2>/dev/null || true
	@cp /ucrt64/bin/SDL2_mixer.dll bin/ 2>/dev/null || true

test: all
	./bin/snake.exe

clean:
	dub clean
	rm -rf bin/ build/

cleanlibs:
	rm -rf .dub/

.PHONY: all build copy_dlls run clean cleanlibs
