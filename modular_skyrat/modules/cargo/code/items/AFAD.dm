#define PHYSICAL_DAMAGE_HEALING -0.2
#define EXOTIC_DAMAGE_HEALING -0.1

/obj/item/gun/medbeam/afad
	name = "Automated First Aid Device"
	desc = "Normalmente fornecido em kits médicos, o AFAD é um dispositivo revolucionário destinado a consertar arranhões e hematomas, e totalmente não uma imitação do lendário medibeam. Uma etiqueta na parte de baixo te lembra de não cruzar as vigas."
	icon = 'icons/obj/chronos.dmi'
	icon_state = "chronogun"
	inhand_icon_state = "chronogun"
	w_class = WEIGHT_CLASS_NORMAL



/obj/item/gun/medbeam/afad/on_beam_tick(mob/living/target)
	if(target.health != target.maxHealth)
		new /obj/effect/temp_visual/heal(get_turf(target), "#80F5FF")
	target.adjust_brute_loss(PHYSICAL_DAMAGE_HEALING)
	target.adjust_fire_loss(PHYSICAL_DAMAGE_HEALING)
	target.adjust_tox_loss(EXOTIC_DAMAGE_HEALING)
	target.adjust_oxy_loss(EXOTIC_DAMAGE_HEALING)
	return

#undef PHYSICAL_DAMAGE_HEALING
#undef EXOTIC_DAMAGE_HEALING
