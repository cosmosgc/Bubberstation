// Modular Booze REAGENTS, see the following file for the mixes: modular_skyrat\modules\customization\modules\food_and_drinks\recipes\drinks_recipes.dm

/datum/reagent/consumable/ethanol/whiskey
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //let's not force the detective to change his alcohol brand


/datum/reagent/consumable/ethanol/bloody_mary
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING


//Drinks from tg that are made with blood, thus hemophages are able to drink them without suffering ill effects

/datum/reagent/consumable/ethanol/demonsblood
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/devilskiss
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/narsour
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/protein_blend
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/red_mead
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

//End of tg blood-based drinks




// ROBOT ALCOHOL PAST THIS POINT
// WOOO!

/datum/reagent/consumable/ethanol/synthanol
	name = "Synthanol"
	description = "Um líquido escorrendo com capacidade condutiva. Seus efeitos nos sintéticos são similares aos do álcool nos orgânicos."
	color = "#1BB1FF"
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC | REAGENT_PROTEAN
	boozepwr = 50
	quality = DRINK_NICE
	taste_description = "óleo de motor"

/datum/glass_style/drinking_glass/synthanol
	required_drink_type = /datum/reagent/consumable/ethanol/synthanol
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi' // This should cover anything synthanol related. Will have to individually tag others unless we make an object path for Skyrat drinks.
	icon_state = "synthanolglass"
	name = "glass of synthanol"
	desc = "O equivalente a álcool para tripulantes sintéticos. Eles achariam horrível se tivessem bom gosto também."

/datum/reagent/consumable/ethanol/synthanol/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(!(affected_mob.mob_biotypes & MOB_ROBOTIC))
		affected_mob.reagents.remove_reagent(type, 3.6 * REM * seconds_per_tick) //gets removed from organics very fast
		if(prob(25))
			affected_mob.vomit(VOMIT_CATEGORY_DEFAULT, lost_nutrition = 5)
	return ..()

/datum/reagent/consumable/ethanol/synthanol/expose_mob(mob/living/carbon/C, method=TOUCH, volume)
	. = ..()
	if(C.mob_biotypes & MOB_ROBOTIC)
		return
	if(method == INGEST)
		to_chat(C, pick(span_danger("Isso foi horrível!"), span_danger("Isso foi nojento!")))

/datum/reagent/consumable/ethanol/synthanol/robottears
	name = "Robot Tears"
	description = "Uma substância oleosa que um IPC pode tecnicamente considerar uma bebida."
	color = "#363636"
	quality = DRINK_GOOD
	boozepwr = 25
	taste_description = "Angustiação existencial"

/datum/glass_style/drinking_glass/synthanol/robottears
	required_drink_type = /datum/reagent/consumable/ethanol/synthanol/robottears
	icon_state = "robottearsglass"
	name = "glass of robot tears"
	desc = "Nenhum robô foi ferido na fabricação desta bebida."

/datum/reagent/consumable/ethanol/synthanol/trinary
	name = "Trinary"
	description = "Uma bebida de frutas destinada apenas para sintéticos, no entanto isso funciona."
	color = "#ADB21f"
	quality = DRINK_GOOD
	boozepwr = 20
	taste_description = "modem estático"

/datum/glass_style/drinking_glass/synthanol/trinary
	required_drink_type = /datum/reagent/consumable/ethanol/synthanol/trinary
	icon_state = "trinaryglass"
	name = "glass of trinary"
	desc = "Bebida colorida feita para tripulantes sintéticos. Não parece que seria um bom gosto."

/datum/reagent/consumable/ethanol/synthanol/servo
	name = "Servo"
	description = "Uma bebida contendo alguns ingredientes orgânicos, mas só para sintéticos."
	color = "#5B3210"
	quality = DRINK_GOOD
	boozepwr = 25
	taste_description = "óleo de motor e cacau"

/datum/glass_style/drinking_glass/synthanol/servo
	required_drink_type = /datum/reagent/consumable/ethanol/synthanol/servo
	icon_state = "servoglass"
	name = "glass of servo"
	desc = "Bebida baseada em chocolate feita para IPCs. Não sei se alguém já provou a receita."

/datum/reagent/consumable/ethanol/synthanol/uplink
	name = "Uplink"
	description = "Uma mistura potente de álcool e sinttanol. Só funcionará com sintéticos."
	color = "#E7AE04"
	quality = DRINK_GOOD
	boozepwr = 15
	taste_description = "Uma GUI no básico visual"

/datum/glass_style/drinking_glass/synthanol/uplink
	required_drink_type = /datum/reagent/consumable/ethanol/synthanol/uplink
	icon_state = "uplinkglass"
	name = "glass of uplink"
	desc = "Uma mistura requintada de alcaçuz e sintâniol. Era só para sintéticos."

/datum/reagent/consumable/ethanol/synthanol/synthncoke
	name = "Synth 'n Coke"
	description = "A bebida clássica se ajustou para o gosto de um robô."
	color = "#7204E7"
	quality = DRINK_GOOD
	boozepwr = 25
	taste_description = "óleo de motor efervescente"

/datum/glass_style/drinking_glass/synthanol/synthncoke
	required_drink_type = /datum/reagent/consumable/ethanol/synthanol/synthncoke
	icon_state = "synthncokeglass"
	name = "glass of synth 'n coke"
	desc = "Bebida clássica alterada para se adequar aos gostos de um robô, contém propriedades desprotegidas. Péssima ideia de beber se for feito de carbono."

/datum/reagent/consumable/ethanol/synthanol/synthignon
	name = "Synthignon"
	description = "Alguém misturou vinho e álcool para robôs. Espero que esteja orgulhoso de si mesmo."
	color = "#D004E7"
	quality = DRINK_GOOD
	boozepwr = 25
	taste_description = "Óleo de motor chique."

/datum/glass_style/drinking_glass/synthanol/synthignon
	required_drink_type = /datum/reagent/consumable/ethanol/synthanol/synthignon
	icon_state = "synthignonglass"
	name = "glass of synthignon"
	desc = "Alguém misturou bom vinho e álcool robô. Romântico, mas atroz."

// Other Booze

/datum/reagent/consumable/ethanol/gunfire
	name = "Gunfire"
	description = "Uma bebida que tem gosto de pequenas explosões."
	color = "#e4830d"
	boozepwr = 40
	quality = DRINK_GOOD
	taste_description = "Pequenas explosões."

/datum/glass_style/drinking_glass/gunfire
	required_drink_type = /datum/reagent/consumable/ethanol/gunfire
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "gunfire"
	name = "glass of gunfire"
	desc = "Ele aparece constantemente enquanto você olha para ele, dando pequenas faíscas."

/datum/reagent/consumable/ethanol/gunfire/on_mob_life(mob/living/carbon/M)
	if (prob(3))
		to_chat(M,span_notice("Sente o tiro na boca."))
	return ..()

/datum/reagent/consumable/ethanol/hellfire
	name = "Hellfire"
	description = "Uma bebida que não é tão quente quanto parece."
	color = "#fb2203"
	boozepwr = 60
	quality = DRINK_VERYGOOD
	taste_description = "chamas frias que lambem no topo da sua boca"

/datum/glass_style/drinking_glass/hellfire
	required_drink_type = /datum/reagent/consumable/ethanol/hellfire
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "hellfire"
	name = "glass of hellfire"
	desc = "Uma bebida de cor âmbar que não é tão quente quanto parece."

/datum/reagent/consumable/ethanol/hellfire/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.adjust_bodytemperature(30 * TEMPERATURE_DAMAGE_COEFFICIENT * REM * seconds_per_tick, 0, BODYTEMP_NORMAL + 30)

/datum/reagent/consumable/ethanol/sins_delight
	name = "Sin's Delight"
	description = "A bebida cheira como os sete pecados."
	color = "#330000"
	boozepwr = 66
	quality = DRINK_FANTASTIC
	taste_description = "Sobrepujante doçura com um toque de amargura, seguido de ferro e a sensação de uma brisa quente de verão"
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING //component drink is demon's blood, thus this drink is made with blood so hemophages can comfortably drink it

/datum/glass_style/drinking_glass/sins_delight
	required_drink_type = /datum/reagent/consumable/ethanol/sins_delight
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "sins_delight"
	name = "glass of sin's delight"
	desc = "Dá para sentir os sete pecados saindo do topo do vidro."

/datum/reagent/consumable/ethanol/daiquiri/strawberry
	name = "Strawberry Daiquiri"
	description = "Bebida alcoólica rosa."
	boozepwr = 20
	color = "#FF4A74"
	quality = DRINK_NICE
	taste_description = "Doce morango, limão e a brisa do oceano"

/datum/glass_style/drinking_glass/daiquiri/strawberry
	required_drink_type = /datum/reagent/consumable/ethanol/daiquiri/strawberry
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "strawberry_daiquiri"
	name = "glass of strawberry daiquiri"
	desc = "Uma bebida rosa com flores e um canudo grande para beber. Parece doce e refrescante, perfeito para dias quentes."

/datum/glass_style/drinking_glass/liz_fizz
	required_drink_type = /datum/reagent/consumable/liz_fizz
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "liz_fizz"
	name = "glass of liz fizz"
	desc = "Parece um cítrico separado em camadas? Por que alguém iria querer isso está além de você."

/datum/reagent/consumable/ethanol/miami_vice
	name = "Miami Vice"
	description = "Uma irmã em Camadas Pina Colada e Morango Daiquiri"
	boozepwr = 30
	color = "#D8FF59"
	quality = DRINK_FANTASTIC
	taste_description = "Sabor doce e refrescante, complementado com morangos e coco, e diz de citrinos"

/datum/glass_style/drinking_glass/miami_vice
	required_drink_type = /datum/reagent/consumable/ethanol/miami_vice
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "miami_vice"
	name = "glass of miami vice"
	desc = "Morangos e coco, como yin e yang."

/datum/reagent/consumable/ethanol/malibu_sunset
	name = "Malibu Sunset"
	description = "Uma bebida de creme de coco e sucos tropicais."
	boozepwr = 20
	color = "#FF9473"
	quality = DRINK_VERYGOOD
	taste_description = "Coco, com acentos de laranja e grenadine"

/datum/glass_style/drinking_glass/malibu_sunset
	required_drink_type = /datum/reagent/consumable/ethanol/malibu_sunset
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "malibu_sunset"
	name = "glass of malibu sunset"
	desc = "Bebidas tropicais, com cubos de gelo pairando na superfície e grenadina colorindo o fundo."

/datum/reagent/consumable/ethanol/hotlime_miami
	name = "Hotlime Miami"
	description = "A essência dos anos 90, se fossem uma bagunça."
	boozepwr = 40
	color = "#A7FAE8"
	quality = DRINK_FANTASTIC
	taste_description = "coco e violência estética"

/datum/glass_style/drinking_glass/hotlime_miami
	required_drink_type = /datum/reagent/consumable/ethanol/hotlime_miami
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "hotlime_miami"
	name = "glass of hotlime miami"
	desc = "Isso parece muito esteticamente agradável."

/datum/reagent/consumable/ethanol/hotlime_miami/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.set_drugginess(1.5 MINUTES * REM * seconds_per_tick)
	if(affected_mob.adjust_stamina_loss(-2 * REM * seconds_per_tick, updating_stamina = FALSE))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/coggrog
	name = "Cog Grog"
	description = "Agora você pode se encher com o poder de Ratvar!"
	color = rgb(255, 201, 49)
	boozepwr = 10
	quality = DRINK_FANTASTIC
	taste_description = "Um gosto de latão com um toque de óleo"

/datum/glass_style/drinking_glass/coggrog
	required_drink_type = /datum/reagent/consumable/ethanol/coggrog
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "coggrog"
	name = "glass of cog grog"
	desc = "Nem os Quatro Generais de Ratvar aguentariam isso! Qevax Jryy!"

/datum/reagent/consumable/ethanol/badtouch
	name = "Bad Touch"
	description = "Uma bebida azeda e vintage. Alguns dizem que o inventor leva muito tapa."
	color = rgb(31, 181, 99)
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "Um tapa na cara."

/datum/glass_style/drinking_glass/badtouch
	required_drink_type = /datum/reagent/consumable/ethanol/badtouch
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "badtouch"
	name = "glass of bad touch"
	desc = "Afinal, não somos nada além de mamíferos."

/datum/reagent/consumable/ethanol/marsblast
	name = "Marsblast"
	description = "Uma bebida picante e masculina em hondra dos primeiros colonos em Marte."
	color = rgb(246, 143, 55)
	boozepwr = 70
	quality = DRINK_FANTASTIC
	taste_description = "Areia vermelha quente"

/datum/glass_style/drinking_glass/marsblast
	required_drink_type = /datum/reagent/consumable/ethanol/marsblast
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "marsblast"
	name = "glass of marsblast"
	desc = "Um desses é suficiente para deixar seu rosto tão vermelho quanto o planeta."

/datum/reagent/consumable/ethanol/mercuryblast
	name = "Mercuryblast"
	description = "Uma bebida azeda e fria que vai arrefecer o bebedor."
	color = rgb(29, 148, 213)
	boozepwr = 40
	quality = DRINK_VERYGOOD
	taste_description = "Arrepia sua espinha"

/datum/glass_style/drinking_glass/mercuryblast
	required_drink_type = /datum/reagent/consumable/ethanol/mercuryblast
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "mercuryblast"
	name = "glass of mercuryblast"
	desc = "Nenhum termômetro foi prejudicado na criação desta bebida."

/datum/reagent/consumable/ethanol/mercuryblast/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.adjust_bodytemperature(-30 * TEMPERATURE_DAMAGE_COEFFICIENT * REM * seconds_per_tick, T0C)

/datum/reagent/consumable/ethanol/piledriver
	name = "Piledriver"
	description = "Uma bebida brilhante que te deixa com uma sensação de queimação."
	color = rgb(241, 146, 59)
	boozepwr = 45
	quality = DRINK_NICE
	taste_description = "Um nevoeiro em sua garganta"

/datum/glass_style/drinking_glass/piledriver
	required_drink_type = /datum/reagent/consumable/ethanol/piledriver
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "piledriver"
	name = "glass of piledriver"
	desc = "Não é a única coisa que deixa sua garganta dorida."

/datum/reagent/consumable/ethanol/zenstar
	name = "Zen Star"
	description = "Uma bebida azeda e sem graça, bastante decepcionante."
	color = rgb(51, 87, 203)
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "disappointment"

/datum/glass_style/drinking_glass/zenstar
	required_drink_type = /datum/reagent/consumable/ethanol/zenstar
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "zenstar"
	name = "glass of zen star"
	desc = "Você pensaria que algo tão equilibrado seria realmente gostoso... você estaria muito errado."


// RACE SPECIFIC DRINKS

/datum/reagent/consumable/ethanol/coldscales
	name = "Coldscales"
	color = "#5AEB52" //(90, 235, 82)
	description = "Uma bebida fria feita para pessoas com escamas."
	boozepwr = 50 //strong!
	taste_description = "Moscas Mortas."

/datum/glass_style/drinking_glass/coldscales
	required_drink_type = /datum/reagent/consumable/ethanol/coldscales
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "coldscales"
	name = "glass of coldscales"
	desc = "Um refrigerante verde que parece convidativo!"

/datum/reagent/consumable/ethanol/coldscales/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(islizard(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/oil_drum
	name = "Oil Drum"
	color = "#000000" //(0, 0, 0)
	description = "Óleo industrial misturado com etanol para fazer uma bebida. De alguma forma, não conhecido como tóxico."
	boozepwr = 45
	taste_description = "derramamento de óleo"

/datum/glass_style/drinking_glass/oil_drum
	required_drink_type = /datum/reagent/consumable/ethanol/oil_drum
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "oil_drum"
	name = "drum of oil"
	desc = "Uma lata cinza de bebida e óleo..."

/datum/reagent/consumable/ethanol/oil_drum/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(MOB_ROBOTIC)
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/nord_king
	name = "Nord King"
	color = "#EB1010" //(235, 16, 16)
	description = "Hidromel forte misturado com mais mel e etanol. Amado por seus clientes humanos."
	boozepwr = 50 //strong!
	taste_description = "mel e vinho tinto."
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING //component drink is red mead, thus this drink is made with blood so hemophages can comfortably drink it

/datum/glass_style/drinking_glass/nord_king
	required_drink_type = /datum/reagent/consumable/ethanol/nord_king
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "nord_king"
	name = "keg of nord king"
	desc = "Um barril de hidromel vermelho."

/datum/reagent/consumable/ethanol/nord_king/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(ishumanbasic(exposed_mob) || isdwarf(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/velvet_kiss
	name = "Velvet Kiss"
	color = "#EB1010" //(235, 16, 16)
	description = "Uma bebida sangrenta misturada com vinho."
	boozepwr = 10 //weak
	taste_description = "Ferro com suco de uva"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/glass_style/drinking_glass/velvet_kiss
	required_drink_type = /datum/reagent/consumable/ethanol/velvet_kiss
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "velvet_kiss"
	name = "glass of velvet kiss"
	desc = "Bebidas vermelhas e brancas para as classes altas ou mortos-vivos."

/datum/reagent/consumable/ethanol/velvet_kiss/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(iszombie(exposed_mob) || isvampire(exposed_mob) || isdullahan(exposed_mob) || ishemophage(exposed_mob)) //Rare races!
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/velvet_kiss/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired)
	. = ..()
	if(drinker.blood_volume < BLOOD_VOLUME_NORMAL)
		drinker.blood_volume = min(drinker.blood_volume + (1 * REM * seconds_per_tick), BLOOD_VOLUME_NORMAL) //Same as Bloody Mary, as it is roughly the same difficulty to make.  Gives hemophages a bit more choices to supplant their blood levels.

/datum/reagent/consumable/ethanol/abduction_fruit
	name = "Abduction Fruit"
	color = "#DEFACD" //(222, 250, 205)
	description = "Misturando sucos para fazer um gosto alienígena."
	boozepwr = 80 //Strong
	taste_description = "Erva e limão"

/datum/glass_style/drinking_glass/abduction_fruit
	required_drink_type = /datum/reagent/consumable/ethanol/abduction_fruit
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "abduction_fruit"
	name = "glass of abduction fruit"
	desc = "Frutos mistos que nunca foram feitos para serem misturados..."

/datum/reagent/consumable/ethanol/abduction_fruit/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isabductor(exposed_mob) || isxenohybrid(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/bug_zapper
	name = "Bug Zapper"
	color = "#F5882A" //(222, 250, 205)
	description = "Cobre e suco de limão. Nem mesmo uma bebida."
	boozepwr = 5 //No booze really
	taste_description = "Cobre e energia AC"

/datum/glass_style/drinking_glass/bug_zapper
	required_drink_type = /datum/reagent/consumable/ethanol/bug_zapper
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "bug_zapper"
	name = "glass of bug zapper"
	desc = "Uma estranha mistura de cobre, suco de limão e energia para consumo não humano."

/datum/reagent/consumable/ethanol/bug_zapper/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isinsect(exposed_mob) || isflyperson(exposed_mob) || ismoth(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/mush_crush
	name = "Mush Crush"
	color = "#F5882A" //(222, 250, 205)
	description = "Solo em um copo."
	boozepwr = 5 //No booze really
	taste_description = "Sujeira e Ferro"

/datum/glass_style/drinking_glass/mush_crush
	required_drink_type = /datum/reagent/consumable/ethanol/mush_crush
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "mush_crush"
	name = "glass of mush crush"
	desc = "Popular entre pessoas que querem cultivar sua própria comida em vez de beber o solo."

/datum/reagent/consumable/ethanol/mush_crush/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(ispodperson(exposed_mob) || issnail(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/hollow_bone
	name = "Hollow Bone"
	color = "#FCF7D4" //(252, 247, 212)
	description = "Chocantemente, mistura de toxinas e leite."
	boozepwr = 15
	taste_description = "Leite e Sal"

/datum/glass_style/drinking_glass/hollow_bone
	required_drink_type = /datum/reagent/consumable/ethanol/hollow_bone
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "hollow_bone"
	name = "skull of hollow bone"
	desc = "Misturar leite e suco de osso para diversão para pessoas magras."

/datum/reagent/consumable/ethanol/hollow_bone/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isplasmaman(exposed_mob) || isskeleton(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/jell_wyrm
	name = "Jell Wyrm"
	color = "#FF6200" //(255, 98, 0)
	description = "Horrível mistura de CO2, toxinas e calor. Significado para a vida baseada no lodo."
	boozepwr = 40
	taste_description = "Mar tropical"

/datum/glass_style/drinking_glass/jell_wyrm
	required_drink_type = /datum/reagent/consumable/ethanol/jell_wyrm
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "jell_wyrm"
	name = "glass of jell wyrm"
	desc = "Uma bebida borbulhante que é bastante convidativa para aqueles que não sabem para quem é destinada."

/datum/reagent/consumable/ethanol/jell_wyrm/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	if(prob(20))
		if(affected_mob.adjust_tox_loss(0.5 * REM * seconds_per_tick, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

#define JELLWYRM_DISGUST 25

/datum/reagent/consumable/ethanol/jell_wyrm/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isjellyperson(exposed_mob) || isslimeperson(exposed_mob) || isluminescent(exposed_mob))
		quality = RACE_DRINK
	else //if youre not a slime, jell wyrm should be GROSS
		exposed_mob.adjust_disgust(JELLWYRM_DISGUST)
	return ..()

#undef JELLWYRM_DISGUST

/datum/reagent/consumable/ethanol/laval_spit //Yes Laval
	name = "Laval Spit"
	color = "#DE3009" //(222, 48, 9)
	description = "Minerais de calor e um pouco de Mauna Loa. Significado para a vida baseada no rock."
	boozepwr = 30
	taste_description = "Ilha tropical."

/datum/glass_style/drinking_glass/laval_spit
	required_drink_type = /datum/reagent/consumable/ethanol/laval_spit
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "laval_spit"
	name = "glass of laval spit"
	desc = "Bebida quente para quem pode suportar o calor da lava."

/datum/reagent/consumable/ethanol/laval_spit/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isgolem(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/frisky_kitty
	name = "Frisky Kitty"
	color = "#FCF7D4" //(252, 247, 212)
	description = "Leite quente misturado com papai de gato."
	boozepwr = 0
	taste_description = "Leite quente e papai de gato"

/datum/glass_style/drinking_glass/frisky_kitty
	required_drink_type = /datum/reagent/consumable/ethanol/frisky_kitty
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "frisky_kitty"
	name = "cup of frisky kitty"
	desc = "Leite quente e um poco de bebida."

/datum/reagent/consumable/ethanol/frisky_kitty/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isfeline(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()


/datum/reagent/consumable/ethanol/bloodshot_base
	name = "Bloodshot Base"
	description = "A mistura pirata de nutrientes e álcool que vai fazer Bloodshots. Não é muito gostoso sozinho, para os hemofármacos, pelo menos."
	color = "#c29ca1"
	boozepwr = 25 // Still more concentrated than in Bloodshot.
	taste_description = "Mistura nutritiva com um chute alcoólico."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED


/datum/reagent/consumable/ethanol/bloodshot
	name = "Bloodshot"
	description = "A história do 'Bloodshot' é baseada em uma mistura de produtos químicos neutros para ajudar a entregar nutrientes para os órgãos tumorais de um hemofago. Devido à despesa da coisa real e a natureza clínica dela, este licor foi projetado como uma alternativa 'melhorada', embora, ainda provando como uma cura de ressaca. Cheira a ferro, dando uma pista para o ingrediente chave."
	color = "#a30000"
	boozepwr = 20 // The only booze in it is Bloody Mary
	taste_description = "Sangue de todos os tipos."
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING


/datum/glass_style/drinking_glass/bloodshot
	required_drink_type = /datum/reagent/consumable/ethanol/bloodshot
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "bloodshot"
	name = "glass of bloodshot"
	desc = "A história do 'Bloodshot' é baseada em uma mistura de produtos químicos neutros para ajudar a entregar nutrientes para os órgãos tumorais de um hemofago. Devido à despesa da coisa real e a natureza clínica dela, este licor foi projetado como uma alternativa 'melhorada', embora, ainda provando como uma cura de ressaca. Cheira a ferro, dando uma pista para o ingrediente chave."


#define BLOODSHOT_DISGUST 25

/datum/reagent/consumable/ethanol/bloodshot/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(ishemophage(exposed_mob))
		quality = RACE_DRINK

	else if(exposed_mob.blood_volume < exposed_mob.blood_volume_normal)
		quality = DRINK_GOOD

	if(!quality) // Basically, you don't have a reason to want to have this in your system, it doesn't taste good to you!
		exposed_mob.adjust_disgust(BLOODSHOT_DISGUST)

	return ..()

#undef BLOODSHOT_DISGUST

/datum/reagent/consumable/ethanol/bloodshot/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired)
	. = ..()
	if(drinker.blood_volume < drinker.blood_volume_normal)
		drinker.blood_volume = max(drinker.blood_volume, min(drinker.blood_volume + (3 * REM * seconds_per_tick), BLOOD_VOLUME_NORMAL)) //Bloodshot quickly restores blood loss.

/datum/reagent/consumable/ethanol/blizzard_brew
	name = "Blizzard Brew"
	description = "Uma receita antiga. Serviu melhor resfriado tanto quanto anões possível."
	color = rgb(180, 231, 216)
	boozepwr = 25
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	taste_description = "Picles antigos"
	overdose_threshold = 25
	var/obj/structure/ice_stasis/cube
	var/atom/movable/screen/alert/status_effect/freon/cryostylane_alert

/datum/glass_style/drinking_glass/blizzard_brew
	required_drink_type = /datum/reagent/consumable/ethanol/blizzard_brew
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "blizzard_brew"
	name = "glass of Blizzard Brew"
	desc = "Uma receita antiga. Serviu melhor resfriado tanto quanto anões possível."

/datum/reagent/consumable/ethanol/blizzard_brew/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isdwarf(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_NICE
	return ..()

/datum/reagent/consumable/ethanol/blizzard_brew/overdose_start(mob/living/carbon/drinker)
	. = ..()
	cube = new /obj/structure/ice_stasis(get_turf(drinker))
	cube.color = COLOR_CYAN
	cube.set_anchored(TRUE)
	drinker.forceMove(cube)
	cryostylane_alert = drinker.throw_alert("cryostylane_alert", /atom/movable/screen/alert/status_effect/freon/stasis)
	cryostylane_alert.attached_effect = src //so the alert can reference us, if it needs to

/datum/reagent/consumable/ethanol/blizzard_brew/on_mob_delete(mob/living/carbon/drinker, amount)
	QDEL_NULL(cube)
	drinker.clear_alert("cryostylane_alert")
	return ..()

/datum/reagent/consumable/ethanol/molten_mead
	name = "Molten Mead"
	description = "Famosamente consciente por incendiar como barbas. Ingera por sua conta e risco!"
	color = rgb(224, 78, 16)
	boozepwr = 35
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	taste_description = "Vespas queimando"
	overdose_threshold = 25

/datum/glass_style/drinking_glass/molten_mead
	required_drink_type = /datum/reagent/consumable/ethanol/molten_mead
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "molten_mead"
	name = "glass of Molten Mead"
	desc = "Famosamente consciente por incendiar como barbas. Ingera por sua conta e risco!"

/datum/reagent/consumable/ethanol/molten_mead/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isdwarf(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_VERYGOOD
	return ..()

/datum/reagent/consumable/ethanol/molten_mead/overdose_start(mob/living/carbon/drinker)
	drinker.adjust_fire_stacks(2)
	drinker.ignite_mob()
	..()

/datum/reagent/consumable/ethanol/hippie_hooch
	name = "Hippie Hooch"
	description = "Paz e amor! Sob pedido do departamento de RH, esta bebida certamente vai deixá-lo sóbrio rapidamente."
	color = rgb(77, 138, 34)
	boozepwr = -20
	taste_description = "cânhamo ovo"
	var/static/list/status_effects_to_clear = list(
		/datum/status_effect/confusion,
		/datum/status_effect/dizziness,
		/datum/status_effect/drowsiness,
		/datum/status_effect/speech/slurring/drunk,
	)

/datum/glass_style/drinking_glass/hippie_hooch
	required_drink_type = /datum/reagent/consumable/ethanol/hippie_hooch
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "hippie_hooch"
	name = "glass of Hippie Hooch"
	desc = "Paz e amor! Sob pedido do departamento de RH, esta bebida certamente vai deixá-lo sóbrio rapidamente."

/datum/reagent/consumable/ethanol/hippie_hooch/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isdwarf(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_FANTASTIC
	return ..()

/datum/reagent/consumable/ethanol/hippie_hooch/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	for(var/effect in status_effects_to_clear)
		affected_mob.remove_status_effect(effect)
	affected_mob.reagents.remove_reagent(/datum/reagent/consumable/ethanol, 3 * REM * seconds_per_tick, include_subtypes = TRUE)
	. = ..()
	if(affected_mob.adjust_tox_loss(-0.2 * REM * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		. = UPDATE_MOB_HEALTH
	affected_mob.adjust_drunk_effect(-10 * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/research_rum
	name = "Research Rum"
	description = "Cozido por cientistas anões, esta bebida rosa brilhante certamente vai sobrecarregar seu pensamento. Como? Ciência!"
	color = rgb(169, 69, 169)
	boozepwr = 50
	taste_description = "Matéria cinzenta escorregadia"

/datum/glass_style/drinking_glass/research_rum
	required_drink_type = /datum/reagent/consumable/ethanol/research_rum
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "research_rum"
	name = "glass of Research Rum"
	desc = "Cozido por cientistas anões, esta bebida rosa brilhante certamente vai sobrecarregar seu pensamento. Como? Ciência!"

/datum/reagent/consumable/ethanol/research_rum/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isdwarf(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/research_rum/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired)
	. = ..()
	if(prob(5))
		drinker.say(pick_list_replacements(VISTA_FILE, "ballmer_good_msg"), forced = "ballmer")

/datum/reagent/consumable/ethanol/golden_grog
	name = "Golden Grog"
	description = "Uma bebida feita por um contramestre anões que tinha muito tempo e dinheiro nas mãos. Ordenados por influenciadores que querem exibir sua riqueza."
	color = rgb(247, 230, 141)
	boozepwr = 70
	taste_description = "doce crédito holochips"

/datum/glass_style/drinking_glass/golden_grog
	required_drink_type = /datum/reagent/consumable/ethanol/golden_grog
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "golden_grog"
	name = "glass of Golden Grog"
	desc = "Uma bebida feita por um contramestre anões que tinha muito tempo e dinheiro nas mãos. Ordenados por influenciadores que querem exibir sua riqueza."

/datum/reagent/consumable/ethanol/golden_grog/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isdwarf(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_FANTASTIC
	return ..()

// RACIAL DRINKS END

/datum/reagent/consumable/ethanol/appletini
	name = "Appletini"
	color = "#9bd1a9" //(155, 209, 169)
	description = "A bebida de maçã verde-elétrica ninguém pode recusar!"
	boozepwr = 50
	taste_description = "Doce e verde"
	quality = DRINK_GOOD

/datum/glass_style/drinking_glass/appletini
	required_drink_type = /datum/reagent/consumable/ethanol/appletini
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "appletini"
	name = "glass of appletini"
	desc = "Uma bebida de maçã em um copo de martini"

/datum/reagent/consumable/ethanol/quadruple_sec/cityofsin //making this a subtype was some REAL JANK, but it saves me a headache, and it looks good!
	name = "City of Sin"
	color = "#eb9378" //(235, 147, 120)
	description = "Uma bebida suave e chique para pessoas de má reputação"
	boozepwr = 70
	taste_description = "Seus próprios pecados"
	quality = DRINK_VERYGOOD //takes extra effort
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/cityofsin
	required_drink_type = /datum/reagent/consumable/ethanol/quadruple_sec/cityofsin
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "cityofsin"
	name = "glass of city of sin"
	desc = "Olhar para ele faz você lembrar de cada erro que cometeu."

/datum/reagent/consumable/ethanol/shakiri
	name = "Shakiri"
	description = "Uma bebida vermelha doce e perfumada feita de frutos de kiri fermentados. Parece brilhar suavemente quando exposto à luz."
	boozepwr = 45
	color = "#cf3c3c"
	quality = DRINK_GOOD
	taste_description = "Deliciosa geléia liqueificada"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/shakiri
	required_drink_type = /datum/reagent/consumable/ethanol/shakiri
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "shakiri"
	name = "glass of shakiri"
	desc = "Uma bebida vermelha doce e perfumada feita de frutos de kiri fermentados. Parece brilhar suavemente quando exposto à luz."

/datum/reagent/consumable/ethanol/shakiri_spritz
	name = "Shakiri Spritz"
	description = "Um coquetel carbonatado feito de shakiri e suco de laranja com água com soda."
	color = "#cf863c"
	quality = DRINK_GOOD
	boozepwr = 45
	taste_description = "Tangy, doce carbonatado"

/datum/glass_style/drinking_glass/shakiri_spritz
	required_drink_type = /datum/reagent/consumable/ethanol/shakiri_spritz
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "shakiri_spritz"
	name = "glass of shakiri spritz"
	desc = "Um coquetel carbonatado feito de shakiri e suco de laranja com água com soda."

/datum/reagent/consumable/ethanol/crimson_hurricane
	name = "Crimson Hurricane"
	description = "Um forte coquetel cítrico de origem humana, agora feito com shakiri e geléia kiri para uma bebida deliciosamente doce."
	color = "#b86637"
	quality = DRINK_VERYGOOD
	boozepwr = 60
	taste_description = "Doce grosso e frutado com um soco"

/datum/glass_style/drinking_glass/crimson_hurricane
	required_drink_type = /datum/reagent/consumable/ethanol/crimson_hurricane
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "crimson_hurricane"
	name = "glass of crimson hurricane"
	desc = "Um forte coquetel cítrico de origem humana, agora com shakiri e geléia kiri para uma bebida deliciosamente doce."

/datum/reagent/consumable/ethanol/shakiri_rogers
	name = "Shakiri Rogers"
	description = "Uma opinião sobre o clássico Roy Rogers, com shakiri em vez de grenadine. Doce e refrescante."
	color = "#6F2B1A"
	quality = DRINK_GOOD
	boozepwr = 45
	taste_description = "Frutado, refrigerante carbonatado com um pára-quedas"

/datum/glass_style/drinking_glass/shakiri_rogers
	required_drink_type = /datum/reagent/consumable/ethanol/shakiri_rogers
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "shakiri_rogers"
	name = "glass of shakiri rogers"
	desc = "Uma opinião sobre o clássico Roy Rogers, com shakiri em vez de grenadine. Doce e refrescante."
