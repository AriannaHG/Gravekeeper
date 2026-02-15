id is 3209585448

Skills: (note: Rot does damage equal to stack size when affected unit's turn ends, removed by any generic cure)



AVaffecter should inflict an invisible AV that is positive and is not removable.

It should call the action (the afflicted unit is the caster) 

fReq on stage 1 actionaoe so that it can't be cast on units already suffering from it

Necrotize = no magnitude of av as it's based on caster max hp 

Bestow Ruin: 
magnitude of AV = amount of damage done - flat, based on caster ruin skill

length of ruin enchantment is also flat and based on caster ruin skill



Saudade as name of one of the abilities


Saudade



[Action] ID=Sa_dispel; 
	name=Dispel;
	icon=icon_Sa_dispel;
	mpCost=3 * d:mpCostMult * d:mpCostMult_onlyWithCT + d:mpCostMod_onlyWithCT + d:mpCostMod;
	chargeTime=7 * d:chargeTimeMult * d:chargeTimeMult_onlyWithMP + d:chargeTimeMod + d:chargeTimeMod_onlyWithMP ;
	tooltip=Remove all status effects (positive or negative) and cancel magic in a small area.;
	rankUpTooltip=Each rank adds +1 range.;
	tooltipTopRight=;
	
	XPCost=150;
	XPCost=350;
	XPCost=500;
	
	special=requiresCasting;
	casterAnimation=spellcast;
	maxRank=3;
	canExceedMaxRankBy=1;
	
	FXOnCaster=magicCharge;
	FXOnCaster=chargeFast;
	FXOnCasterColor=SkyBlue;
	FXOnCaster=sfx_risingBipLow;
[ActionAoE] 
	ID=Sa_dispel; 
	needsLoS = false;
	needsLoE = false;
	minRange = 0;
	maxRange = 3;
	maxRangeBonus = c:rank;
	airborne=true;
	arc=true;
	bypassAll=true;
	occupyAll=true;
[AvAffecter]
	ID=Sa_dispel; 
	actorValue=dispel;
	magnitude=100;
	duration=-2;
	chance=100;
	element=magic;
	element=dispel;
	FXOnTile=vertLines;
	FXOnTileColor=SkyBlue;
	FXOnTile=bipFlutter;
	FXOnHit=ping;
	FXOnHitColor=SkyBlue;
	FXOnHit=briefAuraSound_wahwah;
[AvAffecterAoE]
	ID=Sa_dispel;
	cloneFrom=adjacentAndSelf;



are you making the dispelling action, or a passive ability that protects only from interruption
for the former lua could dispel effects without interrupting
for the latter, the way "dispel" interruption is hardcoded so can't think of a way
Shanakor
 — 
4:20 AM
I was planning to make the latter haha
rip
quo
 — 
4:21 AM
and since casting an ability involves "casting" av which is dispellable... again that's something lua can go around from the dispeller side, but not really from the dispellee





[Action] ID=Ro_distract; 
	name=Distraction;
	icon=icon_Ro_distract;
	tooltip=Turn an enemy around and cancel their spellcasting.;
	rankUpTooltip=Each rank adds +1 range.;
	tooltipTopRight=<icon=ranged_small>;
	
	attractAttention=false;
	
	XPCost=80;
	XPCost=150;
	XPCost=500;
	
	AIRatingBias = -2;
	
	casterAnimation=swing;
	
	maxRank=3;
	canExceedMaxRankBy=1;
[ActionAoE] 
	ID=Ro_distract; 
	needsLoS = true;
	needsLoE = true;
	minRange = 1;
	maxRange = 2;
	maxRangeBonus = c:rank;
	airborne=true;
	bypassAll=true;
	occupyAll=true;
[AvAffecter]
	ID=Ro_distract; 
	actorValue=rotate;
	magnitude=180;
	duration=-2;
	chance=c:Acc * 100 + m:cHighestRangedSkill * 5 - t:MagEva;
	FXOnTile=line;
	FXOnTile=swing;
	FXOnHit=question;
	FXOnHit=ting;
	FXOnHit=chk;
[AvAffecterAoE]
	ID=Ro_distract;
	cloneFrom=oneTile;
[AvAffecter]
	ID=Ro_distract; 
	visibleMiss = false;
	actorValue=cancel;
	magnitude=1;
	chance=c:Acc * 210 * m:tCancel + c:skill_Aim - t:MagEva - 100;
	duration=-2;
[AvAffecterAoE]
	ID=Ro_distract;
	 cloneFrom=oneTile;



[SupportAbilityReaction]
ID=pureMind; actorValues=dispel; actorValues=charging; actorValues=casting; actorValues=cancel; damageMultiplier=0;

[Action] ID=Gu_discipline; 
	name=Discipline;
	icon=icon_Gu_discipline;
	tooltip=Through sheer fortitude, cure negative status effects.;
	rankUpTooltip=Each rank increases area of effect.;
	tooltipTopRight=;
	
	harmful=false;
	attractAttention=false;
	
	XPCost=70;
	XPCost=250;
	XPCost=700;
	
	maxRank=3;
	canExceedMaxRankBy=1;
	casterAnimation=charge_alt;
	
	FXOnTarget=largePing;
	FXOnTarget=sfx_risingBipLow;
[ActionAoE] 
	ID=Gu_discipline; 
	cloneFrom=oneTile;
[AvAffecter]
	ID=Gu_discipline;
	harmful=false;
	actorValue=cure;
	magnitude=1;
	duration=-2;
	chance=100 * m:tCurable;
	FXOnTile=sparkle;
	FXOnHit=sparklesFast;
	FXOnHit=briefAuraSound;
[AvAffecterAoE]
	ID=Gu_discipline;
	cloneFrom=oneTile;	
	canSelectEnemies=false;
	maxRangeBonus=c:rank - 1;

[Action] ID=Gu_mightyBlock; 
	name=Mighty Block;
	icon=icon_Gu_mightyBlock;
	tooltip=Make an ally nearly invulnerable to physical attacks until their next turn.;
	rankUpTooltip=;
	tooltipTopRight=;
	
	harmful=false;
	attractAttention=false;
	mpCost=2 * d:mpCostMult + d:mpCostMod;
	
	XPCost=120;
	
	casterAnimation=charge_alt;
	maxRank=1;
	
	AIRatingBias = -999;
	

[ActionAoE] 
	ID=Gu_mightyBlock;
	cloneFrom=adjacentAndSelf;
	canSelectEnemies=false;
[AvAffecter]
	ID=Gu_mightyBlock;
	harmful=false;
	actorValue=PhysDef;
	magnitude=3 + dMin0:mightyBlockDef;
	duration=-3;
	chance=100;
	FXOnTarget=shields;
	FXOnTargetColor=Gold;
	FXOnTarget=sfx_sliceShingLow;
[AvAffecterAoE]
	ID=Gu_mightyBlock;
	cloneFrom=oneTile;
[AvAffecter]
	ID=Gu_mightyBlock;
	harmful=false;
	visibleEvaluations=false;
	actorValue=PhysAtk;
	magnitude=-2;
	duration=-3;
	chance=100;
[AvAffecterAoE]
	ID=Gu_mightyBlock;
	cloneFrom=oneTile;
[AvAffecter]
	ID=Gu_mightyBlock;
	harmful=false;
	visibleEvaluations=false;
	actorValue=recentlyBlocked;
	magnitude=1 + c:recentlyBlocked;
	duration=110;
	chance=100;
[AvAffecterAoE]
	ID=Gu_mightyBlock;
	cloneFrom=oneTile;

[SupportAbility] ID=shana_hatredbeyondmeasure;
name=Hatred Beyond Measure;
tooltip=Gain immunity to casting interruption, most disabling effects, and Dispel. Furthermore, effects based off your maximum <icon=HP> are 2% as effective on you.;
icon=iconP_Sa_pureMind; --todo art
XPCostUnlock=80;
[SupportAbilityReaction]
ID=shana_hatredbeyondmeasure; actorValues=dispel; actorValues=charging; actorValues=casting; actorValues=cancel; damageMultiplier=0;
[SupportAbilityReaction]
ID=shana_hatredbeyondmeasure; actorValues=HPbased; damageMultiplier=0.02;



--Heart of the Corruption (name pending)
--retaliates by spawning abscesses when hit, keystone army


[SupportAbility] ID=shana_Todestrieb;
name=Todestrieb;
tooltip=When hit into critical condition for the first time, inflict 10 stacks of Rot<icon=icon_gravekeeper_rot> to all enemies and cure all negative status effects on self, then gain Negate, Aegis and Mighty Block for 999 <icon=time>. <icon=HP> does not drop below 25% before this occurs, and when it does...;
icon=icon_Gu_mightyBlock; --todo art

[SupportAbilityReaction] --at zone entry for the first time, gain unkillable. todo: wording, alternative solution?
ID=shana_Todestrieb; actorValues=combatStart; actorValues=combatEnd; actorValues=enterZone; action=shana_todestrieb_becomeunkillable;

[SupportAbilityReaction] --buffs boss defensively but makes it killable when hit into critical, only works when unkillable.
ID=shana_Todestrieb; actorValues=HP; action=shana_todestrieb_reaction;


--Modified Salvation status from Prominence.

[Action] ID=shana_todestrieb_becomeunkillable;
	name=TodestriebUnkillable;
	icon=icon_Gu_mightyBlock;
	tooltip=This makes the boss unkillable, essentially resetting its enrage if the player somehow leaves midfight.;	
	harmful=false;
	attractAttention=false;
	XPCost=70;
	maxRank=1;
	casterAnimation=charge_alt;
	FXOnTarget=largePing;
	FXOnTarget=sfx_risingBipLow;
[AvAffecter]----------------------------------------------------------these two AvAffecters makes the target unkillable
	ID=shana_todestrieb_becomeunkillable; 
	harmful=false;
	actorValue=trigger;
	magnitude=setGlobalVar_toActorID,salvationTarget,False,False;
	duration=1;
	chance=100;
	FXOnHit=pop;
[AvAffecterAoE]
	ID=shana_todestrieb_becomeunkillable;
	cloneFrom=oneTile;
[AvAffecter]
	ID=shana_todestrieb_becomeunkillable; 
	harmful=false;
	actorValue=task;
	magnitude=setActorBool,@GsalvationTarget,unkillable,1,True,False,False,False;
	duration=-2;
	chance=100;
	FXOnHit=pop;
[AvAffecterAoE]
	ID=shana_todestrieb_becomeunkillable;
	cloneFrom=oneTile;






[Action] ID=shana_todestrieb_reaction;
	name=Todestrieb;
	icon=icon_Gu_mightyBlock;
	tooltip=Inflict 10 stacks of Rot<icon=icon_gravekeeper_rot> to all enemies and cure all negative status effects on self, then gain Negate, Aegis and Mighty Block for 999 <icon=time>, then make self killable.;	
	harmful=false;
	attractAttention=false;
	XPCost=70;
	maxRank=1;
	casterAnimation=charge_alt;
	FXOnTarget=largePing;
	FXOnTarget=sfx_risingBipLow;
	special=usableEvenWhenCantAct;
	special=usableEvenWhenReacting;
	special=usableEvenWhenYourTurn;
	queueAnotherAction=shana_todestrieb_reaction2;
	fReq_queueAnotherAction=100 * c:unkillable * m:tCritical;
[ActionAoE] 
	ID=shana_todestrieb_reaction; 
	cloneFrom=oneTile;
[AvAffecter] ----------------------------------Dummy AV to see if it should go off or not.
	ID=shana_todestrieb_reaction;
	harmful=false;
	chance=100 * c:unkillable * m:tCritical;
	FXOnTile=sparkle;
	FXOnHit=sparklesFast;
	FXOnHit=briefAuraSound;
[AvAffecterAoE]
	ID=shana_todestrieb_reaction;
	cloneFrom=oneTile;	
[AvAffecter] ----------------------------------Rot.
	ID=shana_todestrieb_reaction;
	actorValue=ari_rot_status_enemy;
	magnitude=t:ari_rot_status_enemy + 10 * rxn:ruin;
	duration=80;
	chance=100 * thisPreviousAVHit:shana_todestrieb_reaction;
	FXOnTileColor=Green;
	FXOnTile=chargeFast_overlap;
	FXOnTileColor=Black;
	FXOnTile=chargeFast_overlap;
	FXOnTileColor=Green;
	FXOnTile=chargeSpiralFast_big;
	FXOnTileColor=Green;
	FXOnTile=chargeSpiralFast_big;
    FXOnTileColor=Black;
	FXOnHit=downwardLinesQuick;
	FXOnHitColor=DarkGreen;
[AvAffecterAoE]
	ID=shana_todestrieb_reaction;
	shape=7;
	airborne=true;
	arc=true;
	bypassAll=true;
	occupyAll=true;
	canSelectAllies=false;

[AvAffecter] ----------------------------------Cure.
	ID=shana_todestrieb_reaction;
	harmful=false;
	actorValue=cure;
	magnitude=1;
	duration=-2;
	chance=100 * thisPreviousAVHit:shana_todestrieb_reaction;
	FXOnTile=sparkle;
	FXOnHit=sparklesFast;
	FXOnHit=briefAuraSound;
[AvAffecterAoE]
	ID=Gshana_todestrieb_reaction;
	cloneFrom=oneTile;	

[AvAffecter] -----------------------------------Negate.
	ID=Wrd_negate; 
	actorValue=negate;
	harmful=false;
	magnitude=1;
	duration=999;
	chance=100 * thisPreviousAVHit:shana_todestrieb_reaction;
	element=magic;
	FXOnTile=chargeFast;
	FXOnTileColor=White;
	FXOnHit=square16_shine_big;
	FXOnHitColor=White;
	FXOnHit=square16_shine_big;
	FXOnHitColor=White;
	FXOnHit=sfx_crystallize_fast;
[AvAffecterAoE]
	ID=Wrd_negate;
	cloneFrom=oneTile;

[AvAffecter] -----------------------------------Aegis.
	ID=shana_todestrieb_reaction; 
	actorValue=aegis;
	harmful=false;
	magnitude=1;
	duration=999;
	chance=100 * thisPreviousAVHit:shana_todestrieb_reaction;
	element=magic;
	element=life;
	FXOnTile=chargeFast;
	FXOnTileColor=White;
	FXOnHit=ward;
	FXOnHitColor=White;
	FXOnHit=guard;
	FXOnHitColor=White;
	FXOnHit=sfx_powerup2;
[AvAffecterAoE]
	ID=shana_todestrieb_reaction;
	cloneFrom=oneTile;

[AvAffecter] ------------------------------------Mighty Block.
	ID=shana_todestrieb_reaction;
	harmful=false;
	actorValue=PhysDef;
	magnitude=3 + dMin0:mightyBlockDef;
	duration=999;
	chance=100 * thisPreviousAVHit:shana_todestrieb_reaction;
	FXOnTarget=shields;
	FXOnTargetColor=Gold;
	FXOnTarget=sfx_sliceShingLow;
[AvAffecterAoE]
	ID=shana_todestrieb_reaction;
	cloneFrom=oneTile;
[AvAffecter]
	ID=shana_todestrieb_reaction;
	harmful=false;
	visibleEvaluations=false;
	actorValue=PhysAtk;
	magnitude=-2;
	duration=999;
	chance=100 * thisPreviousAVHit:shana_todestrieb_reaction;
[AvAffecterAoE]
	ID=shana_todestrieb_reaction;
	cloneFrom=oneTile;
[AvAffecter]
	ID=shana_todestrieb_reaction;
	harmful=false;
	visibleEvaluations=false;
	actorValue=recentlyBlocked;
	magnitude=1 + c:recentlyBlocked;
	duration=999;
	chance=100 * thisPreviousAVHit:shana_todestrieb_reaction;
[AvAffecterAoE]
	ID=shana_todestrieb_reaction;
	cloneFrom=oneTile;





[Action] ID=shana_todestrieb_reaction2;
	name=Todestrieb2;
	icon=icon_Gu_mightyBlock;
	tooltip=Second part of todestrieb reaction;	
	harmful=false;
	attractAttention=false;
	XPCost=70;
	maxRank=1;
	casterAnimation=charge_alt;
	FXOnTarget=largePing;
	FXOnTarget=sfx_risingBipLow;
	special=usableEvenWhenCantAct;
	special=usableEvenWhenReacting;
	special=usableEvenWhenYourTurn;

[AvAffecter] ------------------------------------Set HP back to a quarter of max hp.
	ID=shana_todestrieb_reaction2;
	harmful=false;
	visibleEvaluations=false;
	actorValue=HP;
	magnitude=-c:HP + c:HPMax * 0.25;
	duration=-2;
	chance=100;
[AvAffecterAoE]
	ID=shana_todestrieb_reaction2;
	cloneFrom=oneTile;
[AvAffecter]----------------------------------------------------------these two AvAffecters return the boss to a killable state
	ID=shana_todestrieb_reaction2; 
	harmful=false;
	actorValue=trigger;
	magnitude=setGlobalVar_toActorID,salvationTarget,False,False;
	duration=1;
	chance=100;
	FXOnHit=pop;
[AvAffecterAoE]
	ID=shana_todestrieb_reaction2;
	cloneFrom=oneTile;
[AvAffecter]
	ID=shana_todestrieb_reaction2; 
	harmful=false;
	actorValue=task;
	magnitude=setActorBool,@GsalvationTarget,unkillable,0,True,False,False,False;
	duration=-2;
	chance=100;
	FXOnHit=pop;
[AvAffecterAoE]
	ID=shana_todestrieb_reaction2;
	cloneFrom=oneTile;

--todo see if can use actorbool in freq, if it does then can make freq for horizons grave that is "is killable" and give it 9999 aivalue.






Attach a dialogue to this.


Snowball

varmint sprite but rotting

supported by 5 mini abscesses/amalgams at pentagram edges/strategic points if abscess, should have 999 hp (arena is a pentagram carved out of a copse of trees, it's maybe 8 tiles radius? maybe a bit more? shouldn't be that big)

10 tta (yes), 1 movement (you fucking die if it gets close but it's not gonna do the flash (tm))

600ish hp, undead, blah blah you get the idea (RUIN)

only melee attacks


Counter teleport (yes ^2)

some ability that gives it 66% hp% damage resistance (which will make hp based dot deal the same dps as vs a normal enemy i think) and immunity to -move abilities.

some ability that has to do with breeding, will spawn a 2hp copy of itself everytime it's hit and at half health it will spawn 4 2 hp copies of itself instead, also kills all allies when it dies

Break Weapon

Break Armor

Rotting Pus (massive rot + blind + full demoralize @ melee range)

devour (as per subsume in furdabip.txt, does minor damage and removes target from battle if it was already dead or it was killed by the minor hit, will need to implement aimod reaction)



(The husk stares at you with haunted eyes as it advances against its will.)

(You have a strong feeling it's begging you to run, but that's no longer possible.)

(As the husk disintegrates, it looks to you with relief in its eyes. All that's left is the collar it was wearing.)



Missing Poster

Have you seen my bun, Snowball? He's small, white and fluffy, and has a collar on his neck. He's been missing since last week. If anyone helps me find him, I'll give you ~~120~~ 240 <gold> and bake you ~~some~~ a lot of sweets.

-Susie

(put a note on a door saying her pet is gone, can't give much reward.)


many holes in the arena terrain, filth everywhere (imply rabbit is depressed), except for a spot with a gravestone, pristine in the corner. digging it gives bones and a note saying her pet went missing and she's trying to look for it

Crumpled Page

I know everyone's supposed to stay indoors at night, but Snowball's still missing and my parents aren't doing anything to help! Nobody's helping! I'm gonna sneak out and look for him. We used to play together in that old clearing...

I miss you, Snowball. Please don't be sick like the others.




Undead Amalgam

Rarity 4?
An unstable mound of reeking flesh, responsible for sustaining the unliving population of Old Barrow. The inexplicable use of Gate magic allows them to cast ruinous, battlefield-altering spells from any distance with perfect tracking. Being overfilled with Essence while channeling several different types of magic, however, does tend to have its drawbacks...


An ambulatory trigger stone the size of an average Falpa's fist, ensconced between two sets of wickedly sharp teeth dripping reeking bile and garnished with tentacles like the world's worst sandwich. These unliving artillery pieces use Gate magic to cast ruinous, battlefield-altering spells from any distance with perfect tracking, and are even capable of weaponizing what passes for their reproductive cycle.<n=>Being overfilled with Essence while channeling several different types of magic tends to have rather severe drawbacks, however...

--make them drop essence gems



spawns abscesses when enemies are close?

Bestow Ruin --todo make it crewmember targeting only

Subsume -- large single target damage scaling off rot that removes corpses

Rotting Prison
Tracks the target. Deals X (minor) damage to the target and all adjacent, then spawns an Undead Abscess in each unoccupied tile. Range should be something like 4-8? Usable once per combat, via mana cost and a large ai incentive to cast it if someone's in range

Basic Attack
 


Undead Abscess

Rarity 2


--make them drop essence crystals

nonglobal range, simple targeting

Defiler-ish spells that take advantage of gravekeeeper and normal effects?

Rotting Pus that inflicts Rot + Itchy + Bad Morale. High ai mod if in range.

Rot, Itchy and Drowsy spell (Sleeping Sickness)

Rot, Delirium and Madness spell (Psychenecrosis)

Rot, Blind spell (Putrefy Vision)

all spells are based off defiler and have similar damage/cast times

action to look for is shana_RottingPus;



if nothing is in range, selfdestructs for big healing/buffs to enemies globally, with something like 60-80 cast time 

6 healing, and the other two buffs like bequeath?

change critical bequeath

actually implement the enemy

Normal: Sleeping Sickness (slower cast, more rot), Psychenecrosis (faster cast, less rot, madness+delirium)

Summoned: Rotting Pus (this is melee), Putrefy Vision (this is 3 range spell with sleeping sickness rot gen that also blinds), Bequeath Self

I would also recommend finding whatever animations are used for the ActorType whose sprite you want to check, then referencing it in the hardcoded animation dump, to see which frames get used and for what; https://furdabip.com/hg/hgmr/hcd/Animation%20and%20Keyframe.txt

rotting pus: 114/105/36

Barriers: make different variant for each boss, with bow/book/grimoire on them.

implement a check for Festering Fulcrum to always miss player faction

Ruin gate fx

	FXOnTile=sfx_higherHum;
	FXOnTile=horizSpark_many_wideArea;
	FXOnTile=darken_major_long;
	FXOnTile=gateOpen_flicker;
	FXOnTile=gate_flicker;
	FXOnTile=sinisterSoundCue;




Final boss

dialogue about her trying to stay under the radar, and saying she'll take the world with her.

putrid panopticon (rotting prison but it spawns amalgams instead of abscesses and affects every crew member, invincible while casting. Deals 99 fire damage (should this be physical or not? if it's physical I'd have to assign a visible AV to the player telling the order the cast is in). Usable twice per battle, the second time when the caster is below 50% HP.

aoe bestow ruin (bestow oblivion)

aoe subsume  (Damnatio Memoriae)

Expurgate: Indiscriminately deals <Life> equal to <red>ten times the target's Rot</red> in a <red>radius equal to a tenth of the target's Rot, rounded up.</red> The caster is unaffected, of course. <disclaimer about targeted delayed skills>


At X% hp, casts a hard enrage that kicks the player to a second totally black zone where bad end dialogue plays and calls the game over screen

If Horizon's Grave is usable, she will use it.

Otherwise, if Putrid Panopticon is usable, she will use it.

Otherwise, if Damnatio Memoriae would cause a party member to be eaten she'll use it

Otherwise, she will alternate between Bestow Oblivion and Expurgate (highest rot party member) 




Immune to most crowd control, 66% hp dmg resist

spawns undead abscesses when hit, random in radius 3, if below X% hp spawns undead amalgams instead?

limited spawns (coffins?)

Heart of Corruption
On death, all allies will wither away.

Horizon's Grave

Thus do I offer up the vessel of my being<textIf= ; =1> mind, body, and soul as kindling for the undying Rot.

<red>Should this sacrifice be completed, it shall come to pass that the Creeping Death shall be unbound, and its shadow shall fall across all Eral. Behold, a great and final withering. Neither high nor low, wise nor simple, shall find refuge, for the breath of life shall be claimed from all that dwell under the sky.</red>


Dialogue when beginning to cast: *jealousy and "if I can't, then nobody will"*


Dialogue when successfully cast: *something about wanting to bide time, something about patience being a virtue being a lie*

-------------------------------------------------------------------------------------------------------------------------------------------

You awaken, your body and mind not your own. Your crew is nowhere in sight.

All you can do is shamble to the beat of the mindless force choking your veins.

Your days are now the scrubbing of a deck you once commanded. 

A barmaid you dimly recognize now stands behind the wheel of your flagship, grinning with vacant eyes as she steers your legacy into the endless haze.

She doesn't know what she's doing. She doesn't need to know what she's doing, of course.

The boredom is a deeper ache than any wound.

Like all others, you... your task is to spread and feed.

An interminable amount of time later, a hundred deaths find you.

Each more meaningless than the last, yet built upon a thousand shattered corpses, spent without count.

Here, a sickly guard wearing scavenged armor desperately thrusts a crackling spear into your skull, unable to muster the focus for anything greater. It doesn't take, and in your mind's eye you see Reeve rip her in half, a horrific hunger consuming both of them.

When you awaken, it is within a palace, the golden tiles crusted with unspeakable fluids. Your hands are mismatched, one Scurio, one Fareem. Your mouth feels chalky, the stench of spoiled wine tarring your being.

There, a hole is blown into your chest by trembling hands, the final retort of a scout rifle with no ammunition left to sustain it. Above, the great airships of Seartial hang like slumbering leviathans, every last trigger shattered from overuse.

Hours later, all is drowned out by gargled screams as you conclude the impromptu final gathering of Searth's Council, held further inland in a reeking swamp.

Perhaps there are survivors. Perhaps there is an unlikely holdfast spared the Creeping Death, by magic or ancient technology. Perhaps they might even carve a new life for themselves, defying the new reality they inhabit.

For you, however, it is...

<game over>
not sure it would help but cafe dialog when you start a food party has delay before it shows the dialog
specialEffect=delayDialog,1;
Shanakor
 — 
12:55 AM
I'll give it a whirl
thanks!
quo
 — 
12:56 AM
or if it's for after dialog that you want the delay, you could try adding a delay in that final trigger? or in the task string itself it would be written like this specialEffect=trigger,shana_horizonsgrave_badend_tq,@1; but I don't know if you can do delay in dialog effects or if that's a crashy bad idea
Shanakor
 — 
12:56 AM
I'll try both of em, no biggie :cheerful:
probably later since I have a job haha :revel:
rcfox
 — 
12:57 AM
Should work.


oneTile

[Action] ID=shana_horizons_grave;
	name=Horizon's Grave;
	icon=icon_horizons_grave;
	tooltip=Thus do I offer up the vessel of my being<textIf= ; =1> mind, body, and soul as kindling for the undying Rot.<n=><n=><color=Red>Should this sacrifice be completed, it shall come to pass that the Creeping Death shall be unbound, and its shadow shall fall across all Eral. Behold, a great and final withering. Neither high nor low, wise nor simple, shall find refuge, for the breath of life shall be claimed from all that dwell under the sky.;
	--rankUpTooltip=Each rank adds +5% damage (to enemies only).;
	--tooltipTopRight=<icon=PhysAtk_small><icon=melee_small>;
	mpCost=0;
	AIRatingBias=3;
--	cooldown=80;
	maxRank=1;
	XPCost=220;
	casterAnimation=spellcast;
	--casterAnimationSpeed=2.4;
	--casterAnimationLoops=1;
	FXOnCaster=sidewardLines;
	FXOnCaster=woosh;
[ActionAoE]
    ID=shana_horizons_grave;
    cloneFrom=oneTile;
[AvAffecter]
    ID=shana_horizons_grave;
    visibleMiss=false; visibleEvaluations=false;
    actorValue=trigger;
    magnitude=shana_horizonsgrave_badend_travel;
    duration=1;
    chance=100;
[AvAffecterAoE]
    ID=shana_horizons_grave;
    cloneFrom=oneTile;
 


shana_undead_abscess_normal_enemy
shana_undead_abscess_summoned_enemy

push blockers on the whole dungeon

maybe fix art for rotting prison
Todo: Implement once per combat restriction on rotting prison.
Sync -> Spellbond
Probably hugely increase the number of sync av?





[AvAffecter] --Trick AI into using ability - this should be placed on the initial av of the delayed ability
	ID=shana_rotting_prison;
	visibleEvaluations=false;
	harmful=false; 
	actorValue=ari_ai_skill_useage_multi;
	visibleMiss=false;
	magnitude=3;
	duration=-6;
	chance=100;
[AvAffecterAoE]
	ID=shana_rotting_prison;
	aoeCasterAsOrigin = true;
	cloneFrom=oneTile;
	canSelectAllies=true;


----------------------------------------------------------------Undead Abscess (WIP, if you need prefab)
[ActorPrefab]ID=shana_summoned_undead_abscess_minion_enemy; name=Undead Abscess; 
--pR=pBloodyMess_slow; pG=pCorpryst; pB=pHuman1;
actorTypeID=shana_undead_abscess_summoned_enemy; 
sprite=; 
actorClass=ari_zombie_class; secondaryClass=; actorClass3=; actorClass4=; 
movementSpeed=2; mountedOn=; mountedBy=; movementType=; position=21,32; destination=-1,-1; facingRot=1170; actualRot=0; 
incapacitated=False; alreadyKOdOnce=False; timesKOd=0; unkillable=False; damageTaken=0; canSwap=False; canDespawn=False;
totalXP=0; givesXP=True; canAttractAttention=True; canEditAppearance=True; canLootCorpse=False; canControlFullyIfControllable=True; controllable=False; playerCanOpenInv=False; canManipCorpse=True; 
idleAnimOverride=; combatMusicOverride=; statementPrefix=; 
hostile=True; factionBoss=False; faction=enemy; combatTeam=enemy; 
aiScript=wander_leash1_slow; aiTarget=; aiVarX=0; aiVarY=0; aiVarX2=0; aiVarY2=0; 
aiRating_bonusToNotMoving=0; aiRating_priorityMult=1; ai_extraTime=0;
canApplyDifficultyMods=False; difficultyModeSupportAbilAdded=False;
dialogNodeID=; 
aggressiveness=0.8; bravery=0.5; intelligence=0.3; honor=0.2; fearless=True; male=True; favoredHand=0;
  backSprite=;
partSpritesThatTakePriorityOverClass=torso; 

supportAbilities=ari_enemy_resurrection_passive2;

sailor_XP_stars=0;
warrior_XP_stars=0; 

ari_undead_enemy_AV=1;

HP=12; HPMax=12; TrueHPMax=12; 
MP=5; MPMax=5; TrueMPMax=5;

[ActorState]
canSwap=False;

[ActorInventory]
style=; maxWeight=100000; maxVolume=99; canContainAnything=False; infiniteStock=False; shopContainer=False; canOnlyContainItemsWithThisProperty=none; capacity=9;




[ItemType] name=Test Grimoire Putrid Panopticon;
texture=gkart;
ID=shana_grimoire_test_6; pR=p5; pG=pG; pB=overworld6;
description=Testing Putrid Panopticon.;
journalID=ari_journal_grimoire;
sprite=1; spriteWhenHeld=0; itemCategory=weapon;
element=ruin;
weight=5; volume=10; value=10;
power=0;
action=ari_skeleton_mage_essencerupture;
combineWith=furnace_lit; toMake=bones1;
combineWith=furnace2_lit; toMake=bones1;
combineWith=furnace_everlit1; toMake=bones1;
combineWith=furnace_everlit2; toMake=bones1;


the good news is that it would be relatively painless to do
you can create an [ActorTypeReaction] for the character like this:

[ActorTypeReaction]
ID=oldactor; element=customnumberelement; newID=newactor;

instead of newID you'd react to physical or magic or whatever with an action and put a reaction that self-inflicts some custom element, which then triggers a newID to become the new ActorType. 
that's how aelomanders transform into the inflated version, essentially, just with an action instead of a reaction chain




if not, you can make effectively identical item, uses the action icon as texture, does  +1 of the corresponding av (the ID of av is the action ID) as ActorValueEffect, effects_inArmor, effects_inWeapon, and set the gvar that says that tablet has been generated to 1, it's called "tablet_" followed by action ID





more

side road -> cave entrance with pedestal - both books needed to unlock but can take back after

tactical nexus glass tiles over an abyss

cavern of rememberance style stuff

two encounters, one ex church one ex lich

orgwall orgfloor palette 38
Known bugs :

Make revives decrease max hp
Lich summons zombie, walks on same tile and killing the zombie on the same tile kills the lich
	fReq=m:casterIsTarget;



Check if ruin difficulty changes lich summons



todo 
finish implementing taidon dialogue

list of nodes and conditions

[DialogNode] ID=shana_dialog_taidon_reaction_abombutnotlich;--after abom but not lich
g:ari_dead_abomination
[DialogNode] ID=shana_dialog_taidon_reaction_lichdefeated;--after lich beaten but not yeeted
g:ari_dead_lich
[DialogNode] ID=shana_dialog_taidon_reaction_barrow1;--after barrow 1
g:shana_barrow_1_clear 
[DialogNode] ID=shana_dialog_taidon_reaction_barrow3;--todo after barrow 3.
g:shana_barrow_1_clear and g:ari_dead_ascetic

is:2:g:arianna_gravekeeper_phylactery_quest - book purified but lich not yeeted

is:3:g:arianna_gravekeeper_phylactery_quest - lich yeeted

p35 for rusty stuff?

add some mausoleum dialogue?

lich dialogue



Cast Ability art for caster

create forbidden droplet?

counter droplet on boss? hm

barrow 1 yokaze dialog trigger

tri

nextNodeID_fReq=actor:shana_plaguebow_boss_ari_gravekeeper_city_path_-g:shana_gravekeeper_yokaze_already_triggered; --Does Yokaze exist, and is this the first time this node has fired? (i.e is this the first time?)

Unliving barrier art - animated? copy it into the spritesheet and see - I want to turn it black.

Implement first time combat start trigger with fReq=actor:<boss alive> to spawn the barrier


So I'm wondering if Barrow proper could do with a bit of reframing - by which, I mean:

1) Arianna warns you especially to not go past the north gate in the graveyard - some funny dialogue about anyone who tried not coming back, that also would justify one or two things I have planned for the combat in there

2) the gate has a custom sprite (very damaged, inspecting it says it's rusted and cracked, it seems to be eaten into), and the fence near it has a warning notice over it to the effect that the gate specifically reverts to that state regardless if they reinforce it or destroy it (implied to be a way to lure people in, please don't throw your life away) - any bomb, hammer or just Gating over it will let you in regardless of quest progress and there's a day trigger that repairs it if it's broken and you entered through Port Barrow (I mean, Gating over it is possible in current build anyway, lmao - that's what inspired this)

3) after beating it up, the lich, not Arianna, tells you to investigate, smugly saying that if you want to destroy it, go in there, it's sure you can handle the contents (mocking) -  this would pull triple duty as warning players away or letting them know they should return later as its obvious the lich is trying to get them killed, a signpost telling them where to go and hopefully makes it more interesting and fun for the player, I'm imagining the surprised pikachu kind of face the lich makes when they come back with the book lol - there'd be an element of "screw you lmao" on the player's end (the intention is that on prom's difficulty scale the graveyard and maus is 1-2 skulls and barrow proper is a 4-5+ skull area)

(Arianna doesn't hand you the key to the north gate, not that one is needed, and tries to warn you away in the sense of "we'd be really grateful but at the same time we'd rather not feed others to Old Barrow" if you haven't already embraced your inner sequence breaking gremlin) 


ask lich about gate
I'm suddenly wondering how I got defeated by a simpleton like you.

Surely you have a Hammer? If not, any sort of bomb will do the job, barbaric as those devices are. I doubt that you have the arcane knowledge needed to cast a Gate, but that would be yet another way to bypass the flimsy thing.  

scared lich if you finished barrow before coming back

shana_rotting_prison, shana_putrid_panopticon

funny side path encounter, small arena

4 bloodweavers in centre, 5 obelisks with Very Unstable Essence (unstable essence but no cd)



Custom callouts code
[AvAffecter] ID=wBLM_blackMage_ice;
    fReq=cIs:wBLM_umbralIce:3 * m:combat * g:wBLM_calloutReady;
    actorValue=trigger;
    magnitude=setGlobalVar_toActorID,wBLM_caster;
    duration=-2;
    chance=100;
    affectGlobalAvAffecterInfo=false;
[AvAffecterAoE] ID=wBLM_blackMage_ice;
    cloneFrom=oneTile;
    aoeCasterAsOrigin=true;
[AvAffecter] ID=wBLM_blackMage_ice;
    fReq=cIs:wBLM_umbralIce:3 * m:combat * g:wBLM_calloutReady;
    actorValue=task;
    magnitude=talk,@GwBLM_caster,wBLM_ice4,false,false;
    duration=-2;
    chance=20;
    FXOnHit=wBLM_timeStopCallout;
    affectGlobalAvAffecterInfo=false;
[AvAffecterAoE] ID=wBLM_blackMage_ice;
    cloneFrom=oneTile;

Old

[AvAffecter] ID=shana_horizons_grave;
    actorValue=trigger;
    magnitude=setGlobalVar_toActorID,shana_horizons_grave_caster;
    duration=-2;
    chance=100;
    affectGlobalAvAffecterInfo=false;
[AvAffecterAoE] ID=shana_horizons_grave;
    cloneFrom=oneTile;
    aoeCasterAsOrigin=true;
[AvAffecter] ID=shana_horizons_grave;
    actorValue=task;
    magnitude=talk,@Gshana_horizons_grave_caster,shana_horizonsgrave_bark,false,false;
    duration=-2;
    chance=100;
    affectGlobalAvAffecterInfo=false;
[AvAffecterAoE] ID=shana_horizons_grave;
    cloneFrom=oneTile;


[Action] ID=shana_horizons_grave;
	name=Horizon's Grave Dialog;
	icon=icon_horizons_grave;
	tooltip=I surrender the lantern of my mind. I offer the clay of my body. I commit the breath of my soul. Let it all burn as kindling for the undying Rot.<n=><n=><color=Red>Should my sacrifice be completed, it shall come to pass that the Creeping Death shall be unbound, and its shadow shall fall across Eral. Behold, a great and final withering. Neither high nor low, wise nor simple, shall find refuge, for the breath of life shall be claimed from all that dwell under the sky.;
	--rankUpTooltip=Each rank adds +5% damage (to enemies only).;
	--tooltipTopRight=<icon=PhysAtk_small><icon=melee_small>;
	AIRatingBias=3;
	cooldown=80;
	chargeTime=80;
	maxRank=4;
	canExceedMaxRankBy=1;
	queueAnotherAction=shana_horizons_grave2;

	XPCost=220;
	XPCost=440;
	XPCost=880;
	XPCost=1600;
	special=requiresCasting;
	casterAnimation=spellcast;
--	casterAnimation=weapon;
--	casterAnimationSpeed=2.4;
	--casterAnimationLoops=1;
	FXOnCaster=sidewardLines;
	FXOnCaster=woosh;

[ActionAoE]
    ID=shana_horizons_grave;
    cloneFrom=oneTile;

    [AvAffecter] ID=shana_horizons_grave; --set var and trigger dialog node
        actorValue=trigger;
        magnitude=setGlobalVar_toActorID,shana_horizons_grave_caster;
        duration=-2;
        chance=100;
        affectGlobalAvAffecterInfo=false;
    [AvAffecterAoE] ID=shana_horizons_grave;
        cloneFrom=oneTile;
        aoeCasterAsOrigin=true;
    [AvAffecter] ID=shana_horizons_grave;
        actorValue=task;
        magnitude=talk,@Gshana_horizons_grave_caster,shana_horizonsgrave_bark,false,false;
        duration=-2;
        chance=100;
        affectGlobalAvAffecterInfo=false;
    [AvAffecterAoE] ID=shana_horizons_grave;
        cloneFrom=oneTile;

[Action] ID=shana_horizons_grave2;
	name=Horizon's Grave Effects;
	icon=icon_horizons_grave;
	tooltip=I surrender the lantern of my mind. I offer the clay of my body. I commit the breath of my soul. Let it all burn as kindling for the undying Rot.<n=><n=><color=Red>Should my sacrifice be completed, it shall come to pass that the Creeping Death shall be unbound, and its shadow shall fall across Eral. Behold, a great and final withering. Neither high nor low, wise nor simple, shall find refuge, for the breath of life shall be claimed from all that dwell under the sky.;
	--rankUpTooltip=Each rank adds +5% damage (to enemies only).;
	--tooltipTopRight=<icon=PhysAtk_small><icon=melee_small>;
	AIRatingBias=3;
	cooldown=80;
	chargeTime=80;
	maxRank=4;
	canExceedMaxRankBy=1;
	[ActionAoE]
        ID=shana_horizons_grave2;
        cloneFrom=oneTile;

		[AvAffecter] --spams the everloving hell out of sparkle vfx
        	ID=shana_horizons_grave2;
        	FXOnHit=shana_badend_superSparkles;
        	FXOnHitColor=Olive;
        	FXOnHit=shana_badend_superSparkles;
        	FXOnHitColor=Black;
        [AvAffecterAoE]
        	ID=shana_horizons_grave2;
        	cloneFrom=oneTile;
        [AvAffecter] --9999 rot to all
        	ID=shana_horizons_grave2;
        	actorValue=ari_rot_status_enemy;
        	magnitude=9999;
        	chance=100;
        	duration=80;
        	applyElementToTile=false;
        	visibleMiss=false;
        	FXOnTile=shana_chargeSpiralFaster_big;
        	FXOnTileColor=Green;
        	FXOnTile=shana_chargeSpiralFaster_big;
        	FXOnTileColor=Black;
        	FXOnHit=shana_downwardLines_quicker;
        	FXOnHitColor=Green;
        [AvAffecterAoE]
        	ID=shana_horizons_grave2; shape=7;
        	needsLoS=true;
        	needsLoE=false;
        	arc=true;
        	airborne=true;
        	occupyAll=true;
        	bypassAll=true;
        	canSelectAllies=false;
        	minRange=1;
        	maxRange=22;

    [AvAffecter]
        ID=shana_horizons_grave2;
        visibleMiss=false; visibleEvaluations=false;
        actorValue=task;
        magnitude=trigger,shana_horizonsgrave_badend_travel;
        duration=1;
        chance=100;
    [AvAffecterAoE]
        ID=shana_horizons_grave2;
        cloneFrom=oneTile;



add poison to grimore of rot?

todo - polish

maybe add book for lore


Ask Ari:

todo - implementation

---Enter Mausoleum dialogue

Reeve is cheerful and excited.

--- City Proper dialogue

[DialogNodeOverride] ID=reeve_ari_gravekeeper_city_path_dialog1a;
dialogNodeID_toOverride=enterLoc; priority=9;
completeOverride=true;
fReq=party:reeve + loc:ari_gravekeeper_city_path - g1:D_reeve_ari_gravekeeper_city_path_dialog1a - 1;
speakerOverride=reeve;
specialEffect=delayDialog,2;
specialEffect=noSpeechFXLookOrAnim;
animations=stern;
animations=sigh;
statements=<color=DarkBlue>Rgh...<color=> I was hoping it would be warmer inside,<p> but if anything, it's even c-<p>colder!;
statements=W-<p>will be tough to fight here...<p> but we'll have to make do.;

Hi Arianna, a couple changes that touch stuff you've done so I'll run em by you first: - 

1) Phylactery accessory description

A broken Phylactery that once housed the soul of a Lich. <add>Halves the duration of Chilled and Frozen on the bearer.</add> (I noticed that this wasn't stated in the description)

4) grimores: 




laser grimore (not sure if this is impinging on design space already taken by the Lich as you mentioned a rot detonating skill - my experience with the Lich was having her get spawncamped by ruin enemies and being able to take a grand total of one action before I got wiped) 

fire damage + burn based on ruin skill on cast. If the target has X or more stacks of Rot... (target blows up like a heatle, dealing fire damage scaling with caster's ruin skill and target's rot stacks - this isn't stated)

5) I'm gonna add a custom zombified/plagued flesh obelisk (hi prominence, again) based mob that has decent hp but no armor, but pulses global AoE rot/long (30ish tta) channel into Command:(whatever) based on skeleton knights while players out of range. 


add reeve dialog when entering mausoleum for first time





change church area a bit (add pews too)

revamp church fight

buff unearth by +1 radius? maybe make it less likely in that +1



-bandage/splint variant that's overpriced, heals less than the normal items but removes rot and heals additional hp based on how many stacks were removed

update lucca's inventory accordingly



town - five casters




[AvAffecter]
	ID=ari_necronomicon_hungry_talk; 
	visibleEvaluations=false;
	visibleMiss=false;
	harmful=false;
	actorValue=task;
	magnitude=talk,False,False,,ari_necronomicon_hungry_talk_node;
	chance=100 * c:ari_gravekeeper_hungry_necronomicon;
	duration=-2;
	FXOnTile=delay_tiny;
[AvAffecterAoE]
	ID=ari_necronomicon_hungry_talk;
	cloneFrom=oneTile;
	aoeCasterAsOrigin=true;
	canSelectAllies=true;

boss talking













ruptured soul make consistent with other descriptions

ruptured soul journal entry?


update mausoleum summon

give wisp, wraith, ghost and maybe the t2 summon spirit an actor light and maybe an actor fx

give the actions some basic fx and maybe effects

Copy mech attack shoot upwards nobody bunched up

clone ghost summon fx with recolour and replace existing with the clones

if they're gonna die next action make them not cast soul tear

maybe give them another action and hardcode them to use it (selfdestruct?)

give haunting gate inferno ball shoot fx and madness impact fx

all summons should die when dispelled


[Action] ID=forge_meteorite; 
	name=Meteorite;
	icon=icon_forge_meteorite;
	tooltip=Call down a fiery meteorite after a delay.  Deals <thinnerIcon=skill_Fire><math=d:fireDmg20ScaleDisplay(14)> damage in the target tile, and inflicts Burn for <icon=time><math=10 + d:fireDurMax(2)> on adjacent tiles.;
	tooltipTopRight=<icon=MagAtk_small><icon=skill_Fire_small>;
	mpCost=8 * d:mpCostMult * d:mpCostMult_onlyWithCT + d:mpCostMod_onlyWithCT + d:mpCostMod;
	chargeTime=20 * d:chargeTimeMult * d:chargeTimeMult_onlyWithMP + d:chargeTimeMod + d:chargeTimeMod_onlyWithMP;
	rankUpTooltip=Each rank adds +1 range.;
	
	XPCost=300;
	XPCost=600;
	XPCost=900;
	XPCost=1200;
	
	casterAnimation=spellcast;
	casterAnimationSpeed=1;
	maxRank=4;
	canExceedMaxRankBy=1;

	
	FXOnCaster=magicCharge;
	FXOnCasterColor=Red;
	FXOnCaster=darken_minor;
	FXOnCasterColor=Yellow;
	FXOnCaster=chargeFast;
	FXOnCasterColor=Orange;
	FXOnCaster=Thwummm;
	FXOnCasterColor=Red;
	FXOnCaster=delay;
	FXOnCasterColor=Red;
	FXOnCaster=delay;
	FXOnCasterColor=Yellow;

	FXOnCaster=delay;
	FXOnCaster=delay;
	FXOnCaster=delay;
	
	FXOnTarget=darken;
	FXOnTargetColor=Red;
	FXOnTarget=spiral;
	FXOnTargetColor=Red;
	FXOnTarget=spiral2;
	FXOnTargetColor=Yellow;
	FXOnTarget=spiral3;
	FXOnTargetColor=Orange;
	FXOnTarget=spiral4;
	FXOnTargetColor=Red;
[ActionAoE] 
	ID=forge_meteorite;
	needsLoS = true;
	needsLoE = false;
	airborne=true;
	arc=true;
	minRange = 2;
	maxRange = 3;
	maxRangeBonus = c:rank;
	bypassAll=true;
	occupyAll=true;
[AvAffecter]
	ID=forge_meteorite; 
	actorValue=HP;
	magnitude= d:fireDmg20Scale(14);
	chance=d:fireAcc;
	duration=-2;
	element=magic;
	element=kindle;
	element=fire;
	FXOnTile=delay;
	FXOnTileColor=Red;
	FXOnTile=delay;
	FXOnTileColor=Yellow;
	FXOnTile=tinyHorizShake;
	FXOnTileColor=Red;
	FXOnTile=hailLine;
	FXOnTileColor=Orange;
	FXOnTileColor=Red;
	FXOnTile=delay;
	FXOnTileColor=Yellow;
	FXOnTile=delay;
	FXOnTileColor=White;
	FXOnTile=whiteExplosionSmall;
	FXOnTileColor=Orange;
	FXOnTile=tallExplode;
	FXOnTile=smallShakeHoriz;
	FXOnHit=medHorizShake;
[AvAffecterAoE]
	ID=forge_meteorite;
	 cloneFrom=oneTile;
[AvAffecter]
	ID=forge_meteorite; 
	actorValue=burn;
	magnitude=100;
	chance=d:fireAcc;
	duration=10 + d:fireDurMax(2);
	element=fire;
	FXOnTile=fireburst;
	FXOnTile=burn;
[AvAffecterAoE]
	ID=forge_meteorite;
	 cloneFrom=adjacent;


spirits "teleport" in via stormshot/forgewright fx?

[Action] ID=forge_wildfire; 
	name=Wildfire;
	icon=icon_forge_wildfire;
	mpCost=6 * d:mpCostMult * d:mpCostMult_onlyWithCT + d:mpCostMod_onlyWithCT + d:mpCostMod;
	chargeTime=10 * d:chargeTimeMult * d:chargeTimeMult_onlyWithMP + d:chargeTimeMod + d:chargeTimeMod_onlyWithMP ;
	tooltip=Scorch a target with spreading flames, dealing <thinnerIcon=skill_Fire><math=d:fireDmgDisplay(1)> damage and inflicting the Wildfire status.  Afflicted units strike themselves and adjacent tiles with <thinnerIcon=skill_Fire>10 damage at the end of their turn, spreading the status.;
	rankUpTooltip=Each rank adds +1 range.;
	tooltipTopRight=<icon=MagAtk_small><icon=skill_Fire_small>;
	
	XPCost=150;
	XPCost=550;
	XPCost=1350;
	maxRank=3;
	canExceedMaxRankBy=1;
	
	special=requiresCasting;
	casterAnimation=spellcast;
	
	FXOnCaster=magicCharge;
	
	FXOnTarget=fireburst;
	FXOnTarget=burn;
[ActionAoE] 
	ID=forge_wildfire; 
	needsLoS = true;
	needsLoE = false;
	airborne=true;
	arc=true;
	minRange = 1;
	maxRange = 2;
	maxRangeBonus = c:rank;
	bypassAll=true;
	occupyAll=true;
[AvAffecter]
	ID=forge_wildfire; 
	actorValue=HP;
	magnitude=d:fireDmg(1);
	duration=-2;
	chance=d:fireAcc;
	element=magic;
	element=fire;
	element=kindle;
	FXOnHit=burn;
[AvAffecterAoE]
	ID=forge_wildfire;
	cloneFrom=oneTile;
	needsLoE = false;
	bypassAll=true;
	occupyAll=true;
	airborne=true;
	arc=true;
[AvAffecter]
	ID=forge_wildfire; 
	actorValue=prom_wildfire;
	magnitude=1;
	duration=40;
	chance=d:fireAcc;
	element=magic;
	element=fire;
	element=kindle;
	FXOnHit=flamethrower_still;
	FXOnHit=DramaticNyeaow;
	FXOnTile=fireburst;
[AvAffecterAoE]
	ID=forge_wildfire;
	cloneFrom=oneTile;
	needsLoE = false;
	bypassAll=true;
	occupyAll=true;
	airborne=true;
	arc=true;



[Action] ID=Sto_blastShot; 
	name=Blast Shot;
	icon=icon_Sto_blastShot;
	mpCost=8 * d:mpCostMult * d:mpCostMult_onlyWithCT + d:mpCostMod_onlyWithCT + d:mpCostMod;
	chargeTime=12 * d:chargeTimeMult * d:chargeTimeMult_onlyWithMP + d:chargeTimeMod + d:chargeTimeMod_onlyWithMP ;
	
	tooltip=Fire a delayed blast that deals 120% damage or more.;
	rankUpTooltip=Each rank adds +1 range.;
	tooltipIcons=<icon=noMelee>;
	tooltipTopRight=<icon=PhysAtk_small><icon=MagAtk_small><icon=ranged_small><icon=skill_Wind_small>;
	
	XPCost=150;
	XPCost=550;
	XPCost=1500;
	maxRank=3;
	canExceedMaxRankBy=1;
	
	casterAnimation=weapon;
	casterAnimationSpeed=0.7;
	requiredWeaponElement=ranged;
	
	FXOnCaster=sfx_quickHumHigh;
	FXOnCaster=glintRot;
	FXOnCaster=glint;
	FXOnCaster=sfx_magicCharge;
	FXOnCaster=delay;
	FXOnCaster=tileLine;
	FXOnCaster=DramaticNyeaow;
	
	FXOnTarget=largePing;
	FXOnTarget=delay;
	FXOnTarget=largePing;
	FXOnTarget=delay;
	FXOnTarget=delay;
[ActionAoE] 
	ID=Sto_blastShot; shape=10;
	maxRangeBonus=c:rank - 2;
	needsLoE=false;
[AvAffecter]
	ID=Sto_blastShot; 
	weaponAvAffecter=true;
	showWeaponAvAffecterFX=false;
	actorValue=HP;
	magnitude=w:magnitude * 0.7 + dMax0:windDmg(2);
	chance=w:chance;
	duration=-2;
	element=magic;
	element=wind;
	FXOnTile=tileLine_overlap;
	FXOnTile=DramaticNyeaow;
	FXOnTile=whiteExplosionSmall_rand_overlap;
	FXOnTile=smallShakeHoriz;
[AvAffecterAoE]
	ID=Sto_blastShot; 
	cloneFrom=adjacentAndSelf;


gate:inferno fx?

make haunting summon at least one spirit on use


maybe do the barrow fight depending on what it looks like when everything else is done

test

publish and be damned/if everyone's not a burnt out husk at the time proceed to extreme encounters




laser grimore - fire damage + burn based on ruin skill. If the target has 13 or more stacks of Rot... (target blows up like a heatle, dealing fire damage scaling with caster's ruin skill and target's rot stacks - this isn't stated)

copy anchorite's reliquary fx?

descriptions

The memory of <red><encounter></red> inexplicably rises within you as you rest your hand against the portal. The surface yields unnaturally, cold and slick, as though the gateway itself is alive. For a moment, you feel as though the battle never truly ended. 

Challenge <description> -> Relive the battle as it originally unfolded? Experience will be granted as usual, but certain artefacts cannot be recreated by a mere memory. Any posessions left behind will be deposited on the table near the entrance.

You feel a sharp tug, and then nothingness — a fleeting void before the memory of <encounter> engulfs you, pulling you back into the heat of battle.

Challenge <description> (Savage)


For pew:

also see if you can get the fires to last longer when generated by the reaction

For the carpet: grass_lusher but see if you can get the reaction generating fire to last longer as well.




special=enhanceSlots_2;





