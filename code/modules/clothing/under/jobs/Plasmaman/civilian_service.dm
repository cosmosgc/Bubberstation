//Basically the assistant suit
/obj/item/clothing/under/plasmaman
	name = "plasma envirosuit"
	desc = "Um traje especial de contenção que permite que formas de vida baseadas em plasma existam em segurança em um ambiente oxigenado, e automaticamente as extingue em uma crise. Apesar de ser hermético, não é digno de espaço."
	icon_state = "plasmaman"
	inhand_icon_state = "plasmaman"
	icon = 'icons/obj/clothing/under/plasmaman.dmi'
	worn_icon = 'icons/mob/clothing/under/plasmaman.dmi'
	clothing_flags = PLASMAMAN_PREVENT_IGNITION | NO_ZONE_DISABLING
	armor_type = /datum/armor/clothing_under/plasmaman
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	can_adjust = FALSE
	strip_delay = 8 SECONDS
	resistance_flags = FIRE_PROOF
	COOLDOWN_DECLARE(extinguish_timer)
	var/extinguish_cooldown = 100
	var/extinguishes_left = 5

/datum/armor/clothing_under/plasmaman
	bio = 100
	fire = 95
	acid = 95

/obj/item/clothing/under/plasmaman/examine(mob/user)
	. = ..()
	. += span_notice("There [extinguishes_left == 1 ? "is" : "are"] [extinguishes_left] extinguisher charges left in this suit.")

/obj/item/clothing/under/plasmaman/equipped(mob/living/user, slot)
	. = ..()
	if (slot & ITEM_SLOT_ICLOTHING)
		RegisterSignals(user, list(COMSIG_MOB_EQUIPPED_ITEM, COMSIG_LIVING_IGNITED, SIGNAL_ADDTRAIT(TRAIT_HEAD_ATMOS_SEALED)), PROC_REF(check_fire_state))
		check_fire_state()

/obj/item/clothing/under/plasmaman/dropped(mob/living/user)
	. = ..()
	UnregisterSignal(user, list(COMSIG_MOB_EQUIPPED_ITEM, COMSIG_LIVING_IGNITED, SIGNAL_ADDTRAIT(TRAIT_HEAD_ATMOS_SEALED)))

/obj/item/clothing/under/plasmaman/proc/check_fire_state(datum/source)
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
	owner.visible_message(span_warning("[owner]'s suit automatically extinguishes [owner.p_them()]!"), span_warning("Seu traje automaticamente o apaga."))
	owner.extinguish_mob()
	new /obj/effect/particle_effect/water(get_turf(owner))

/obj/item/clothing/under/plasmaman/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if (!istype(tool, /obj/item/extinguisher_refill))
		return ..()

	if (extinguishes_left == 5)
		to_chat(user, span_notice("O extintor embutido está cheio."))
		return ITEM_INTERACT_BLOCKING

	extinguishes_left = 5
	to_chat(user, span_notice("Você enche o extintor embutido, usando o cartucho."))
	check_fire_state()
	qdel(tool)
	return ITEM_INTERACT_SUCCESS

/obj/item/extinguisher_refill
	name = "envirosuit extinguisher cartridge"
	desc = "Um cartucho carregado com uma mistura de extintor comprimido, usado para encher o extintor automático em ambientes de plasma."
	icon_state = "plasmarefill"
	icon = 'icons/obj/canisters.dmi'

/obj/item/clothing/under/plasmaman/cargo
	name = "cargo plasma envirosuit"
	desc = "Um traje comum usado por agentes de plasma e técnicos de carga, devido aos problemas logísticos de diferenciar os dois com o comprimento de suas pernas."
	icon_state = "cargo_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/mining
	name = "mining plasma envirosuit"
	desc = "Um traje cáqui hermético projetado para operações em lavalândia por plasmamen."
	icon_state = "explorer_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/chef
	name = "chef's plasma envirosuit"
	desc = "Um ambiente de homem do plasma branco projetado para práticas culinárias. Pode-se questionar porque um membro de uma espécie que não precisa comer se tornaria um chef."
	icon_state = "chef_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/enviroslacks
	name = "enviroslacks"
	desc = "O projeto de um homem de plasma particularmente elegante, este terno personalizado foi rapidamente apropriado por Nanotrasen para seus advogados, e barmans iguais."
	icon_state = "enviroslacks"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/chaplain
	name = "chaplain's plasma envirosuit"
	desc = "Um traje especialmente projetado para apenas o mais piedoso dos plasmamen."
	icon_state = "chap_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/curator
	name = "curator's plasma envirosuit"
	desc = "Feita de um traje vazio modificado, este terno foi a primeira solução de Nanotrasen para os * problemas logísticos * que vêm com o emprego de plasmamen. Devido às modificações, o traje não é mais digno de espaço. Apesar de suas limitações, esses trajes ainda são usados por historiadores e plasmistas."
	icon_state = "prototype_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/janitor
	name = "janitor's plasma envirosuit"
	desc = "Um traje cinza e roxo designado para faxineiros de plasma."
	icon_state = "janitor_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/botany
	name = "botany envirosuit"
	desc = "Um ambiente verde e azul projetado para proteger plasmamen de pequenas lesões relacionadas à planta."
	icon_state = "botany_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/mime
	name = "mime envirosuit"
	desc = "Não é muito colorido."
	icon_state = "mime_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/clown
	name = "clown envirosuit"
	desc = "<i>HONK!</i>"
	icon_state = "clown_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/bitrunner
	name = "bitrunner envirosuit"
	desc = "Uma roupa especialmente projetada para plasmamen com má postura."
	icon_state = "bitrunner_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/clown/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CLOWN, CELL_VIRUS_TABLE_GENERIC, rand(2,3), 0)

/obj/item/clothing/under/plasmaman/prisoner
	name = "prisoner envirosuit"
	desc = "Um navio laranja identificando e protegendo um criminoso. Seus sensores de terno estão presos no\"Totalmente ligado.\"Posição."
	icon_state = "prisoner_envirosuit"
	inhand_icon_state = null
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/plasmaman/clown/check_fire_state(datum/source, datum/status_effect/fire_handler/status_effect)
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
	owner.visible_message(span_warning("[owner]'s suit spews space lube everywhere!"), span_warning("Seu terno vomita lubrificante espacial em todo lugar!"))
	owner.extinguish_mob()
	do_foam(4, src, get_turf(owner), /datum/reagent/lube, 15)
