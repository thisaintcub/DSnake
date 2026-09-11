module snake.scenes.game_scene;

import std.stdio;
import bindbc.sdl;

import engine.game;
import engine.scene;

import snake.objects.apple;
import snake.objects.snake;

import snake.scenes.game_over_scene;

class GameScene : Scene
{
	double timer = 0;

	Apple apple;
	Snake snake;

	this(Game game)
	{
		super(game);

		scene_id = "Game";

		snake = new Snake();
		add(snake);

		apple = new Apple(&snake);
		add(apple);
	}

	~this()
	{
	}

	override void update(double dt)
	{
		super.update(dt);

		if (snake.position[0] == apple.position)
		{
			writeln("[INFO] Ate the apple!");
			snake.grow();
			apple.random_pos(&snake);
		}

		if (!snake.is_alive)
			game.switch_scene(new GameOverScene(game));
	}

	override void render(SDL_Renderer* renderer)
	{
		super.render(renderer);
	}
}
