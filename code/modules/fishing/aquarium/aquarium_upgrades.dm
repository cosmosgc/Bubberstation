
/// Aquarium upgrades, can be applied to a basic aquarium to upgrade it into an advanced subtype.
/obj/item/aquarium_upgrade
	name = "Aquarium Upgrade"
	desc = "Uma atualização."

	icon = 'icons/obj/aquarium/supplies.dmi'
	icon_state = "construction_kit"
	/// What kind of aquarium can accept this upgrade. Strict type check, no subtypes.
	var/upgrade_from_type = /obj/structure/aquarium
	/// typepath of the new aquarium subtype created.
	var/upgrade_to_type = /obj/structure/aquarium

/obj/item/aquarium_upgrade/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!HAS_TRAIT(interacting_with, TRAIT_IS_AQUARIUM))
		return NONE
	if(upgrade_from_type != interacting_with.type)
		interacting_with.balloon_alert(user, "Tipo errado de aquário!")
		return ITEM_INTERACT_BLOCKING
	interacting_with.balloon_alert(user, "upgrading...")
	if(!PERFORM_ALL_TESTS(aquarium_upgrade) && !do_after(user, 5 SECONDS, interacting_with))
		return ITEM_INTERACT_BLOCKING
	var/atom/movable/upgraded_aquarium = new upgrade_to_type(interacting_with.drop_location())
	//This should transfer all the fish, reagents and settings from the aquarium component
	interacting_with.TransferComponents(upgraded_aquarium)
	upgraded_aquarium.balloon_alert(user, "upgraded")
	qdel(src)
	qdel(interacting_with)
	return ITEM_INTERACT_SUCCESS

/obj/item/aquarium_upgrade/bioelec_gen
	name = "aquarium bioelectricity kit"
	desc = "Todos os componentes necessários para permitir um aquário para aproveitar a energia de peixes bioelétricos."
	icon_state = "bioelec_kit"
	upgrade_to_type = /obj/structure/aquarium/bioelec_gen

/obj/structure/aquarium/bioelec_gen
	name = "bioelectricity generator"
	desc = "Um tipo não convencional de gerador que impulsiona e colhe a energia produzida por peixes bioelétricos."

	icon_state = "bioelec_map"
	base_icon_state = "bioelec"

	default_beauty = 0

/obj/structure/aquarium/bioelec_gen/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_BIOELECTRIC_GENERATOR, INNATE_TRAIT)

/obj/structure/aquarium/bioelec_gen/zap_act(power, zap_flags)
	var/explosive = zap_flags & ZAP_MACHINE_EXPLOSIVE
	if(!explosive)
		return //immune to all other shocks to make sure power can be generated without breaking the generator itself
	return ..()

/obj/structure/aquarium/bioelec_gen/examine(mob/user)
	. = ..()
	. += span_boldwarning("AVISO! AVISO! AVISO!")
	. += span_warning("O potencial bioelétrico dos peixes dentro é ampliado para níveis perigosos pelo gerador.")
	. += span_notice("As bobinas de Tesla são necessárias para coletar esta energia ampliada... e você vai querer uma haste de aterramento para se proteger também.")

/obj/item/aquarium_upgrade/bluespace_tank
	name = "bluespace fish tank kit"
	desc = "Os componentes necessários para atualizar seu aquário portátil para o aquário portátil sem fundo."
	icon_state = "bluespace_kit"
	upgrade_from_type = /obj/item/fish_tank
	upgrade_to_type = /obj/item/fish_tank/bluespace

/obj/item/fish_tank/bluespace
	name = "bluespace fish tank"
	desc = "Toda a capacidade de um aquário volumosos, espremido em um cubóide retangular tamanho saco."
	icon_state = "fish_tank_bluespace_map"
	base_icon_state = "fish_tank_bluespace"
	w_class = WEIGHT_CLASS_NORMAL
	maximum_relative_size = INFINITY
	max_total_size = 2000
	slowdown_coeff = 0.15
	min_fluid_temp = MIN_AQUARIUM_TEMP
	max_fluid_temp = MAX_AQUARIUM_TEMP
	reagent_size = 6
