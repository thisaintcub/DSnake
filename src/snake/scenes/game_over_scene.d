module snake.scenes.game_over_scene;

import std.stdio;
import bindbc.sdl;

import engine.game;
import engine.scene;

class GameOverScene : Scene {
	this(Game game) {
		super(game);

		scene_id = "Game Over";
	}

	~this() { }

	override void update(double dt) {
		super.update(dt);
	}

	override void render(SDL_Renderer* renderer) {
		super.render(renderer);
	}
}
