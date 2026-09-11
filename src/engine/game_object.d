module engine.game_object;

import bindbc.sdl;

class GameObject
{
	bool active = true;
	bool visible = true;
	bool alive = true;

	this()
	{
	}

	~this()
	{
	}

	void update(double dt)
	{
	}

	void render(SDL_Renderer* renderer)
	{
	}

	void on_event(SDL_Event event)
	{
	}
}
