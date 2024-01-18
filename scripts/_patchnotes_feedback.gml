
/*Patch Notes and Feedback; Im gonna be using this to document random feedback i get and eventually compile patch notes on here.

Changes (Pre release):
+ Jab 1/2 lifetime 2 -> 3
- DAttack startup 4 -> 9
- DTilt's forward reach decreased to better match visual
+ Bulletless FStrong endlag 31(46) -> 18(27)
+ Standard FStrong endlag 31(46) -> 28(42)
= UStrong stats standardized between skull + no skull variants
+ NAir 1 lifetime 2 -> 4
+ NAir 1 angle 40 -> 50 (experimental, this is a major buff)
+ BAir startup 16 -> 14
+ Dspecial endlag 45 -> 30 (yes)
= DSpecial max fall speed 3 -> 4, air accel 0 -> 0.2
- Pratland time 15 -> 20
- Pratfall accel .85 -> .4
- FSpec: 45f cooldown added upon safely returning to desperado
- FSpec-2: Skull pop startup 10+0 -> 10+8
- Skull: Respawn time 60->75 frames
- Skull: Penalty respawn time 90 -> 120 frames
+ Skull NSpec: Locked-in prefire duration 20->10 frames

Changes (1.1, Dec 26):

-Bugfixes/Adjusts: 
	-Fixed seasonal costume appearing on respawn.
	-Removed unnecessary debug text.
	-Added a target visual on NSpecial (HEADSHOT).
	-Added notification for practice mode's reload shortcut.
	-Adjusted HUD Colors to hopefully be more intuitive across all color palettes, with default adjusted aswell.
	
-Buffs:
	-NSpecial (HEADSHOT) no longer pauses tracking early while the opponent is in hitstun, making it way more reliable.
	-NSpecial (Desperate Measures) final hit KBG has been increased (0.75 to 1.0 -> 0.9 to 1.15).
		-This change makes the move much more effective at late percents for sealing out kills.
		-BKB has been left unchanged (8.25 to 9.5, depending on the number of bullets shot).
	-FStrong startup decreased (24 -> 21)
	-Desperado's Heart size increased (1 -> 3)
	
-Nerfs:
	-Opponents hitting the skull now cause Desperado to take 1% self damage.
	-Nspecial (HEADSHOT) now deals 1% self damage per bullet shot.
	-NSpecial is now limited to one use per airtime (unless refreshed with a DSpecial reload).
		-This is intended to prevent stalling with zero bullets; any usage of NSpecial with bullets should be unaffected.
	-Nair 1 Hitstun Multiplier lowered (.8 -> .7)
	-Nair 1 Startup increased (5 -> 6)
	-Nair 1 KBS Increased (.1 -> .2)
	-Uair landing lag increased (4 -> 5)
	-DSpecial max hsp lowered (3 -> 2)
	-Fspecial damage decreased (3, 4 -> 2, 3)

Changes (1.15, Dec 31)

-Bugfixes/Adjusts:
	-Fixed collision bugs with up b grabbing the skull.
	-Fixed HUD elements breaking when hit out of certain attacks.
	-Changed Forward Special skulls return trajectory when angled up.
		-Small, but should make it a little bit easier to use HEADSHOT.
-Buffs:
	-Increased the size of the final hit of Scorching Forward Tilt, to prevent the move from dropping when above Desperado.
	-Skull no longer gets destroyed when making contact with attacks that deal 0 hitstun. 
		-Technically a bug, but more of a fix.
-Nerfs:
	-Reverted N-Special's KB scaling changes from last patch as they were unnecessary and overboard after initial feedback.
	-Desperado's Heart size decreased (3 -> 1)
		-His christmas tree burned down.

Changes (1.16, Jan 8)

-Happy new year!
-Bugfixes/Adjusts:
	-Fixed sfx playing longer than they should when hit out of certain moves.
	-Jab no longer gives you a bullet if the first hit is parried and you finish the move.
	-If you win the game without a skull, your portrait will be changed to reflect this.

Nerfs:
	-Reduced lerping effect on Fair (40% -> 20%) to make the move look and feel more natural.
	-Reduced hitbox sizes on all 3 hits of jab 
	-Reduced N-Airs hitbox size and brought it closer to the body. It shouldnt be very disjointed at all now.
Buffs:
	-Increased hitbox on Desperate Measures slightly below the gun fire- It was whiffing on some extra tiny characters like Kirby (Spam), but still shouldnt hit most crouches.
	-Corrected one of Back Airs hitboxes being slightly weaker than the others.
	-Back air knockback scaling increased (.6 -> .7). Affects both versions, but tipper stats on Scorched Bair are unchanged.

Changes (1.2, Jan 14)

-Last patch before deadline ends (unless something important comes up). Makes a few pretty major changes that reel his kit back and make him feel more fun to fight while keeping the essence of what i want the character to do.
-Bugfixes/Adjusts:
	-Fixed up strong using Burn Stun effect (dont ask).
	-Added some extra notes for the Woodcock.
	-Fixed eye glowing when using N-Special skulless.
	-Fixed eye glow showing up in the wrong spot while moving.
	-Fixed up strong using the wrong hurtbox index without a skull.
	-Fixed skull occasionally getting stuck (hopefully).
	-Fixed Skulless DAttack having wildly varied startup from skull DAttack.
	
-Nerfs:
	-Removed the automatic Pop when the skull returns to Desperado after using F-Special.
		-It felt like a bit overkill for the move, and it incentivized running away and mashing it whenever its off cooldown.
		-This change should hopefully add more pressure for Desperado to be thoughtful using F-Special.
	-FStrong (Empowered) Base knockback reduced from 10.5 to 9.5. Scaling reduced from 1.25 to 1.2. 
		-Oops! If this is still too powerful, I can tune it down more post-patch. I do want it to stay as one of the strongest options in the game though, its very slow/laggy and uses a bullet.
	-Fair last hit now has a hitstun multiplier of .85, to make it a bit easier to escape.
	-Dattack gatling removed.
		-This was extremely niche. Too niche.
	-Desperate Measures now has extended parrystun instead of normal parrystun.
		-i thought they were the same not gonna lie 
-Buffs: 
	-Dattack startup reduced, 9 -> 6.
	-Dattack second hit angle adjusted, 65 -> 80.
		-This move was underperforming pretty hard, so the startup was reduced a bit and it got a different angle to hopefully promote it being used a bit more, especially to compensate with the loss of the gatling.
	-Fspecial manual detonation startup reduced, 10 -> 7. 
		-Since the autodet got removed, this has been added just to promote it being used a little more, and make it a more generous.
		
Changes (1.25, Jan 18th)
	-Pre-GENESIS patch to get the character into a slightly better spot (Though really, I just need to fix the hitstun gravity). 
	-Added a GENESIS alt. 
-Buffs:
	-Hitstun Grav .4 -> .48
		-This was an oversight. It was way too extreme before, meaning Desperado would die much earlier than expected off the top, getting galaxied at ludicrously low percents.
		-He should feel much more like an average lightweight, and not an extreme one.