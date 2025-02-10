SOUP is a level/"mission" editor for GameMaker Studio 2 games born out of my dislike for continually re-compiling my game to test levels.

The core idea of SOUP is that all level creation is handled "in-game," meaning that changes to levels can be tested on-the-fly instead of requiring a re-compilation of the game,
providing instant feedback on changes.

I initially started developing SOUP while working on a personal project by the name of Supermelon. However, I soon began to enjoy working on the editor more than the game, and so I have spun it off into its own project.

Currently, SOUP is unstable and under active development, and is absolutely not ready for practical use. I will be writing some documentation so that it is more usable once I am more confident it can be used regularly and all of the Supermelon-specific stuff has been removed. You are welcome to submit PRs if you are interested in contributing.

TODO:
* Robust saving/loading for tileset and objects (i.e, in such a way that objects can have callbacks to facilitate stuff like triggers)
* Objects editor
* Remove/rename Supermelon-specific stuff
* Modify current tileset palette in SOUP without having to use room editor
* Editor scripting language a la VVVVVV?