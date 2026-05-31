/*
Stabilized extracts:
	Provides a passive buff to the holder.
*/

//To add: Create an effect in crossbreeding/_status_effects.dm with the name "/datum/status_effect/stabilized/[color]"
//Status effect will automatically be applied while held, and lost on drop.

/obj/item/slimecross/stabilized
	name = "stabilized extract"
	desc = "Parece inerte, mas tudo que toca suavemente..."
	effect = "stabilized"
	icon_state = "stabilized"
	var/datum/status_effect/linked_effect

/obj/item/slimecross/stabilized/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj,src)

/obj/item/slimecross/stabilized/Destroy()
	STOP_PROCESSING(SSobj,src)
	qdel(linked_effect)
	return ..()

/// Returns the mob that is currently holding us if we are either in their inventory or a backpack analogue.
/// Returns null if it's in an invalid location, so that we can check explicitly for null later.
/obj/item/slimecross/stabilized/proc/get_held_mob()
	if(isnull(loc))
		return null
	if(isliving(loc))
		return loc
	// Snowflake check for modsuit backpacks, which should be valid but are 3 rather than 2 steps from the owner
	if(istype(loc, /obj/item/mod/module/storage))
		var/obj/item/mod/module/storage/mod_backpack = loc
		var/mob/living/modsuit_wearer = mod_backpack.mod?.wearer
		return modsuit_wearer ? modsuit_wearer : null
	var/nested_loc = loc.loc
	if (isliving(nested_loc))
		return nested_loc
	return null

/obj/item/slimecross/stabilized/process()
	var/mob/living/holder = get_held_mob()
	if(isnull(holder))
		return
	var/effectpath = /datum/status_effect/stabilized
	var/static/list/effects = subtypesof(/datum/status_effect/stabilized)
	for(var/datum/status_effect/stabilized/effect as anything in effects)
		if(initial(effect.colour) != colour)
			continue
		effectpath = effect
		break
	if (holder.has_status_effect(effectpath))
		return
	holder.apply_status_effect(effectpath, src)
	return PROCESS_KILL

//Colors and subtypes:
/obj/item/slimecross/stabilized/grey
	colour = SLIME_TYPE_GREY
	effect_desc = "Faz lodo amigo do dono"

/obj/item/slimecross/stabilized/orange
	colour = SLIME_TYPE_ORANGE
	effect_desc = "Passamente tenta aumentar ou diminuir a temperatura corporal do dono para normal"

/obj/item/slimecross/stabilized/purple
	colour = SLIME_TYPE_PURPLE
	effect_desc = "Proporciona um efeito de regeneração."

/obj/item/slimecross/stabilized/blue
	colour = SLIME_TYPE_BLUE
	effect_desc = "Torna o dono imune a escorregar na água, sabão ou espuma. O lubrificante espacial e o gelo ainda são muito escorregadios."

/obj/item/slimecross/stabilized/metal
	colour = SLIME_TYPE_METAL
	effect_desc = "A cada 30 segundos, adiciona uma folha de material a uma pilha aleatória na mochila do dono."

/obj/item/slimecross/stabilized/yellow
	colour = SLIME_TYPE_YELLOW
	effect_desc = "A cada dez segundos volta um dispositivo no dono em 10%."

/obj/item/slimecross/stabilized/darkpurple
	colour = SLIME_TYPE_DARK_PURPLE
	effect_desc = "Dá a ponta dos dedos queimando, cozinhando automaticamente qualquer alimento microwavable que você segura."

/obj/item/slimecross/stabilized/darkblue
	colour = SLIME_TYPE_DARK_BLUE
	effect_desc = "Lentamente apaga o dono se eles estão em chamas, também molha itens como cubos de macaco, criando um macaco."

/obj/item/slimecross/stabilized/silver
	colour = SLIME_TYPE_SILVER
	effect_desc = "Reduz a taxa de perda de nutrição."

/obj/item/slimecross/stabilized/bluespace
	colour = SLIME_TYPE_BLUESPACE
	effect_desc = "Em dois minutos, quando o dono já sofreu danos suficientes, eles são teleportados para um lugar seguro."

/obj/item/slimecross/stabilized/sepia
	colour = SLIME_TYPE_SEPIA
	effect_desc = "Ajustando a velocidade do dono."

/obj/item/slimecross/stabilized/cerulean
	colour = SLIME_TYPE_CERULEAN
	effect_desc = "Cria uma duplicata do dono. Se o dono morrer, eles assumirão o controle da duplicata, a menos que a morte tenha sido de decapitação ou gibbing."

/obj/item/slimecross/stabilized/pyrite
	colour = SLIME_TYPE_PYRITE
	effect_desc = "Colore aleatoriamente o dono a cada segundo."

/obj/item/slimecross/stabilized/red
	colour = SLIME_TYPE_RED
	effect_desc = "Nulifica todas as mudanças de velocidade."

/obj/item/slimecross/stabilized/green
	colour = SLIME_TYPE_GREEN
	effect_desc = "Muda o nome e aparência do dono enquanto segura este extrato."

/obj/item/slimecross/stabilized/pink
	colour = SLIME_TYPE_PINK
	effect_desc = "Enquanto nenhuma criatura for ferida no pressentimento do dono, eles não vão atacar você. Se a paz é quebrada leva dois minutos para restaurar."

/obj/item/slimecross/stabilized/gold
	colour = SLIME_TYPE_GOLD
	effect_desc = "Cria um animal de estimação quando está preso."
	var/mob_type
	var/datum/mind/saved_mind
	var/mob_name = "Familiar"

/obj/item/slimecross/stabilized/gold/proc/generate_mobtype()
	var/static/list/mob_spawn_pets = list()
	if(!length(mob_spawn_pets))
		for(var/mob/living/simple_animal/animal as anything in subtypesof(/mob/living/simple_animal))
			if(initial(animal.gold_core_spawnable) == FRIENDLY_SPAWN)
				mob_spawn_pets += animal
		for(var/mob/living/basic/basicanimal as anything in subtypesof(/mob/living/basic))
			if(initial(basicanimal.gold_core_spawnable) == FRIENDLY_SPAWN)
				mob_spawn_pets += basicanimal
	mob_type = pick(mob_spawn_pets)

/obj/item/slimecross/stabilized/gold/Initialize(mapload)
	. = ..()
	generate_mobtype()

/obj/item/slimecross/stabilized/gold/attack_self(mob/user)
	var/choice = tgui_input_list(user, "Which do you want to reset?", "Familiar Adjustment", sort_list(list("Familiar Location", "Familiar Species", "Familiar Sentience", "Familiar Name")))
	if(isnull(choice))
		return
	if(!user.can_perform_action(src))
		return
	if(isliving(user))
		var/mob/living/L = user
		if(L.has_status_effect(/datum/status_effect/stabilized/gold))
			L.remove_status_effect(/datum/status_effect/stabilized/gold)
	if(choice == "Familiar Location")
		to_chat(user, span_notice("Você arremesso.[src], estremeceligeiramente."))
		START_PROCESSING(SSobj, src)
	if(choice == "Familiar Species")
		to_chat(user, span_notice("Você aperta.[src]E uma forma parece mudar para dentro."))
		generate_mobtype()
		START_PROCESSING(SSobj, src)
	if(choice == "Familiar Sentience")
		to_chat(user, span_notice("Você cutuca.[src]E deixa sair um pulso brilhante."))
		saved_mind = null
		START_PROCESSING(SSobj, src)
	if(choice == "Familiar Name")
		var/newname = sanitize_name(tgui_input_text(user, "Would you like to change the name of [mob_name]", "Name change", mob_name, MAX_NAME_LEN))
		if(newname)
			mob_name = newname
		to_chat(user, span_notice("Você fala suavemente em[src], e tremeligeiramente em resposta."))
		START_PROCESSING(SSobj, src)

/obj/item/slimecross/stabilized/oil
	colour = SLIME_TYPE_OIL
	effect_desc = "O dono vai explodir violentamente quando eles morrerem perto de seguram este extrato."

/obj/item/slimecross/stabilized/black
	colour = SLIME_TYPE_BLACK
	effect_desc = "Enquanto estrangula alguém, as mãos do dono derretem em volta do pescoço, drenando sua vida em troca de comida e cura."

/obj/item/slimecross/stabilized/lightpink
	colour = SLIME_TYPE_LIGHT_PINK
	effect_desc = "O dono se move em alta velocidade enquanto segura o extrato, também estabiliza qualquer um em estado crítico ao seu redor usando Epinefrina."

/obj/item/slimecross/stabilized/adamantine
	colour = SLIME_TYPE_ADAMANTINE
	effect_desc = "O dono ganha um pequeno impulso na resistência aos danos de todos os tipos."

/obj/item/slimecross/stabilized/rainbow
	colour = SLIME_TYPE_RAINBOW
	effect_desc = "Aceita um extrato regenerativo e o usa automaticamente se o dono entrar em uma condição crítica."
	/// Regenerative crossbreed stored to be autoused on critted owner
	var/obj/item/slimecross/regenerative/regencore

/obj/item/slimecross/stabilized/rainbow/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/slimecross/regenerative))
		return NONE

	if(regencore)
		to_chat(user, span_warning("[src]Já tem um cruzamento regenerativo armazenado nele!"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("Seu lugar.[tool]Em[src]Preparando o extrato para aplicação automática!"))
	regencore = tool
	tool.forceMove(src)
	return ITEM_INTERACT_SUCCESS
