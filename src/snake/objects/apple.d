module snake.objects.apple;

import std.stdio;
import std.random;
import std.algorithm;
import bindbc.sdl;

import engine.game_object;

import snake.grid;
import snake.objects.snake;

class Apple : GameObject
{
	SDL_Rect apple_rect = {0, 0, CELL_SIZE, CELL_SIZE};
	SDL_Color color = {255, 0, 0, 255};
	vec2 position;

	bool snake_overlap = false;

	this(Snake* snake)
	{
		random_pos(snake);
	}

	~this()
	{
	}

	void random_pos(Snake* snake)
	{
		writeln("[INFO] Moving the apple to new position...");

		do
		{
			position.x = uniform(0, GRID_WIDTH);
			position.y = uniform(0, GRID_HEIGHT);

			// overlapping check
			if (snake.position.canFind(position))
			{
				writeln("[INFO] Apple is in the snake! Finding new position...");
				snake_overlap = true;
			}
			else
			{
				writeln("[INFO] Moved apple to a new position!");
				snake_overlap = false;
			}
		}
		while (snake_overlap);

		apple_rect.x = CELL_SIZE * position.x;
		apple_rect.y = CELL_SIZE * position.y;
	}

	override void update(double dt)
	{
		super.update(dt);
	}

	override void render(SDL_Renderer* renderer)
	{
		super.render(renderer);

		SDL_SetRenderDrawColor(renderer, color.r, color.g, color.b, color.a);
		SDL_RenderFillRect(renderer, &apple_rect);
	}
}
