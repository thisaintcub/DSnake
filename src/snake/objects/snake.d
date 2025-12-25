module snake.objects.snake;

import std.stdio;
import bindbc.sdl;

import engine.game_object;

import snake.grid;

enum Directions {
	NONE,
	UP,
	LEFT,
	DOWN,
	RIGHT
}

class Snake : GameObject {
	SDL_Rect[] snake_rects = [ { 0, 0, CELL_SIZE, CELL_SIZE } ];
	SDL_Color color = { 0, 255, 0, 255 };

	Directions direction = Directions.NONE;
	vec2[] position;
	bool is_alive = true;
	bool should_grow = false;

	double move_timer = 0;
	double move_delay = 0.15;

	SDL_Event event;

	this() {
		position ~= vec2(GRID_WIDTH / 2, GRID_HEIGHT / 2);

		snake_rects[0].x = position[0].x * CELL_SIZE;
		snake_rects[0].y = position[0].y * CELL_SIZE;
	}

	~this() { }

	void grow() {
		should_grow = true;
	}

	void check_self_collide() {
		vec2 head = position[0];

		for (int i = 1; i < position.length; i++) {
			if (head.x == position[i].x && head.y == position[i].y) {
				is_alive = false;
				writeln("[INFO] Snake hit itself!");
				return;
			}
		}
	}

	void move() {
		if (direction == Directions.NONE) return;

		vec2 new_head = position[0];

		if (direction == Directions.UP) new_head.y -= 1;
		if (direction == Directions.DOWN) new_head.y += 1;
		if (direction == Directions.LEFT) new_head.x -= 1;
		if (direction == Directions.RIGHT) new_head.x += 1;

		if (new_head.x < 0) new_head.x = GRID_WIDTH - 1;
		if (new_head.x >= GRID_WIDTH) new_head.x = 0;
		if (new_head.y < 0) new_head.y = GRID_HEIGHT - 1;
		if (new_head.y >= GRID_HEIGHT) new_head.y = 0;

		if (should_grow) {
			position = new_head ~ position;
			snake_rects.length = position.length;
			should_grow = false;
		} else
			position = new_head ~ position[0 .. $-1];

		for (int i = 0; i < position.length; i++) {
			snake_rects[i].x = position[i].x * CELL_SIZE;
			snake_rects[i].y = position[i].y * CELL_SIZE;
			snake_rects[i].w = CELL_SIZE;
			snake_rects[i].h = CELL_SIZE;
		}

		check_self_collide();
	}

	override void update(double dt) {
		super.update(dt);

		const ubyte* keystate = SDL_GetKeyboardState(null);

		if (keystate[SDL_SCANCODE_W] && direction != Directions.DOWN)
			direction = Directions.UP;
		if (keystate[SDL_SCANCODE_A] && direction != Directions.RIGHT)
			direction = Directions.LEFT;
		if (keystate[SDL_SCANCODE_S] && direction != Directions.UP)
			direction = Directions.DOWN;
		if (keystate[SDL_SCANCODE_D] && direction != Directions.LEFT)
			direction = Directions.RIGHT;

		move_timer += dt;

		if (move_timer >= move_delay) {
			move_timer = 0;
			move();
		}
	}

	override void render(SDL_Renderer* renderer) {
		super.render(renderer);

		SDL_SetRenderDrawColor(renderer, color.r, color.g, color.b, color.a);
		foreach (rect; snake_rects)
			SDL_RenderFillRect(renderer, &rect);
	}
}
