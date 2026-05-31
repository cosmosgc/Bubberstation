/datum/glass_style/has_foodtype/drinking_glass/eggnog          //Eggnog doesn't have a custom glass in the dm where
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi' //it should (mixed_alcohol.dm), so this exists to give it a glass.
	icon_state = "eggnog"

/datum/reagent/consumable/moth_milk
	name = "Moth Milk"
	description = "Quem achou que ordenhar mariposas era uma boa ideia estava totalmente errado. É mesmo leite?"
	color = "#F0E9DA" // rgb: 240, 233, 218
	taste_description = "substância salgada e oleosa"
	ph = 6.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/moth_milk/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	if(!ismoth(M))
		M.adjust_disgust(10 * REM * delta_time,DISGUST_LEVEL_DISGUSTED)
		return UPDATE_MOB_HEALTH


/mob/living/basic/mothroach/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/udder, reagent_produced_override = /datum/reagent/consumable/moth_milk)


/datum/reagent/consumable/icetea/blood_tea
	name = "Hemoglobin Iced Tea"
	description = "Uma mistura de sangue e chá gelado, com uma fatia de tomate suculento como um enfeite."
	color = "#B85D52"//rgb(184, 93, 82)
	quality = DRINK_GOOD
	taste_description = "Chá doce com uma mordida de ferro."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/icetea/blood_tea/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(affected_mob) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/blood_tea
	required_drink_type = /datum/reagent/consumable/icetea/blood_tea
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "bloodteaglass"
	name = "cup of hemoglobin iced tea"
	desc = "Delicioso chá gelado com sabor de sangue."


/datum/reagent/consumable/coffee/blood_coffee
	name = "Blood Coffee"
	description = "Café preto quente misturado com sangue rico, o favorito de um hemofago!"
	color = "#8E272B"//rgb(142, 39, 43)
	quality = DRINK_GOOD
	taste_description = "Ferro amargo."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/coffee/blood_coffee/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(affected_mob) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/blood_coffee
	required_drink_type = /datum/reagent/consumable/coffee/blood_coffee
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "bloodcoffeeglass"
	name = "mug of blood coffee"
	desc = "Uma caneca de café preto quente misturado com sangue fresco."


/datum/reagent/consumable/intraverde
	name = "Intraverde"
	description = "Um refrigerante de melão cheio de chantilly."
	color = "#40e729"
	quality = DRINK_GOOD
	taste_description = "Açúcar e um pouco de lábio."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/intraverde/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(affected_mob) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/intraverde
	required_drink_type = /datum/reagent/consumable/intraverde
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "intraverde"
	name = "Intraverde"
	desc = "Um carro alegórico, muitas vezes solicitado por hemofármacos que ainda têm o gosto por ichor. A blusa de chantilly está cheia de sangue."


/datum/reagent/consumable/ethanol/venetian_waltz
	name = "Venetian Waltz"
	description = "Um coquetel de sobremesa de chocolate, feito para bebedores de sangue."
	color = "#38210b"
	boozepwr = 15
	quality = DRINK_GOOD
	taste_description = "Chocolate escuro e sangrento"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/venetian_waltz/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(affected_mob) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/venetian_waltz
	required_drink_type = /datum/reagent/consumable/ethanol/venetian_waltz
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "venetian_waltz"
	name = "Venetian Waltz"
	desc = "Apesar da apresentação, é ridicularizado pelas gerações mais velhas por seu sabor de sobremesa, e é relegado para as mesas de irmandades e heemoboos como punição."


/datum/reagent/consumable/ethanol/cranberry_cadillac
	name = "Cranberry Cadillac"
	description = "Um coquetel borbulhante, recheado de doces."
	color = "#ac1e2a"
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "Um atropelamento e fuga feito de doces"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/cranberry_cadillac/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(affected_mob) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/cranberry_cadillac
	required_drink_type = /datum/reagent/consumable/ethanol/cranberry_cadillac
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "cranberry_cadillac"
	name = "Cranberry Cadillac"
	desc = "Os cristais de açúcar que bordam o vidro são vermelhos com sangue real, convidando os famintos a lambê-lo limpo. Serviu com meia fatia de limão para contrariar a doçura."


/datum/reagent/consumable/ethanol/jubokko
	name = "Jubokko"
	description = "Uma bebida de saquê, e Yukake misturado com sangue."
	color = "#ac1e2a"
	boozepwr = 30
	quality = DRINK_GOOD
	taste_description = "O perigo se aproxima acima de você"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/jubokko/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(affected_mob) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/jubokko
	required_drink_type = /datum/reagent/consumable/ethanol/jubokko
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "jubokko"
	name = "Jubokko"
	desc = "O chaebol marciano, que bebe sangue, serve isso aos convidados. Por mais de bom gosto que pareça, qualquer bom poeta sabe prefigurar quando é colocado na frente deles."


/datum/reagent/consumable/ethanol/morocco_coffin
	name = "Morocco Coffin"
	description = "Um café frio com um toque de ferro."
	color = "#200608"
	boozepwr = 20
	overdose_threshold = 75
	quality = DRINK_GOOD
	taste_description = "Acordar à meia-noite"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/morocco_coffin/overdose_process(mob/living/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.set_jitter_if_lower(10 SECONDS * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/morocco_coffin/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.adjust_dizzy(-10 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_drowsiness(-6 SECONDS * REM * seconds_per_tick)
	affected_mob.AdjustSleeping(-4 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-5 * REM * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/ethanol/morocco_coffin/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(affected_mob) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/morocco_coffin
	required_drink_type = /datum/reagent/consumable/ethanol/morocco_coffin
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "morocco_coffin"
	name = "Morocco Coffin"
	desc = "Por acordar quando o sol se põe. Te acalma e te acorda."


/datum/reagent/consumable/ethanol/bat_outta_hell
	name = "Bat Outta' Hell"
	description = "Touro corajoso misturado com sangue, com um absinto \"Verniz\"Sentido em Cima."
	color = "#3d1013"
	boozepwr = 70
	overdose_threshold = 47
	quality = DRINK_VERYGOOD
	taste_description = "A emoção ofuscante de um Home Run, baby!"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING
	metabolization_rate = 1.2 * REAGENTS_METABOLISM

/datum/reagent/consumable/ethanol/bat_outta_hell/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.remove_status_effect(/datum/status_effect/drowsiness)
	affected_mob.AdjustSleeping(-2 SECONDS * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/bat_outta_hell/overdose_process(mob/living/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.add_traits(list(TRAIT_GOOD_HEARING, TRAIT_MINOR_NIGHT_VISION),"Overdose:/datum/reagent/consumable/ethanol/bat_outta_hell")
	metabolization_rate = 4.5 * REAGENTS_METABOLISM
	affected_mob.set_jitter_if_lower(5 SECONDS * REM * seconds_per_tick)
	affected_mob.set_dizzy_if_lower(5 SECONDS * REM * seconds_per_tick)
	affected_mob.set_temp_blindness_if_lower(5 SECONDS * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/bat_outta_hell/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_traits(list(TRAIT_GOOD_HEARING, TRAIT_MINOR_NIGHT_VISION),"Overdose:/datum/reagent/consumable/ethanol/bat_outta_hell")

/datum/reagent/consumable/ethanol/bat_outta_hell/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !ishemophage(affected_mob) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/bat_outta_hell
	required_drink_type = /datum/reagent/consumable/ethanol/bat_outta_hell
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "bat_outta_hell"
	name = "Bat Outta' Hell"
	desc = "Forte o suficiente para te mandar voar para fora do parque! Ou talvez tropeçar..."

//Ethereal Drinks

/datum/reagent/consumable/ethanol/karakrak
	name = "Karakrak"
	description = "Uma ração levemente carregada feita com vinho filtrado"
	color = "#5c0b12"
	boozepwr = 0
	quality = DRINK_NICE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	taste_description = "amargo, diluído energia"

/datum/reagent/consumable/ethanol/karakrak/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 3 * ETHEREAL_DISCHARGE_RATE)

/datum/glass_style/drinking_glass/karakrak
	required_drink_type = /datum/reagent/consumable/ethanol/karakrak
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "karakrak"
	name = "Karakrak"
	desc = "Uma espécie de vinho elétrico e com álcool servia para as castas mais baixas das massas etéreas, tipicamente distribuídas pelo clero. Serviu em uma montanha-russa de borracha para manter a pouca carga de se dissipar na mesa."


/datum/reagent/consumable/ethanol/szzszz
	name = "Szz Szz"
	description = "Uma versão pirata do vinho monástico etéreo"
	color = "#5c0b12"
	boozepwr = 25
	quality = DRINK_GOOD
	taste_description = "Pecado amargo-doce"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)
	var/obj/effect/light_holder

/datum/reagent/consumable/ethanol/szzszz/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 4 * ETHEREAL_DISCHARGE_RATE)
	else //If you are NOT an ethereal, you jitter
		affected_mob.set_jitter_if_lower(10 SECONDS * REM * reac_volume)

/datum/reagent/consumable/ethanol/szzszz/on_mob_metabolize(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..() //Gives glow
	light_holder = new(affected_mob)
	light_holder.set_light(1.3, 1, COLOR_MAROON)

/datum/reagent/consumable/ethanol/szzszz/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != affected_mob)
		light_holder.forceMove(affected_mob)
	return ..()

/datum/reagent/consumable/ethanol/szzszz/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	QDEL_NULL(light_holder)

/datum/glass_style/drinking_glass/szzszz
	required_drink_type = /datum/reagent/consumable/ethanol/szzszz
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "szzszz"
	name = "Szz Szz"
	desc = "Uma versão do vinho monástico exclusivo do Conduit Divino. O sabor foi aproximado por milhares de línguas diferentes, que por ameaça de perseguição, nunca realmente provou."


/datum/reagent/consumable/blumpkin_compot
	name = "Blumpkin Compot"
	description = "Fruta cozida, açúcar e folha de erva. Um energético etéreo."
	color = "#3cc6e9"
	quality = DRINK_VERYGOOD
	taste_description = "Energia limpa e confiável."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/blumpkin_compot/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 7 * ETHEREAL_DISCHARGE_RATE)
	else
		affected_mob.set_jitter_if_lower(10 SECONDS * REM * reac_volume)

/datum/reagent/consumable/blumpkin_compot/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.adjust_dizzy(-10 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_drowsiness(-6 SECONDS * REM * seconds_per_tick)

/datum/glass_style/drinking_glass/blumpkin_compot
	required_drink_type = /datum/reagent/consumable/blumpkin_compot
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "blumpkin_compot"
	name = "Blumpkin Compot"
	desc = "Uma bebida criada por expatriados etéreos feitos de carne ensopada e frutas inteiras. Açúcar ajuda a extrair os elementos condutores, fazendo para uma bebida educadamente energizante que é segura para beber, e também não tem gosto de limpador de janelas."


/datum/reagent/consumable/ethanol/storm_over_avon
	name = "Storm-Over-Avon"
	description = "Um coquetel de menta para artesãos etéreos."
	color = "#ffca37"
	boozepwr = 50
	quality = DRINK_VERYGOOD
	taste_description = "Esnobe energético"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)
	var/obj/effect/light_holder
	var/shock_timer = 0
	var/unluckyshock = 0

/datum/reagent/consumable/ethanol/storm_over_avon/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 8 * ETHEREAL_DISCHARGE_RATE)
	else //If you are not etheral, jitter. Random chance to ZAP you, every sip. Roll a one; zap.
		affected_mob.set_jitter_if_lower(5 SECONDS * REM * reac_volume)
		unluckyshock = rand(1, 15)
		if(unluckyshock == 1)
			to_chat(affected_mob, span_userdanger("Você sente um forte abalo de energia saindo da sua língua!"))
			affected_mob.electrocute_act(rand(1, 5), "Storm-Over-Avon shock", 1, SHOCK_NOGLOVES)
			playsound(affected_mob, 'sound/machines/defib/defib_zap.ogg', 30, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/datum/reagent/consumable/ethanol/storm_over_avon/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.adjust_dizzy(-10 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_drowsiness(-6 SECONDS * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/storm_over_avon/on_mob_metabolize(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..() //Gives glow
	light_holder = new(affected_mob)
	light_holder.set_light(1.3, 1.5, COLOR_BRIGHT_BLUE)

/datum/reagent/consumable/ethanol/storm_over_avon/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != affected_mob)
		light_holder.forceMove(affected_mob)
	return ..()

/datum/reagent/consumable/ethanol/storm_over_avon/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	QDEL_NULL(light_holder)

/datum/glass_style/drinking_glass/storm_over_avon
	required_drink_type = /datum/reagent/consumable/ethanol/storm_over_avon
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "storm_over_avon"
	name = "Storm-Over-Avon"
	desc = "Um coquetel complicado preferido pelos devotos da Nota Eterna. Embora seus ingredientes originais sejam impossíveis de obter de Sprout, este tipo de bebida ainda ressoa com a intenção de que apenas uma eclesiarquia musical possa melhorar. Conhecido por raramente chocar não-eterais."


/datum/reagent/consumable/ethanol/coilhouse_cocktail
	name = "Coilhouse Cocktail"
	description = "Uma bebida eletrificada com suco de laranja e limão."
	color = "#d6ff21"
	boozepwr = 30
	quality = DRINK_VERYGOOD
	taste_description = "Uma bola de discoteca na sua boca."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)
	metabolization_rate = 1.1 * REAGENTS_METABOLISM
	var/obj/effect/light_holder
	var/shock_timer = 0
	var/unluckyshock = 0

/datum/reagent/consumable/ethanol/coilhouse_cocktail/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 6 * ETHEREAL_DISCHARGE_RATE)
	else
		affected_mob.set_jitter_if_lower(10 SECONDS * REM * reac_volume)
		unluckyshock = rand(1, 6)
		if(unluckyshock == 1)
			to_chat(affected_mob, span_userdanger("Você sente um forte abalo de energia saindo da sua língua!"))
			affected_mob.electrocute_act(rand(2, 8), "Coilhouse Cocktail shock", 1, SHOCK_NOGLOVES)
			playsound(affected_mob, 'sound/machines/defib/defib_zap.ogg', 40, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/datum/reagent/consumable/ethanol/coilhouse_cocktail/on_mob_metabolize(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..() //Gives glow
	light_holder = new(affected_mob)
	light_holder.set_light(1.3, 1.5, COLOR_YELLOW)

/datum/reagent/consumable/ethanol/coilhouse_cocktail/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != affected_mob)
		light_holder.forceMove(affected_mob)
	return ..()

/datum/reagent/consumable/ethanol/coilhouse_cocktail/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	QDEL_NULL(light_holder)

/datum/glass_style/drinking_glass/coilhouse_cocktail
	required_drink_type = /datum/reagent/consumable/ethanol/coilhouse_cocktail
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "coilhouse_cocktail"
	name = "Coilhouse Cocktail"
	desc = "Um coquetel etéreo muito bombástico para ter nascido no espaço de Soatii. Também conhecido como um jitter de Shocktown para aqueles não feitos de eletricidade, por razões que se tornarão rapidamente aparentes."


/datum/reagent/consumable/ethanol/electric_avenue
	name = "Electric Avenue"
	description = "Um coquetel feito de ouro e citrinos, com sal."
	color = "#d37810"
	boozepwr = 25
	quality = DRINK_VERYGOOD
	taste_description = "uma cadeira azeda e elétrica."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)
	metabolization_rate = 1.6 * REAGENTS_METABOLISM
	var/obj/effect/light_holder
	var/shock_timer = 0
	var/unluckyshock = 0

/datum/reagent/consumable/ethanol/electric_avenue/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 10 * ETHEREAL_DISCHARGE_RATE)
	else
		affected_mob.set_jitter_if_lower(10 SECONDS * REM * reac_volume)
		unluckyshock = rand(1, 3)
		if(unluckyshock == 1)
			to_chat(affected_mob, span_userdanger("Você sente uma violenta sacudida de energia disparando sua língua!"))
			affected_mob.electrocute_act(rand(15, 35), "Electric avenue shock", 1, SHOCK_NOGLOVES)
			playsound(affected_mob, 'sound/machines/defib/defib_zap.ogg', 55, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/datum/reagent/consumable/ethanol/electric_avenue/on_mob_metabolize(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..() //Gives glow
	light_holder = new(affected_mob)
	light_holder.set_light(1.3, 1.5, COLOR_VERY_SOFT_YELLOW)

/datum/reagent/consumable/ethanol/electric_avenue/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != affected_mob)
		light_holder.forceMove(affected_mob)
	return ..()

/datum/reagent/consumable/ethanol/electric_avenue/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	QDEL_NULL(light_holder)

/datum/glass_style/drinking_glass/electric_avenue
	required_drink_type = /datum/reagent/consumable/ethanol/electric_avenue
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "electric_avenue"
	name = "Electric Avenue"
	desc = "Com o nome de uma localização mítica no Sistema Sol, esta bebida deve ser tomada lentamente através da palha estreita de cobre, representando o sabor longo mas rápido da vida. Mas para não-etéreos, é uma pista de dobra para a sala de emergência."


/datum/reagent/consumable/ethanol/ira_de_zeus
	name = "Ira de Zeus"
	description = "Um coquetel azul fundo feito usando eletricidade e nevoeiro."
	color = "#3e1ef1"
	boozepwr = 60
	quality = DRINK_VERYGOOD
	taste_description = "Hipocracia afiada e temperada."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)
	metabolization_rate = 1.1 * REAGENTS_METABOLISM
	var/obj/effect/light_holder
	var/shock_timer = 0
	var/unluckyshock = 0

/datum/reagent/consumable/ethanol/ira_de_zeus/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 5 * ETHEREAL_DISCHARGE_RATE)
	else
		affected_mob.set_jitter_if_lower(5 SECONDS * REM * reac_volume)
		unluckyshock = rand(1, 8)
		if(unluckyshock == 1)
			to_chat(affected_mob, span_userdanger("Você sente uma violenta sacudida de energia disparando sua língua!"))
			affected_mob.electrocute_act(rand(10, 25), "Ira de Zeus shock", 1, SHOCK_NOGLOVES)
			playsound(affected_mob, 'sound/machines/defib/defib_zap.ogg', 40, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/datum/reagent/consumable/ethanol/ira_de_zeus/on_mob_metabolize(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..() //Gives glow
	light_holder = new(affected_mob)
	light_holder.set_light(1.2, 3.5, COLOR_BRIGHT_BLUE)

/datum/reagent/consumable/ethanol/ira_de_zeus/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	affected_mob.adjust_bodytemperature(15 * REM * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal()+ 20)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != affected_mob)
		light_holder.forceMove(affected_mob)
	return ..()

/datum/reagent/consumable/ethanol/ira_de_zeus/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	QDEL_NULL(light_holder)

/datum/glass_style/drinking_glass/ira_de_zeus
	required_drink_type = /datum/reagent/consumable/ethanol/ira_de_zeus
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "ira_de_zeus"
	name = "Ira De Zeus"
	desc = "Uma bebida etérea radiante que aquece o corpo e faz cócegas na língua. O recipiente original, fábulado de se originar das mesas do clero de Sprout, implicaria heresia da mais alta ordem. Ainda bem que é só uma fábula... Pode chocar não-eterais."

/datum/reagent/consumable/ethanol/orange_creamsicle
	name = "Orange Creamsicle"
	color = "#f8dd64" //(248, 221, 100)
	description = "Uma bebida doce, picante e frutada com um final cremoso."
	boozepwr = 40
	taste_description = "Doces citrinos cremosos e nostalgia"
	quality = DRINK_VERYGOOD

/datum/glass_style/drinking_glass/orange_creamsicle
	required_drink_type = /datum/reagent/consumable/ethanol/orange_creamsicle
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "orange_creamsicle"
	name = "Orange Creamsicle"
	desc = "Uma bebida refrescante de sorvete de laranja em um copo, coberto com um redemoinho de chantilly e uma fatia de laranja. A bebida perfeita para um dia de estação quente, ou quando quiser sentir que está em férias tropicais."
