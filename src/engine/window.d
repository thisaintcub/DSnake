module engine.window;

import std.stdio;
import std.string;
import bindbc.sdl;

SDL_Window* window;
SDL_Renderer* renderer;

int init(int screen_width, int screen_height, string windows_title)
{
	writeln("[INFO] Starting SDL2...");
	SDLSupport ret = loadSDL();
	if (ret != sdlSupport)
	{
		if (ret == SDLSupport.noLibrary)
		{
			writeln("[ERROR] SDL2 library not found!");
			return -1;
		}

		if (ret == SDLSupport.badLibrary)
		{
			writeln("[ERROR] Incompatible SDL2 library version.");
			return -1;
		}
	}

	SDL_version ver;
	SDL_GetVersion(&ver);
	writefln("[INFO] SDL2 version: %d.%d.%d", ver.major, ver.minor, ver.patch);

	writeln("[INFO] Initializing SDL2...");
	if (SDL_Init(SDL_INIT_VIDEO) < 0)
	{
		writeln("[ERROR] Failed to initialize SDL2:", SDL_GetError());
		return -1;
	}

	writeln("[INFO] Creating SDL2 window...");
	window = SDL_CreateWindow(
		windows_title.toStringz(),
		SDL_WINDOWPOS_CENTERED,
		SDL_WINDOWPOS_CENTERED,
		screen_width,
		screen_height,
		SDL_WINDOW_SHOWN
	);

	if (!window)
	{
		writeln("[ERROR] Failed to create SDL window:", SDL_GetError());
		SDL_Quit();

		return -1;
	}

	writeln("[INFO] Window created successfully!");

	renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
	if (!renderer)
	{
		writeln("[ERROR] Failed to create renderer:", SDL_GetError());
		SDL_DestroyWindow(window);
		SDL_Quit();

		return -1;
	}

	return 1;
}

void exit()
{
	SDL_DestroyRenderer(renderer);
	SDL_DestroyWindow(window);
	SDL_Quit();
}
