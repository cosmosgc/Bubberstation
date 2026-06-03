// Milking machine
/obj/item/storage/box/milking_kit
	name = "DIY milking machine kit"
	desc = "Contém tudo o que você precisa para construir sua própria máquina de ordenha!"
/obj/item/storage/box/milking_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/construction_kit/milker = 1)
	generate_items_inside(items_inside, src)
// X-Stand
/obj/item/storage/box/xstand_kit
	name = "DIY x-stand kit"
	desc = "Contém tudo o que você precisa para construir sua própria base X!"
/obj/item/storage/box/xstand_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/construction_kit/bdsm/x_stand = 1)
	generate_items_inside(items_inside, src)
// BDSM bed
/obj/item/storage/box/bdsmbed_kit
	name = "DIY BDSM bed kit"
	desc = "Contém tudo o que você precisa para construir sua própria cama BDSM!"
/obj/item/storage/box/bdsmbed_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/construction_kit/bdsm/bed = 1)
	generate_items_inside(items_inside, src)
// Striptease pole
/obj/item/storage/box/strippole_kit
	name = "DIY stripper pole kit"
	desc = "Contém tudo o que você precisa para construir sua própria haste de stripper!"
/obj/item/storage/box/strippole_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/construction_kit/pole = 1)
	generate_items_inside(items_inside, src)
// Shibari stand
/obj/item/storage/box/shibari_stand
	name = "DIY shibari stand kit"
	desc = "Contém tudo o que você precisa para construir sua própria base de Shibari!"
/obj/item/storage/box/shibari_stand/PopulateContents()
	var/static/items_inside = list(
		/obj/item/construction_kit/bdsm/shibari = 1,
		/obj/item/paper/shibari_kit_instructions = 1)
	generate_items_inside(items_inside, src)
// Paper instructions for shibari kit
/obj/item/paper/shibari_kit_instructions
	default_raw_text = "Olá! Parabéns pela compra do kit de Shibari da LustWish! Alguns iniciantes podem ficar confusos com nossas cordas, então preparamos pequenas instruções para você! Primeiro de tudo, você precisa ter uma chave inglesa para construir a base em si. Em segundo lugar, você pode usar chaves de fenda para mudar a cor da sua base de Shibari. Basta substituir os conectores plásticos! Terceiro, se quiser atar alguém a uma base de amarração, você precisa prender completamente o corpo deles, tanto nas entrepernas quanto no peito!. Para isso, você precisa usar corda no corpo e depois nas entrepernas do personagem, então você pode apenas prendê-los à base como em qualquer cadeira. Não esqueça de ter algumas cordas em suas mãos para realmente atá-los à base, pois não há cordas incluídas com ela! E é isso!"
