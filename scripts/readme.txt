Script explanations: https://rivalslib.com/workshop_guide/programming/reference/scripts/

This folder contains all your character's scripts, code files that Rivals uses 
to assemble the character, or give it special behavior.

This template supplies empty files for most possible Rivals scripts, but 
*you don't need to use most of them!* They're just present for convenience.

The scripts you're likely to want to use are:
- Everything in `attacks\` to set up attack information. https://rivalslib.com/workshop_guide/programming/reference/scripts/init_and_attack_scripts.html#initializing-graphics
- `init.gml` to set your character's variables, like weight and speed. https://rivalslib.com/workshop_guide/programming/reference/scripts/init_and_attack_scripts.html#initializing-variables
- `load.gml` to properly align sprites (avoid weird floating or clipping through the stage). https://rivalslib.com/workshop_guide/programming/reference/scripts/init_and_attack_scripts.html#initializing-graphics
- `update.gml` for any special behavior that should run every frame. https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#every-frame
- `attack_update.gml` for any special behavior that should run only while attacking. https://rivalslib.com/workshop_guide/programming/reference/scripts/event_scripts.html#every-frame

The other scripts are for more niche usecases that you can learn as you need them.