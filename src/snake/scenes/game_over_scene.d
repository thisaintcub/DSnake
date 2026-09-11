module snake.scenes.game_over_scene;

import std.stdio;
import bindbc.sdl;

import engine.game;
import engine.scene;

import snake.scenes.game_scene;

class GameOverScene : Scene
{
	this(Game game)
	{
		super(game);

		scene_id = "Game Over";
	}

	~this()
	{
	}

	override void update(double dt)
	{
		super.update(dt);
	}

	override void on_event(SDL_Event event)
	{
		if (event.type != SDL_KEYDOWN)
			return;

		switch (event.key.keysym.scancode)
		{
		case SDL_SCANCODE_RETURN:
			game.switch_scene(new GameScene(game));
			break;
		default:
			break;
		}
	}

	override void render(SDL_Renderer* renderer)
	{
		super.render(renderer);
	}
}
