// unload.gml
// https://rivalslib.com/workshop_guide/programming/reference/scripts/init_and_attack_scripts.html#unload-gml
// Runs at the end of each match.
// If you have ds_ data structures, destroy them here so they don't keep taking memory.



ds_list_destroy(sparkle_list);
ds_list_destroy(nspec_shot_list);