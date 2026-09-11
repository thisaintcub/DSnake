module engine.scene;

import delta_time;
import bindbc.sdl;

import engine.game;
import engine.game_object;

class Scene
{
	GameObject[] objects;

	string scene_id = "Template";
	SDL_Color bg_color = {0, 0, 0, 255};

	Game game;

	this(Game game)
	{
		this.game = game;
	}

	~this()
	{
	}

	void update(double dt)
	{
		foreach (obj; objects)
			if (obj.active)
				obj.update(dt);

		GameObject[] alive_objects;

		foreach (obj; objects)
			if (obj.alive)
				alive_objects ~= obj;

		objects = alive_objects;
	}

	void render(SDL_Renderer* renderer)
	{
		foreach (obj; objects)
			if (obj.visible)
				obj.render(renderer);
	}

	void on_event(SDL_Event event)
	{
		foreach (obj; objects)
			obj.on_event(event);
	}

	void add(GameObject obj)
	{
		objects ~= obj;
	}
}
