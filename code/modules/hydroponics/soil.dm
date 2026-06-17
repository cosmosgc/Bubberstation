
///////////////////////////////////////////////////////////////////////////////
/obj/machinery/hydroponics/soil //Not actually hydroponics at all! Honk!
	name = "soil"
	desc = "Um pedaço de terra."
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "soil"
	circuit = null
	density = FALSE
	use_power = NO_POWER_USE
	unwrenchable = FALSE
	self_sustaining_overlay_icon_state = null
	maxnutri = 15
	tray_flags = SOIL
	armor_type = /datum/armor/obj_soil
	custom_materials = list(/datum/material/sand = SHEET_MATERIAL_AMOUNT * 3)
	//which type of sack to create when shovled.
	var/sack_type = /obj/item/soil_sack

/obj/machinery/hydroponics/soil/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/tool_blocker, TOOL_SCREWDRIVER)
	AddElement(/datum/element/tool_blocker, TOOL_CROWBAR)

/obj/machinery/hydroponics/soil/update_icon(updates=ALL)
	. = ..()
	if(self_sustaining)
		add_atom_colour(rgb(255, 175, 0), FIXED_COLOUR_PRIORITY)

/obj/machinery/hydroponics/soil/update_status_light_overlays()
	return // Has no lights

/obj/machinery/hydroponics/soil/attackby_secondary(obj/item/weapon, mob/user, list/modifiers, list/attack_modifiers)
	if(weapon.tool_behaviour != TOOL_SHOVEL) //Spades can still uproot plants on left click
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	balloon_alert(user, "desenterrando solo...")
	if(weapon.use_tool(src, user, 3 SECONDS, volume=50))
		balloon_alert(user, "bagged")
		new sack_type(loc, src) //The bag handles sucking up the soil, stopping processing and setting relevants stats.

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/hydroponics/soil/click_ctrl(mob/user)
	return CLICK_ACTION_BLOCKING //Soil has no electricity.

/obj/machinery/hydroponics/soil/on_deconstruction(disassembled)
	new /obj/item/stack/ore/glass(drop_location(), 3)

///called when a soil is plopped down on the ground.
/obj/machinery/hydroponics/soil/proc/on_place()
	return

/datum/armor/obj_soil
	melee = 80
	bullet = 100
	laser = 90
	fire = 70
	acid = 30
	bomb = 15

/////////////// Advanced Soils //////////////

/obj/machinery/hydroponics/soil/vermaculite
	name = "vermaculite growing medium"
	desc = "Uma cama de plantas feita de grânulos minerais leves e expandidos.\n\nA saúde vegetal se beneficia do alto grau de aeração do solo é especialmente útil para a propagação de enxertos."
	icon_state = "soil_verm"
	maxnutri = 20
	maxwater =  150
	tray_flags = SOIL | MULTIGRAFT | GRAFT_MEDIUM
	sack_type = /obj/item/soil_sack/vermaculite

/obj/machinery/hydroponics/soil/gel
	name = "hydrogel beads"
	desc = "Uma cama de plantas feita de contas de polímero superabsorvente.\n\nEsses tipos de grânulos de gel de água podem segurar uma quantidade incrível de água e reduzir as perdas evaporativas a quase nada."
	icon_state = "soil_gel"
	gender = PLURAL
	maxwater = 300
	tray_flags = SOIL | HYDROPONIC | SUPERWATER
	plant_offset_y = 2
	sack_type = /obj/item/soil_sack/gel

/obj/machinery/hydroponics/soil/coir
	name = "korta root coir"
	desc = "Um tipo de meio de cultivo tradicional de Tizira.\n\nUsado pelos nativos como uma forma engenhosa de cultivar cogumelos seraka usando raízes de korta.\nCogumelos de todos os tipos prosperam devido ao alto conteúdo orgânico que os permite amadurecer mais rápido."
	icon_state = "soil_coir"
	maxnutri = 20
	tray_flags = SOIL | FAST_MUSHROOMS
	sack_type = /obj/item/soil_sack/coir

/obj/machinery/hydroponics/soil/worm
	name = "worm castings"
	desc = "Um tipo de composto criado quando o humilde verme trabalha obedientemente no solo.\n\nEstá cheio de nutrientes desbloqueados por tais criaturas do sistema digestivo. Dê graças ao verme!"
	icon_state = "soil_worm"
	maxnutri = 35
	maxwater = 200
	tray_flags = SOIL | WORM_HABITAT | SLOW_RELEASE
	plant_offset_y = 4
	sack_type = /obj/item/soil_sack/worm

/obj/machinery/hydroponics/soil/worm/on_place()
	. = ..()
	flick("soil_worm_wiggle", src)

/obj/machinery/hydroponics/soil/rich
	name = "rich soil"
	desc = "Um rico pedaço de terra, geralmente usado em jardins."
	icon_state = "rich_soil"
	maxnutri = 20
	sack_type = /obj/item/soil_sack/rich

/////////////////// Soil Sacks ///////////////////////
/// Holder items that store the soils until deployed.
/obj/item/soil_sack
	name = "soil sack"
	desc = "Um grande saco plástico contendo solo comercial de jardim. Está cheio de areia, turfa e estrume. Embora você possa não gostar muito dessa mistura, as plantas têm gostos estranhos."
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "soil_sack"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	base_icon_state =  "soil_sack"
	force = 7
	throwforce = 17
	attack_speed = 1.2 SECONDS
	damtype = STAMINA
	block_sound = 'sound/effects/bodyfall/bodyfall1.ogg'
	w_class = WEIGHT_CLASS_HUGE
	item_flags = SLOWS_WHILE_IN_HAND
	resistance_flags = ACID_PROOF
	hitsound = 'sound/items/pillow/pillow_hit.ogg'
	drop_sound = 'sound/effects/footstep/woodbarefoot3.ogg' //could use better sounds in the future.
	throw_drop_sound = 'sound/effects/bodyfall/bodyfall3.ogg'
	custom_premium_price = PAYCHECK_CREW
	throw_range =  3
	throw_speed = 1
	slowdown = 1
	drag_slowdown = 1
	var/obj/machinery/hydroponics/soil/stored_soil = /obj/machinery/hydroponics/soil
	var/placement_sound = 'sound/effects/soil_plop.ogg'

/obj/item/soil_sack/Initialize(mapload, obj/machinery/hydroponics/soil/outside_soil)
	. = ..()
	AddComponent(/datum/component/two_handed, force_multiplier = 2, wield_callback = CALLBACK(src, PROC_REF(on_wield)), unwield_callback = CALLBACK(src, PROC_REF(on_unwield)))

	if(outside_soil)
		stored_soil = outside_soil
		stored_soil.remove_plant()
		stored_soil.forceMove(src)
		STOP_PROCESSING(SSmachines, stored_soil)
		animate(src, 100 MILLISECONDS, pixel_z = 4, easing = QUAD_EASING | EASE_OUT)
		animate(time = 100 MILLISECONDS, pixel_z = 0, easing = QUAD_EASING | EASE_IN)
		animate(time = 250 MILLISECONDS, pixel_x = rand(-6, 6), pixel_y = rand(-4, 4), flags = ANIMATION_PARALLEL)

/obj/item/soil_sack/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isopenturf(interacting_with) || isgroundlessturf(interacting_with))
		return ..()

	if(locate(/obj/machinery/hydroponics/soil) in interacting_with)
		to_chat(user, span_alert("Já tem uma cama de terra lá!"))
		return ITEM_INTERACT_BLOCKING

	if(!do_after(user, 1 SECONDS, interacting_with))
		return ITEM_INTERACT_BLOCKING

	if(ispath(stored_soil))
		stored_soil = new stored_soil(src)
		stored_soil.reagents.add_reagent(/datum/reagent/plantnutriment/eznutriment, stored_soil.maxnutri / 2)
		stored_soil.waterlevel = stored_soil.maxwater
	else
		START_PROCESSING(SSmachines, stored_soil)


	stored_soil.forceMove(interacting_with)
	playsound(stored_soil, placement_sound, 65, vary = TRUE)
	stored_soil.on_place()
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/soil_sack/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == OVERWHELMING_ATTACK)
		return FALSE
	return ..()

///Remove slowdown and add block chance when wielded.
/obj/item/soil_sack/proc/on_wield()
	slowdown = 0
	if(ismob(loc))
		var/mob/wearer = loc
		wearer.update_equipment_speed_mods()
	block_chance = 25
	inhand_icon_state = "[base_icon_state]_w"

///Reapply slowdown and remove block chance when unwielded.
/obj/item/soil_sack/proc/on_unwield()
	slowdown = initial(slowdown)
	if(ismob(loc))
		var/mob/wearer = loc
		wearer.update_equipment_speed_mods()
	block_chance = initial(block_chance)
	inhand_icon_state = base_icon_state


/obj/item/soil_sack/vermaculite
	name = "NT vermaculite sack"
	desc = "Um saco de granulado mineral expandido que pode ser usado como meio de cultivo sem solo.\n\nVocê gosta de pensar nisso um saco de pipoca rochosa que deixa as raízes respirarem."
	icon_state = "soil_sack_verm"
	base_icon_state = "soil_sack_verm"
	custom_premium_price = PAYCHECK_CREW * 2
	stored_soil = /obj/machinery/hydroponics/soil/vermaculite
	slowdown = 0

/obj/item/soil_sack/gel
	name = "hydrogel bead sack"
	desc = "Um saco de contas de gel superabsorvente da era espacial! Você se pergunta como enviá-los pré-hidratado faria sentido para os negócios..."
	icon_state = "soil_sack_gel"
	base_icon_state = "soil_sack_gel"
	custom_premium_price = PAYCHECK_CREW * 2
	placement_sound = 'sound/effects/meatslap.ogg'
	stored_soil = /obj/machinery/hydroponics/soil/gel

/obj/item/soil_sack/coir
	name = "#1™ korta coir sack"
	desc = "Um saco de raiz de Tiziran korta. As raízes fibrosas são compostas até se separarem em fibras individuais.\n\nFornece uma excelente fonte de alimento para cogumelos saprotróficos e ajuda a segurar a água no clima quente tiziriano."
	icon_state = "soil_sack_coir"
	base_icon_state = "soil_sack_coir"
	custom_premium_price = PAYCHECK_CREW * 3
	stored_soil = /obj/machinery/hydroponics/soil/coir

/obj/item/soil_sack/worm
	name = "worm castings sack"
	desc = "Um saco de vermicompost, também conhecido como casting de vermes.\n\nEste estrume invertebrado não só contém nutrientes vegetais e matéria orgânica não digerida, mas também abriga uma rica flora de microrganismos benéficos."
	icon_state = "soil_sack_worm"
	base_icon_state = "soil_sack_worm"
	custom_premium_price = PAYCHECK_CREW * 4
	stored_soil = /obj/machinery/hydroponics/soil/worm

/obj/item/soil_sack/rich
	name = "rich soil sack"
	desc = "Um saco de terra negra.\nComo seu olhar cai sobre ele, você se sente um pouco mais ligado à terra."
	custom_premium_price = PAYCHECK_CREW * 1.5
	stored_soil = /obj/machinery/hydroponics/soil/rich
