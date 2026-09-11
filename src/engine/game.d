module engine.game;

import std.stdio;
import bindbc.sdl;
import delta_time;

import engine.window;
import engine.scene;
import engine.game_object;
import snake.scenes.game_scene;

class Game
{
	int screen_width, screen_height;
	string windows_title;
	double fps;
	bool running = true;

	this(int screen_width, int screen_height, string windows_title, double fps)
	{
		this.screen_width = screen_width;
		this.screen_height = screen_height;
		this.windows_title = windows_title;
		this.fps = fps;
	}

	~this()
	{
	}

	void run()
	{
		engine.window.init(screen_width, screen_height, windows_title);
		setMaxDeltaFPS(fps);

		switch_scene(new GameScene(this));

		SDL_Event event;

		while (running)
		{
			while (SDL_PollEvent(&event) != 0)
			{
				if (event.type == SDL_QUIT)
					running = false;

				if (event.type == SDL_KEYDOWN)
				{
					if (event.key.keysym.sym == SDLK_ESCAPE)
						running = false;
				}

				if (current_scene)
					current_scene.on_event(event);
			}

			calculateDelta();

			update(getDelta());
			render();
		}

		engine.window.exit();
	}

	Scene current_scene;

	void switch_scene(Scene new_scene)
	{
		writeln("[INFO] Switching scene...");
		current_scene = new_scene;
		writeln("[INFO] Switched scene! Current scene: ", current_scene.scene_id);
	}

	void update(double dt)
	{
		if (current_scene)
			current_scene.update(dt);
	}

	void render()
	{
		SDL_SetRenderDrawColor(renderer, current_scene.bg_color.r, current_scene.bg_color.g,
			current_scene.bg_color.b, current_scene.bg_color.a);

		SDL_RenderClear(engine.window.renderer);
		if (current_scene)
			current_scene.render(engine.window.renderer);
		SDL_RenderPresent(engine.window.renderer);
	}
}
