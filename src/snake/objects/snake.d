module snake.objects.snake;

import std.stdio;
import bindbc.sdl;

import engine.game_object;

import snake.grid;

enum Directions
{
	NONE,
	UP,
	LEFT,
	DOWN,
	RIGHT
}

class Snake : GameObject
{
	SDL_Rect[] snake_rects = [{0, 0, CELL_SIZE, CELL_SIZE}];
	SDL_Color color = {0, 255, 0, 255};

	Directions direction = Directions.NONE;
	Directions[] move_queue = [];

	vec2[] position;
	bool is_alive = true;
	bool should_grow = false;

	double move_timer = 0;
	double move_delay = 0.15;

	this()
	{
		position ~= vec2(GRID_WIDTH / 2, GRID_HEIGHT / 2);

		snake_rects[0].x = position[0].x * CELL_SIZE;
		snake_rects[0].y = position[0].y * CELL_SIZE;
	}

	~this()
	{
	}

	void grow()
	{
		should_grow = true;
	}

	void check_self_collide()
	{
		vec2 head = position[0];

		for (int i = 1; i < position.length; i++)
		{
			if (head.x == position[i].x && head.y == position[i].y)
			{
				is_alive = false;
				writeln("[INFO] Snake hit itself!");
				return;
			}
		}
	}

	void move()
	{
		if (direction == Directions.NONE)
			return;

		vec2 new_head = position[0];

		if (direction == Directions.UP)
			new_head.y -= 1;
		if (direction == Directions.DOWN)
			new_head.y += 1;
		if (direction == Directions.LEFT)
			new_head.x -= 1;
		if (direction == Directions.RIGHT)
			new_head.x += 1;

		if (new_head.x < 0)
			new_head.x = GRID_WIDTH - 1;
		if (new_head.x >= GRID_WIDTH)
			new_head.x = 0;
		if (new_head.y < 0)
			new_head.y = GRID_HEIGHT - 1;
		if (new_head.y >= GRID_HEIGHT)
			new_head.y = 0;

		if (should_grow)
		{
			position = new_head ~ position;
			snake_rects.length = position.length;
			should_grow = false;
		}
		else
			position = new_head ~ position[0 .. $ - 1];

		for (int i = 0; i < position.length; i++)
		{
			snake_rects[i].x = position[i].x * CELL_SIZE;
			snake_rects[i].y = position[i].y * CELL_SIZE;
			snake_rects[i].w = CELL_SIZE;
			snake_rects[i].h = CELL_SIZE;
		}

		check_self_collide();
	}

	override void update(double dt)
	{
		super.update(dt);

		move_timer += dt;

		if (move_timer >= move_delay)
		{
			move_timer = 0;
			if (move_queue.length > 0)
			{
				direction = move_queue[0];
				move_queue = move_queue[1 .. $];
			}
			move();
		}
	}

	override void render(SDL_Renderer* renderer)
	{
		super.render(renderer);

		SDL_SetRenderDrawColor(renderer, color.r, color.g, color.b, color.a);
		foreach (rect; snake_rects)
			SDL_RenderFillRect(renderer, &rect);
	}

	override void on_event(SDL_Event event)
	{
		if (event.type != SDL_KEYDOWN)
			return;
		if (move_queue.length >= 3)
			return;

		Directions last_queued = move_queue.length > 0 ? move_queue[$ - 1] : direction;

		switch (event.key.keysym.scancode)
		{
		case SDL_SCANCODE_W:
			if (last_queued != Directions.DOWN)
				move_queue ~= Directions.UP;
			break;
		case SDL_SCANCODE_A:
			if (last_queued != Directions.RIGHT)
				move_queue ~= Directions.LEFT;
			break;
		case SDL_SCANCODE_S:
			if (last_queued != Directions.UP)
				move_queue ~= Directions.DOWN;
			break;
		case SDL_SCANCODE_D:
			if (last_queued != Directions.LEFT)
				move_queue ~= Directions.RIGHT;
			break;
		default:
			break;
		}
	}
}
