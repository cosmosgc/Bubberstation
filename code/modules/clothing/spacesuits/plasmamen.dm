//Suits for the pink and grey skeletons! //EVA version no longer used in favor of the Jumpsuit version

/obj/item/clothing/suit/space/eva/plasmaman
	name = "EVA plasma envirosuit"
	desc = "Um traje especial de contenção de plasma projetado para ser digno de espaço, bem como usado sobre outras roupas. Como sua contraparte menor, ele pode automaticamente extinguir o usuário em uma crise, e detém o dobro de acusações."
	allowed = list(/obj/item/gun, /obj/item/ammo_casing, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/energy/sword, /obj/item/restraints/handcuffs, /obj/item/tank)
	armor_type = /datum/armor/eva_plasmaman
	resistance_flags = FIRE_PROOF
	icon_state = "plasmaman_suit"
	inhand_icon_state = "plasmaman_suit"
	fishing_modifier = 0
	COOLDOWN_DECLARE(extinguish_timer)
	var/extinguish_cooldown = 100
	var/extinguishes_left = 10

/datum/armor/eva_plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/suit/space/eva/plasmaman/examine(mob/user)
	. = ..()
	. += span_notice("Ali.[extinguishes_left == 1 ? "is" : "are"] [extinguishes_left] A carga do extintor é deixada neste terno.")

/obj/item/clothing/suit/space/eva/plasmaman/equipped(mob/living/user, slot)
	. = ..()
	if (slot & ITEM_SLOT_OCLOTHING)
		RegisterSignals(user, list(COMSIG_MOB_EQUIPPED_ITEM, COMSIG_LIVING_IGNITED, SIGNAL_ADDTRAIT(TRAIT_HEAD_ATMOS_SEALED)), PROC_REF(check_fire_state))
		check_fire_state()

/obj/item/clothing/suit/space/eva/plasmaman/dropped(mob/living/user)
	. = ..()
	UnregisterSignal(user, list(COMSIG_MOB_EQUIPPED_ITEM, COMSIG_LIVING_IGNITED, SIGNAL_ADDTRAIT(TRAIT_HEAD_ATMOS_SEALED)))

/obj/item/clothing/suit/space/eva/plasmaman/proc/check_fire_state(datum/source)
	SIGNAL_HANDLER

	if (!ishuman(loc))
		return

	// This is weird but basically we're calling this proc once the cooldown ends in case our wearer gets set on fire again during said cooldown
	// This is why we're ignoring source and instead checking by loc
	var/mob/living/carbon/human/owner = loc
	if (!owner.on_fire || !owner.is_atmos_sealed(additional_flags = PLASMAMAN_PREVENT_IGNITION, check_hands = TRUE))
		return

	if (!extinguishes_left || !COOLDOWN_FINISHED(src, extinguish_timer))
		return

	extinguishes_left -= 1
	COOLDOWN_START(src, extinguish_timer, extinguish_cooldown)
	// Check if our (possibly other) wearer is on fire once the cooldown ends
	addtimer(CALLBACK(src, PROC_REF(check_fire_state)), extinguish_cooldown)
	owner.visible_message(span_warning("[owner] O traje se apaga automaticamente.[owner.p_them()]!"), span_warning("Seu traje automaticamente o apaga."))
	owner.extinguish_mob()
	new /obj/effect/particle_effect/water(get_turf(owner))

/obj/item/clothing/suit/space/eva/plasmaman/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if (!istype(tool, /obj/item/extinguisher_refill))
		return

	if (extinguishes_left == initial(extinguishes_left))
		to_chat(user, span_notice("O extintor embutido está cheio."))
		return ITEM_INTERACT_BLOCKING

	extinguishes_left = initial(extinguishes_left)
	to_chat(user, span_notice("Você enche o extintor embutido, usando o cartucho."))
	check_fire_state()
	qdel(tool)
	return ITEM_INTERACT_SUCCESS

//I just want the light feature of helmets
/obj/item/clothing/head/helmet/space/plasmaman
	name = "plasma envirosuit helmet"
	desc = "Um capacete de contenção especial que permite que formas de vida baseadas em plasma existam em segurança em um ambiente oxigenado. É digno de espaço, e pode ser usado em conjunto com outros equipamentos EVA."
	icon = 'icons/obj/clothing/head/plasmaman_hats.dmi'
	worn_icon = 'icons/mob/clothing/head/plasmaman_head.dmi'
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT | STACKABLE_HELMET_EXEMPT | PLASMAMAN_PREVENT_IGNITION | HEADINTERNALS
	icon_state = "plasmaman-helm"
	inhand_icon_state = "plasmaman-helm"
	strip_delay = 8 SECONDS
	flash_protect = FLASH_PROTECTION_WELDER
	tint = 2
	armor_type = /datum/armor/space_plasmaman
	resistance_flags = FIRE_PROOF
	light_system = OVERLAY_LIGHT_DIRECTIONAL
	light_range = 4
	light_power = 0.8
	light_color = "#ffcc99"
	light_on = FALSE
	fishing_modifier = 0
	actions_types = list(/datum/action/item_action/toggle_helmet_light, /datum/action/item_action/toggle_welding_screen)
	visor_vars_to_toggle = VISOR_FLASHPROTECT | VISOR_TINT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	flags_cover = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF
	visor_flags_inv = HIDEEYES|HIDEFACE
	visor_dirt = null
	var/helmet_on = FALSE
	var/smile = FALSE
	var/smile_color = COLOR_RED
	var/visor_icon = "envisor"
	var/smile_state = "envirohelm_smile"

/datum/armor/space_plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/head/helmet/space/plasmaman/Initialize(mapload)
	. = ..()
	visor_toggling()
	update_appearance()
	register_context()

/obj/item/clothing/head/helmet/space/plasmaman/add_stabilizer(loose_hat = FALSE)
	..()

/obj/item/clothing/head/helmet/space/plasmaman/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	context[SCREENTIP_CONTEXT_ALT_LMB] = "Toggle Welding Screen"
	if(istype(held_item, /obj/item/toy/crayon))
		context[SCREENTIP_CONTEXT_LMB] = "Vandalize"

	return CONTEXTUAL_SCREENTIP_SET

/obj/item/clothing/head/helmet/space/plasmaman/click_alt(mob/user)
	adjust_visor(user)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/head/helmet/space/plasmaman/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/toggle_welding_screen))
		adjust_visor(user)
		return

	return ..()

/obj/item/clothing/head/helmet/space/plasmaman/adjust_visor(mob/living/user)
	. = ..()
	if(!.)
		return
	if(helmet_on)
		to_chat(user, span_notice("A tocha do seu capacete não pode passar pelo seu visor de solda!"))
		set_light_on(FALSE)
		helmet_on = FALSE
	playsound(src, up ? SFX_VISOR_UP : SFX_VISOR_DOWN, 50, TRUE)
	update_appearance()

/obj/item/clothing/head/helmet/space/plasmaman/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][helmet_on ? "-light":""]"
	inhand_icon_state = icon_state

/obj/item/clothing/head/helmet/space/plasmaman/update_overlays()
	. = ..()
	if(!up)
		. += visor_icon
	if(smile)
		var/mutable_appearance/smiley = mutable_appearance(icon, smile_state)
		smiley.color = smile_color
		. += smiley

/obj/item/clothing/head/helmet/space/plasmaman/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/toy/crayon))
		return NONE

	if(smile)
		to_chat(user, span_warning("Parece que alguém já desenhou algo sobre [src] O visor!"))
		return ITEM_INTERACT_BLOCKING

	var/obj/item/toy/crayon/crayon = tool
	to_chat(user, span_notice("Você começa a desenhar um rosto sorridente [src] O visor..."))
	if(!do_after(user, 2.5 SECONDS, target = src))
		return ITEM_INTERACT_BLOCKING

	smile = TRUE
	smile_color = crayon.paint_color
	to_chat(user, "Você desenha um sorriso [src] Viseira.")
	update_appearance()
	return ITEM_INTERACT_SUCCESS

///By the by, helmets have the update_icon_updates_onmob element, so we don't have to call mob.update_worn_head()
/obj/item/clothing/head/helmet/space/plasmaman/worn_overlays(mutable_appearance/standing, isinhands)
	. = ..()
	if(!isinhands && !up)
		// BUBBER EDIT START
		. += mutable_appearance(worn_icon, visor_icon)
		// BUBBER EDIT END

/obj/item/clothing/head/helmet/space/plasmaman/separate_worn_overlays(mutable_appearance/standing, mutable_appearance/draw_target, isinhands = FALSE, icon_file)
	. = ..()
	if(!isinhands && smile)
		// BUBBER EDIT START
		var/mutable_appearance/smiley = mutable_appearance(worn_icon, smile_state)
		// BUBBER EDIT END
		smiley.color = smile_color
		. += smiley

/obj/item/clothing/head/helmet/space/plasmaman/wash(clean_types)
	. = NONE
	if(smile && (clean_types & CLEAN_TYPE_HARD_DECAL))
		smile = FALSE
		update_appearance(UPDATE_OVERLAYS)
		. |= COMPONENT_CLEANED|COMPONENT_CLEANED_GAIN_XP
	. |= ..()

/obj/item/clothing/head/helmet/space/plasmaman/attack_self(mob/user)
	helmet_on = !helmet_on
	update_appearance()

	if(helmet_on)
		if(!up)
			to_chat(user, span_notice("A tocha do seu capacete não pode passar pelo seu visor de solda!"))
			set_light_on(FALSE)
			// BUBBER EDIT ADDITION START
			helmet_on = FALSE
			update_appearance()
			// BUBBER EDIT ADDITION END
		else
			set_light_on(TRUE)
	else
		set_light_on(FALSE)

	update_item_action_buttons()

/obj/item/clothing/head/helmet/space/plasmaman/on_saboteur(datum/source, disrupt_duration)
	. = ..()
	if(!helmet_on)
		return FALSE
	helmet_on = FALSE
	update_appearance()
	return TRUE

/obj/item/clothing/head/helmet/space/plasmaman/security
	name = "security plasma envirosuit helmet"
	desc = "Um capacete de contenção de plasma projetado para oficiais de segurança, protegendo-os de queimar vivos, ao lado de outros indesejáveis."
	icon_state = "security_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/head_helmet/plasmaman

/datum/armor/head_helmet/plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/head/helmet/space/plasmaman/security/detective
	name = "detective's plasma envirosuit helmet"
	desc = "Um capacete especial de contenção projetado para detetives, protegendo-os de queimar vivos, ao lado de outros indesejáveis."
	icon_state = "white_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/fedora_det_hat/plasmaman

/datum/armor/fedora_det_hat/plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/head/helmet/space/plasmaman/security/warden
	name = "warden's plasma envirosuit helmet"
	desc = "Um capacete de contenção projetado para o diretor. Um par de listras brancas sendo adicionadas para diferenciá-las de outros membros da segurança."
	icon_state = "warden_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/hats_warden/plasmaman

/datum/armor/hats_warden/plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/head/helmet/space/plasmaman/security/head_of_security
	name = "head of security's plasma envirosuit helmet"
	desc = "Um capacete especial de contenção projetado para o Chefe de Segurança. Um par de listras douradas são adicionadas para diferenciá-las de outros membros da segurança."
	icon_state = "hos_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/hats_hos/plasmaman

/datum/armor/hats_hos/plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/head/helmet/space/plasmaman/prisoner
	name = "prisoner's plasma envirosuit helmet"
	desc = "Um capacete de contenção para prisioneiros."
	icon_state = "prisoner_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/medical
	name = "medical doctor's plasma envirosuit helmet"
	desc = "Um envirohelmet projetado para médicos plasmáticos, tendo duas listras abaixo de seu comprimento para denotar tanto."
	icon_state = "doctor_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/coroner
	name = "coroners's plasma envirosuit helmet"
	desc = "Um envirohelmet projetado para legistas de plasma, com mais vantagem que o modelo habitual."
	icon_state = "coroner_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/paramedic
	name = "paramedic plasma envirosuit helmet"
	desc = "Um Envirohelmet projetado para paramédicos plasmáticos, com listras azuis mais escuras em comparação com o modelo médico."
	icon_state = "paramedic_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/viro
	name = "virology plasma envirosuit helmet"
	desc = "O capacete usado pelas pessoas mais seguras na estação, aqueles que são completamente imunes às monstruosidades que criam."
	icon_state = "virologist_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/chemist
	name = "chemistry plasma envirosuit helmet"
	desc = "Um equipamento de plasma projetado para químicos, duas listras laranjas descendo pelo rosto."
	icon_state = "chemist_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/chief_medical_officer
	name = "chief medical officer's plasma envirosuit helmet"
	desc = "Um capacete especial de contenção projetado para o Oficial Médico Chefe. Uma faixa de ouro aplicada para diferenciá-los de outros médicos."
	icon_state = "cmo_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/science
	name = "science plasma envirosuit helmet"
	desc = "Um homem de plasma envirohelmet projetado para cientistas."
	icon_state = "scientist_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/robotics
	name = "robotics plasma envirosuit helmet"
	desc = "Um homem de plasma envirohelmet projetado para robóticas."
	icon_state = "roboticist_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/genetics
	name = "geneticist's plasma envirosuit helmet"
	desc = "Um homem de plasma envirohelmet projetado para geneticistas."
	icon_state = "geneticist_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/research_director
	name = "research director's plasma envirosuit helmet"
	desc = "Um capacete especial de contenção projetado para o diretor de pesquisa. Um desenho marrom claro é aplicado para diferenciá-los de outros cientistas."
	icon_state = "rd_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/engineering
	name = "engineering plasma envirosuit helmet"
	desc = "Um capacete especialmente projetado para o engenheiro plasmamen, as listras roxas habituais sendo substituídas pela laranja da engenharia."
	icon_state = "engineer_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/space_plasmaman/engineering_atmos

/datum/armor/space_plasmaman/engineering_atmos
	acid = 95

/obj/item/clothing/head/helmet/space/plasmaman/atmospherics
	name = "atmospherics plasma envirosuit helmet"
	desc = "Um capacete especialmente projetado para técnicos de plasma da Atmos, as listras roxas normais sendo substituídas pelo azul da Atmos. Melhorou o escudo térmico."
	icon_state = "atmos_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/space_plasmaman/engineering_atmos
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT // Same protection as the Atmospherics Hardhat

/obj/item/clothing/head/helmet/space/plasmaman/chief_engineer
	name = "chief engineer's plasma envirosuit helmet"
	desc = "Um capacete especial de contenção projetado para o engenheiro chefe, as listras roxas habituais sendo substituídas pelo verde do chefe. Melhorou o escudo térmico."
	icon_state = "ce_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/space_plasmaman/engineering_atmos
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT // Same protection as the Atmospherics Hardhat

/obj/item/clothing/head/helmet/space/plasmaman/cargo
	name = "cargo plasma envirosuit helmet"
	desc = "Um homem de plasma envirohelmet projetado para técnicos de carga e contramestres."
	icon_state = "cargo_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/mining
	name = "mining plasma envirosuit helmet"
	desc = "Um capacete de cáqui dado aos mineradores de plasma operando em lavalândia."
	icon_state = "explorer_envirohelm"
	inhand_icon_state = null
	visor_icon = "explorer_envisor"

/obj/item/clothing/head/helmet/space/plasmaman/chaplain
	name = "chaplain's plasma envirosuit helmet"
	desc = "Um envirohelmet especialmente projetado para apenas o mais piedoso dos plasmamen."
	icon_state = "chap_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/white
	name = "white plasma envirosuit helmet"
	desc = "Um ambiente branco genérico."
	icon_state = "white_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/curator
	name = "curator's plasma envirosuit helmet"
	desc = "Uma pequena modificação em um capacete de traje vazio tradicional, este capacete foi a primeira solução de Nanotrasen para os *problemas logísticos* que vêm com o emprego de plasmamen. Apesar de suas limitações, esses capacetes ainda veem o uso de historiadores e plasmistas da velha escola."
	icon_state = "prototype_envirohelm"
	inhand_icon_state = "void_helmet"
	actions_types = list(/datum/action/item_action/toggle_welding_screen)
	smile_state = "prototype_smile"
	visor_icon = "prototype_envisor"

/obj/item/clothing/head/helmet/space/plasmaman/botany
	name = "botany plasma envirosuit helmet"
	desc = "Um envirohelmet verde e azul que designa seu usuário como botânico. Embora não especificamente projetado para ele, ele protegeria contra pequenos ferimentos relacionados à planta."
	icon_state = "botany_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/janitor
	name = "janitor's plasma envirosuit helmet"
	desc = "Um capacete cinza com um par de listras roxas, designando o usuário como zelador."
	icon_state = "janitor_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/mime
	name = "mime envirosuit helmet"
	desc = "A maquiagem está pintada, é um milagre que não bata. Não é muito colorido."
	icon_state = "mime_envirohelm"
	inhand_icon_state = null
	visor_icon = "mime_envisor"

/obj/item/clothing/head/helmet/space/plasmaman/clown
	name = "clown envirosuit helmet"
	desc = "A maquiagem está pintada, é um milagre que não bata.<i>HONK!</i>"
	icon_state = "clown_envirohelm"
	inhand_icon_state = null
	visor_icon = "clown_envisor"
	smile_state = "clown_smile"

/obj/item/clothing/head/helmet/space/plasmaman/clown/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CLOWN, CELL_VIRUS_TABLE_GENERIC, rand(2,3), 0)

/obj/item/clothing/head/helmet/space/plasmaman/head_of_personnel
	name = "head of personnel's envirosuit helmet"
	desc = "Um capacete especial de contenção projetado para o Chefe de Pessoal. Embaraçosamente, parece muito com o projeto do capitão salvo para as listras vermelhas."
	icon_state = "hop_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/hats_hopcap/plasmaman

/datum/armor/hats_hopcap/plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/head/helmet/space/plasmaman/captain
	name = "captain's plasma envirosuit helmet"
	desc = "Um capacete especial de contenção projetado para o Capitão. Embaraçosamente, parece muito com o projeto do Chefe de Pessoal, exceto para as listras de ouro. Quero dizer, qual é. Faixas de ouro podem consertar qualquer coisa."
	icon_state = "captain_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/hats_caphat/plasmaman

/datum/armor/hats_caphat/plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/head/helmet/space/plasmaman/centcom_commander
	name = "CentCom commander plasma envirosuit helmet"
	desc = "Um capacete especial de contenção projetado para o Alto Comando Central. Não existem muitos desses, pois a CentCom normalmente não emprega plasmistas para cargos superiores devido às suas complicações."
	icon_state = "commander_envirohelm"
	inhand_icon_state = null
	armor_type = /datum/armor/hats_centhat/plasmaman

/datum/armor/hats_centhat/plasmaman
	bio = 100
	fire = 100
	acid = 75

/obj/item/clothing/head/helmet/space/plasmaman/centcom_official
	name = "CentCom official plasma envirosuit helmet"
	desc = "Um capacete de contenção especial projetado para o pessoal da CentCom. Eles adoram o verde."
	icon_state = "official_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/centcom_intern
	name = "CentCom intern plasma envirosuit helmet"
	desc = "Um capacete de contenção especial projetado para o pessoal da CentCom. Qualquer derramamento de café não mata o pobre coitado."
	icon_state = "intern_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/syndie
	name = "tacticool envirosuit helmet"
	desc = "Não há dúvida, este capacete coloca você acima de todos os outros plasmamen. Se vir outro homem de plasma usando um capacete como este, ou é porque eles são durões, ou eles mataram um dos seus companheiros valentões e o tiraram deles como troféu. De qualquer forma, qualquer um que use isso merece pelo menos um leve aceno de respeito."
	icon_state = "syndie_envirohelm"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/space/plasmaman/bitrunner
	name = "bitrunner's plasma envirosuit helmet"
	desc = "Um envirohelmet com extensos filtros de luz azul para plasmógrafos bitruning."
	icon_state = "bitrunner_envirohelm"
