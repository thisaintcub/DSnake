import std.stdio;

import engine.game;

void main()
{
	Game game = new Game(640, 480, "Snake", 60);
	game.run();
}
