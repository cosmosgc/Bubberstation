//Gun crafting parts til they can be moved elsewhere
// PARTS //
/obj/item/weaponcrafting
	abstract_type = /obj/item/weaponcrafting
/obj/item/weaponcrafting/Initialize(mapload)
	. = ..()
	create_slapcraft_component()
/obj/item/weaponcrafting/proc/create_slapcraft_component()
	return
/obj/item/weaponcrafting/receiver
	name = "modular receiver"
	desc = "Um protótipo de receptor modular e montagem de gatilho para uma arma de fogo."
	icon = 'icons/obj/weapons/improvised.dmi'
	icon_state = "receiver"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5.5, /datum/material/cardboard = SHEET_MATERIAL_AMOUNT)
/obj/item/weaponcrafting/receiver/create_slapcraft_component()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/pipegun)
	AddElement(
		/datum/element/slapcrafting,slapcraft_recipes = slapcraft_recipe_list,\

	)
/obj/item/weaponcrafting/stock
	name = "rifle stock"
	desc = "Um estoque clássico de fuzil que serve também como empunhadura, esculpido grosseiramente em madeira."
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 8)
	resistance_flags = FLAMMABLE
	icon = 'icons/obj/weapons/improvised.dmi'
	icon_state = "riflestock"
/obj/item/weaponcrafting/stock/create_slapcraft_component()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/smoothbore_disabler, /datum/crafting_recipe/laser_musket)
	AddElement(
		/datum/element/slapcrafting,slapcraft_recipes = slapcraft_recipe_list,\

	)
/obj/item/weaponcrafting/giant_wrench
	name = "Big Slappy parts kit"
	desc = "Peças ilegais para fabricar uma chave inglesa gigante comumente conhecida como Big Slappy."
	icon = 'icons/obj/weapons/improvised.dmi'
	icon_state = "weaponkit_gw"
/obj/item/weaponcrafting/giant_wrench/create_slapcraft_component() // slappycraft
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/giant_wrench)
	AddElement(
		/datum/element/slapcrafting,slapcraft_recipes = slapcraft_recipe_list,\

	)
///These gun kits are printed from the security protolathe to then be used in making new weapons
// GUN PART KIT //
/obj/item/weaponcrafting/gunkit // These don't get a slapcraft component, it's added to the gun - more intuitive player-facing to slap the kit onto the gun.
	name = "generic gun parts kit"
	desc = "É um recipiente vazio de peças de arma! Por que você tem isso?"
	icon = 'icons/obj/weapons/improvised.dmi'
	icon_state = "kitsuitcase"
/obj/item/weaponcrafting/gunkit/nuclear
	name = "advanced energy gun parts kit (lethal/nonlethal)"
	desc = "Uma mala contendo as peças necessárias para transformar uma arma energética padrão em uma arma energética avançada."
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)
/obj/item/weaponcrafting/gunkit/tesla
	name = "tesla cannon parts kit (lethal)"
	desc = "Uma mala contendo as peças necessárias para construir um canhão Tesla ao redor de uma anomalia de fluxo estabilizada. Manuseie com cuidado."
	icon_state = "weaponskit_tesla"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 5)
/obj/item/weaponcrafting/gunkit/xray
	name = "x-ray laser gun parts kit (lethal)"
	desc = "Uma mala contendo as peças necessárias para transformar uma arma laser em uma arma laser de raios-X. Não aponte a maioria das partes diretamente para o rosto."
	custom_materials = list(
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
	)
/obj/item/weaponcrafting/gunkit/ion
	name = "ion carbine parts kit (nonlethal/highly destructive/very lethal (silicons))"
	desc = "Uma mala contendo as peças necessárias para transformar uma arma laser padrão em um carabina de íons. Perfeito contra armários aos quais você não tem acesso."
	custom_materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 4, /datum/material/uranium = SHEET_MATERIAL_AMOUNT)
/obj/item/weaponcrafting/gunkit/temperature
	name = "temperature gun parts kit (less lethal/very lethal (lizardpeople))"
	desc = "Uma mala contendo as peças necessárias para transformar uma arma energética padrão em uma arma de temperatura. Fantástico em festas de aniversário e matando populações indígenas de humanos-lagartos."
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 1.5)
/obj/item/weaponcrafting/gunkit/beam_rifle
	name = "\improper Event Horizon anti-existential beam rifle part kit (DOOMSDAY DEVICE, DO NOT CONSTRUCT)"
	desc = "Quais mentes febrosas criaram este terrível conjunto de construção? Para criar uma estrutura para aproveitar as energias estranhas que fluem através do Setor Spinward em direção a tais atos horríveis de violência?"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2.25,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2.5,
	)
/obj/item/weaponcrafting/gunkit/ebow
	name = "energy crossbow part kit (less lethal)"
	desc = "Um conjunto de reforma de armas altamente ilegal que permite transformar o acelerador protocinético padrão em um arco energético quase idêntico. Quase como a coisa real!"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
/obj/item/weaponcrafting/gunkit/hellgun
	name = "hellfire laser gun degradation kit (warcrime lethal)"
	desc = "Pegue uma arma laser perfeitamente funcional. Destrua o interior da arma para que ela fique quente e feroz. Agora você tem um laser infernal. Você monstro."
/obj/item/weaponcrafting/gunkit/photon
	name = "photon cannon parts kit (nonlethal)"
	desc = "Uma mala contendo as peças necessárias para construir um canhão de fótons ao redor de uma anomalia de fluxo estabilizada. Aproveite o poder do sol nas palmas de suas mãos.,"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 7, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 5)
/obj/item/weaponcrafting/gunkit/sks
	name = "\improper Sakhno SKS semi-automatic rifle parts kit (lethal)"
	desc = "Uma mala contendo as peças necessárias para construir um rifle semiautomático Sakhno SKS. Essas coisas estão em todos os mundos frontais."
