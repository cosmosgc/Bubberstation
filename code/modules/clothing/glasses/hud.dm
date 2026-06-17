/obj/item/clothing/glasses/hud
	gender = NEUTER
	name = "HUD"
	desc = "Um heads-up que fornece informações importantes em (quase) tempo real."
	flags_1 = null //doesn't protect eyes because it's a monocle, duh
	actions_types = list(/datum/action/item_action/toggle_wearable_hud)
	/// Whether the HUD info is on or off
	var/display_active = TRUE

/obj/item/clothing/glasses/hud/emp_act(severity)
	. = ..()
	if(obj_flags & EMAGGED || . & EMP_PROTECT_SELF)
		return
	obj_flags |= EMAGGED
	desc = "[desc] The display is flickering slightly."

/obj/item/clothing/glasses/hud/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	obj_flags |= EMAGGED
	balloon_alert(user, "Exibição embaralhada")
	desc = "[desc] The display is flickering slightly."
	return TRUE

/obj/item/clothing/glasses/hud/suicide_act(mob/living/user)
	if(user.is_blind())
		return SHAME
	var/mob/living/living_user = user
	user.visible_message(span_suicide("[user] looks through [src] and looks overwhelmed with the information! It looks like [user.p_theyre()] trying to commit suicide!"))
	if(living_user.get_organ_loss(ORGAN_SLOT_BRAIN) >= BRAIN_DAMAGE_SEVERE)
		var/mob/thing = pick((/mob in view()) - user)
		if(thing)
			user.say("VALID MAN IS WANTER, ARREST HE!!")
			user.pointed(thing)
		else
			user.say("WHY IS THERE A BAR ON MY HEAD?!!")
	return OXYLOSS

/obj/item/clothing/glasses/hud/equipped(mob/living/user, slot)
	. = ..()
	display_active = TRUE

/obj/item/clothing/glasses/hud/proc/toggle_hud_display(mob/living/carbon/eye_owner)
	if(display_active)
		display_active = FALSE
		for(var/hud_trait in clothing_traits)
			REMOVE_CLOTHING_TRAIT(eye_owner, hud_trait)
		balloon_alert(eye_owner, "Hud desativado.")
		return

	display_active = TRUE
	for(var/hud_trait in clothing_traits)
		ADD_CLOTHING_TRAIT(eye_owner, hud_trait)
	balloon_alert(eye_owner, "Hud ativado.")

/obj/item/clothing/glasses/hud/health
	name = "health scanner HUD"
	desc = "Um heads-up que escaneia os humanóides em vista e fornece dados precisos sobre seu estado de saúde."
	icon_state = "healthhud"
	clothing_traits = list(TRAIT_MEDICAL_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/lightblue

/obj/item/clothing/glasses/hud/medsechud
	name = "health scanner security HUD"
	desc = "Um heads-up que verifica os humanóides em vista e fornece dados precisos sobre seu estado de saúde, status de identificação e registros de segurança."
	icon_state = "medsechud"
	clothing_traits = list(TRAIT_MEDICAL_HUD, TRAIT_SECURITY_HUD)

/obj/item/clothing/glasses/hud/health/night
	name = "night vision health scanner HUD"
	desc = "Uma exibição médica avançada que permite que os médicos encontrem pacientes em completa escuridão."
	icon_state = "healthhudnight"
	inhand_icon_state = "glasses"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	flags_cover = GLASSESCOVERSEYES
	// Blue green, dark
	color_cutoffs = list(20, 20, 45)
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen
	actions_types = list(/datum/action/item_action/toggle_nv)

/obj/item/clothing/glasses/hud/health/night/update_icon_state()
	. = ..()
	icon_state = length(color_cutoffs) ? initial(icon_state) : "night_off"

/obj/item/clothing/glasses/hud/health/night/meson
	name = "night vision meson health scanner HUD"
	desc = "Realmente combate pronto."
	vision_flags = SEE_TURFS

/obj/item/clothing/glasses/hud/health/night/science
	name = "night vision medical science scanner HUD"
	desc = "Uma exibição clandestina de ciência médica que permite que os agentes encontrem\
ambos os capitães morrendo e o veneno perfeito para acabar com eles, todos em completa escuridão."
	clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_MEDICAL_HUD)

/obj/item/clothing/glasses/hud/health/sunglasses
	gender = PLURAL
	name = "medical HUDSunglasses"
	desc = "Óculos de sol com um HUD médico."
	icon_state = "sunhudmed"
	flash_protect = FLASH_PROTECTION_FLASH
	flags_cover = GLASSESCOVERSEYES
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/blue
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.55, /datum/material/iron = SMALL_MATERIAL_AMOUNT / 2)

/obj/item/clothing/glasses/hud/health/sunglasses/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/hudsunmedremoval)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/clothing/glasses/hud/diagnostic
	name = "diagnostic HUD"
	desc = "Uma tela heads-up capaz de analisar a integridade e o status da robótica e exossuits."
	icon_state = "diagnostichud"
	clothing_traits = list(TRAIT_DIAGNOSTIC_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/lightorange

/obj/item/clothing/glasses/hud/diagnostic/night
	name = "night vision diagnostic HUD"
	desc = "Um diagnóstico de robótica com um amplificador de luz."
	icon_state = "diagnostichudnight"
	inhand_icon_state = "glasses"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	flags_cover = GLASSESCOVERSEYES
	// Pale yellow
	color_cutoffs = list(25, 15, 5)
	glass_colour_type = /datum/client_colour/glass_colour/lightyellow
	actions_types = list(/datum/action/item_action/toggle_nv)

/obj/item/clothing/glasses/hud/diagnostic/night/update_icon_state()
	. = ..()
	icon_state = length(color_cutoffs) ? initial(icon_state) : "night_off"

/obj/item/clothing/glasses/hud/diagnostic/sunglasses
	gender = PLURAL
	name = "diagnostic sunglasses"
	desc = "Óculos de sol com um HUD diagnóstico."
	icon_state = "sunhuddiag"
	inhand_icon_state = "glasses"
	flash_protect = FLASH_PROTECTION_FLASH
	flags_cover = GLASSESCOVERSEYES
	tint = 1
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.55, /datum/material/iron = SMALL_MATERIAL_AMOUNT / 2)

/obj/item/clothing/glasses/hud/diagnostic/sunglasses/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/hudsundiagremoval)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/clothing/glasses/hud/security
	name = "security HUD"
	desc = "Um heads-up que verifica os humanóides em vista e fornece dados precisos sobre seu status de identificação e registros de segurança."
	icon_state = "securityhud"
	clothing_traits = list(TRAIT_SECURITY_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/hud/security/chameleon
	name = "chameleon security HUD"
	desc = "Um HUD de segurança roubado integrado com tecnologia de camaleão Syndicate. Fornece proteção flash."
	flash_protect = FLASH_PROTECTION_FLASH
	actions_types = list(/datum/action/item_action/chameleon/change/glasses/no_preset)

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	name = "eyepatch HUD"
	desc = "O primo mais legal dos óculos."
	icon_state = "hudpatch"
	base_icon_state = "hudpatch"
	actions_types = list(/datum/action/item_action/flip)

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/attack_self(mob/user, modifiers)
	. = ..()
	icon_state = (icon_state == base_icon_state) ? "[base_icon_state]_flipped" : base_icon_state
	user.update_worn_glasses()

/obj/item/clothing/glasses/hud/security/sunglasses
	gender = PLURAL
	name = "security HUDSunglasses"
	desc = "Óculos de sol com um HUD de segurança."
	icon_state = "sunhudsec"
	flash_protect = FLASH_PROTECTION_FLASH
	flags_cover = GLASSESCOVERSEYES
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/darkred
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.55, /datum/material/iron = SMALL_MATERIAL_AMOUNT / 2)

/obj/item/clothing/glasses/hud/security/sunglasses/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/hudsunsecremoval)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/clothing/glasses/hud/security/night
	name = "night vision security HUD"
	desc = "Um heads-up avançado que fornece dados de identificação e visão em completa escuridão."
	icon_state = "securityhudnight"
	flash_protect = FLASH_PROTECTION_SENSITIVE
	flags_cover = GLASSESCOVERSEYES
	// Red with a tint of green
	color_cutoffs = list(40, 15, 10)
	glass_colour_type = /datum/client_colour/glass_colour/lightred
	actions_types = list(/datum/action/item_action/toggle_nv)

/obj/item/clothing/glasses/hud/security/night/update_icon_state()
	. = ..()
	icon_state = length(color_cutoffs) ? initial(icon_state) : "night_off"

/obj/item/clothing/glasses/hud/security/sunglasses/gars
	gender = PLURAL
	name = "\improper HUD gar glasses"
	desc = "Óculos GAR com HUD."
	icon_state = "gar_sec"
	inhand_icon_state = "gar_black"
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
	force = 10
	throwforce = 10
	throw_speed = 4
	attack_verb_continuous = list("slices")
	attack_verb_simple = list("slice")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED

/obj/item/clothing/glasses/hud/security/sunglasses/gars/giga
	name = "giga HUD gar glasses"
	desc = "Giga Gar óculos com um HUD."
	icon_state = "gigagar_sec"
	force = 12
	throwforce = 12

/obj/item/clothing/glasses/hud/toggle
	name = "Toggle HUD"
	desc = "Um hud com múltiplas funções."
	flags_cover = GLASSESCOVERSEYES
	actions_types = list(/datum/action/item_action/switch_hud)

/obj/item/clothing/glasses/hud/toggle/attack_self(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/wearer = user
	if (wearer.glasses != src)
		return

	if (TRAIT_MEDICAL_HUD in clothing_traits)
		detach_clothing_traits(TRAIT_MEDICAL_HUD)
	else if (TRAIT_SECURITY_HUD in clothing_traits)
		detach_clothing_traits(TRAIT_MEDICAL_HUD)
		attach_clothing_traits(TRAIT_SECURITY_HUD)
	else
		detach_clothing_traits(TRAIT_MEDICAL_HUD)
		attach_clothing_traits(TRAIT_SECURITY_HUD)

/datum/action/item_action/switch_hud
	name = "Switch HUD"

/obj/item/clothing/glasses/hud/toggle/thermal
	name = "thermal HUD scanner"
	desc = "Imagem térmica em forma de óculos."
	icon_state = "thermal"
	vision_flags = SEE_MOBS
	color_cutoffs = list(25, 8, 5)
	glass_colour_type = /datum/client_colour/glass_colour/red
	clothing_traits = list(TRAIT_SECURITY_HUD)

/obj/item/clothing/glasses/hud/toggle/thermal/attack_self(mob/user)
	..()
	var/hud_type
	if (LAZYLEN(clothing_traits))
		hud_type = clothing_traits[1]
	switch (hud_type)
		if (TRAIT_MEDICAL_HUD)
			icon_state = "meson"
			color_cutoffs = list(5, 15, 5)
			change_glass_color(/datum/client_colour/glass_colour/green)
		if (TRAIT_SECURITY_HUD)
			icon_state = "thermal"
			color_cutoffs = list(25, 8, 5)
			change_glass_color(/datum/client_colour/glass_colour/red)
		else
			icon_state = "purple"
			color_cutoffs = list(15, 0, 25)
			change_glass_color(/datum/client_colour/glass_colour/purple)
	user.update_sight()
	user.update_worn_glasses()

/obj/item/clothing/glasses/hud/toggle/thermal/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	thermal_overload()

/obj/item/clothing/glasses/hud/spacecop
	gender = PLURAL
	name = "police aviators"
	desc = "Por pensar que você parece legal enquanto brutaliza manifestantes e minorias."
	icon_state = "bigsunglasses"
	flash_protect = FLASH_PROTECTION_FLASH
	flags_cover = GLASSESCOVERSEYES
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/gray


/obj/item/clothing/glasses/hud/spacecop/hidden // for the undercover cop
	gender = PLURAL
	name = "sunglasses"
	desc = "Esses óculos de sol são especiais, e deixar você ver criminosos em potencial."
	icon_state = "sun"
	inhand_icon_state = "sunglasses"
