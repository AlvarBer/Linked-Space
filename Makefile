web:
	@mkdir -p Build/Web
	godot --export "HTML5" Build/Web/index.html
	zip Build/Web/index.zip Build/Web/*

linux:
	@mkdir -p Build/Linux
	godot --export "Linux/X11" Build/Linux/linked_space.x86_64
	zip Build/Linux/linux.zip Build/Linux/*

itch: web linux
	butler push Build/Web/index.zip alvarber/linked-space:html
	butler push Build/Linux/linux.zip alvarber/linked-space:linux

clean:
	rm -rf Build/*
