# Hierarchical task network example in Godot

This is the code source for my video on [Hierarchical Task Networks](https://youtu.be/Z7uU94yPfD4), a game AI pattern.

In this project there is a NPC implementation with the following behaviour:

- Roam
- Look at player if too close
- Get scared and run away if player jumps when close to them
- Get tired after running away 3 times and rest for a bit
- Collect coins when available

This is a sample project to validate HTNs, but it's not supposed to be production ready. Even though it works, there are a few caveats to consider as mentioned in the video.

By default, the project is going to run a scene with one NPC. You can run `HTN_main_multiple_agents.tscn` for a scene with multiple NPCs.

For this project, I used Kenney's 3D Platformer Starter Kit: https://github.com/KenneyNL/Starter-Kit-3D-Platformer

## Contact

I'm happy to chat about anything game dev and answer questions about my projects. Feel free to comment on the youtube video for questions and discussions about this project.

Check my website for the latest contact info: https://thisisvini.com

My youtube channel for game dev related stuff: https://www.youtube.com/@ThisIsVini

Currently, you can find me here:
- https://mastodon.gamedev.place/@thisisvini
- https://x.com/vini_gerevini

You can also open issues in this project, but keep in mind this is a sample, and even though I intend to keep it working, this is intended to be a demonstration for Godot 4 and I won't be expanding on it. Happy to chat about them though and discuss workarounds.
