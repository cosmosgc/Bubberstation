/obj/item/food/grown/mushroom
	name = "mushroom"
	abstract_type = /obj/item/food/grown/mushroom
	// This is a prototype that should never be spawned
	// but we'll default it to SOME seed if it does end up spawning just so we don't runtime horribly
	seed = /obj/item/seeds/chanter
	bite_consumption_mod = 3
	foodtypes = VEGETABLES
	wine_power = 40
	/// Default mushroom icon for recipes that need any mushroom
	icon_state = "plumphelmet"

// Reishi
/obj/item/seeds/reishi
	name = "reishi mycelium pack"
	desc = "Este micélio cresce em algo medicinal e relaxante."
	icon_state = "mycelium-reishi"
	species = "reishi"
	plantname = "Reishi"
	product = /obj/item/food/grown/mushroom/reishi
	lifespan = 35
	endurance = 35
	maturation = 10
	production = 5
	yield = 4
	potency = 15
	instability = 30
	growthstages = 4
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/medicine/morphine = 0.35, /datum/reagent/medicine/c2/multiver = 0.35, /datum/reagent/consumable/nutriment = 0)
	graft_gene = /datum/plant_gene/trait/plant_type/fungal_metabolism

/obj/item/food/grown/mushroom/reishi
	seed = /obj/item/seeds/reishi
	name = "reishi"
	desc = "<I>Ganoderma lucidum</I>Um fungo especial conhecido por suas propriedades medicinais e de alívio de estresse."
	icon_state = "reishi"

// Fly Amanita
/obj/item/seeds/amanita
	name = "fly amanita mycelium pack"
	desc = "Este micélio se transforma em algo horrível."
	icon_state = "mycelium-amanita"
	species = "amanita"
	plantname = "Fly Amanitas"
	product = /obj/item/food/grown/mushroom/amanita
	lifespan = 50
	endurance = 35
	maturation = 10
	production = 5
	yield = 4
	instability = 30
	growthstages = 3
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	mutatelist = list(/obj/item/seeds/angel)
	reagents_add = list(/datum/reagent/drug/mushroomhallucinogen = 0.04, /datum/reagent/toxin/amatoxin = 0.35, /datum/reagent/consumable/nutriment = 0, /datum/reagent/growthserum = 0.1)
	graft_gene = /datum/plant_gene/trait/plant_type/fungal_metabolism

/obj/item/food/grown/mushroom/amanita
	seed = /obj/item/seeds/amanita
	name = "fly amanita"
	desc = "<I>Amanita Muscaria</I>Aprenda cogumelos venenosos de cor. Só colhe cogumelos que conhece."
	icon_state = "amanita"

// Destroying Angel
/obj/item/seeds/angel
	name = "destroying angel mycelium pack"
	desc = "Este micélio se transforma em algo devastador."
	icon_state = "mycelium-angel"
	species = "angel"
	plantname = "Destroying Angels"
	product = /obj/item/food/grown/mushroom/angel
	lifespan = 50
	endurance = 35
	maturation = 12
	production = 5
	yield = 2
	potency = 35
	growthstages = 3
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/drug/mushroomhallucinogen = 0.04, /datum/reagent/toxin/amatoxin = 0.1, /datum/reagent/consumable/nutriment = 0, /datum/reagent/toxin/amanitin = 0.2)
	rarity = 30
	graft_gene = /datum/plant_gene/trait/plant_type/fungal_metabolism

/obj/item/food/grown/mushroom/angel
	seed = /obj/item/seeds/angel
	name = "destroying angel"
	desc = "<I>Amanita Virosa</I>Fungo basidiomiceto mortalmente venenoso cheio de alfa-amatoxinas."
	icon_state = "angel"
	wine_power = 60

// Liberty Cap
/obj/item/seeds/liberty
	name = "liberty-cap mycelium pack"
	desc = "Este micélio se transforma em cogumelos."
	icon_state = "mycelium-liberty"
	species = "liberty"
	plantname = "Liberty-Caps"
	product = /obj/item/food/grown/mushroom/libertycap
	maturation = 7
	production = 1
	yield = 5
	potency = 15
	instability = 10
	growthstages = 3
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/drug/mushroomhallucinogen = 0.25, /datum/reagent/consumable/nutriment = 0.02)
	graft_gene = /datum/plant_gene/trait/plant_type/fungal_metabolism

/obj/item/food/grown/mushroom/libertycap
	seed = /obj/item/seeds/liberty
	name = "liberty-cap"
	desc = "<I>Psilocybe Semilanceata</I>Liberte-se!"
	icon_state = "libertycap"
	wine_power = 80

// Plump Helmet
/obj/item/seeds/plump
	name = "plump-helmet mycelium pack"
	desc = "Este micélio cresce em capacetes... talvez."
	icon_state = "mycelium-plump"
	species = "plump"
	plantname = "Plump-Helmet Mushrooms"
	product = /obj/item/food/grown/mushroom/plumphelmet
	maturation = 8
	production = 1
	yield = 4
	potency = 15
	growthstages = 3
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	mutatelist = list(/obj/item/seeds/plump/walkingmushroom)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)
	graft_gene = /datum/plant_gene/trait/plant_type/fungal_metabolism

/obj/item/food/grown/mushroom/plumphelmet
	seed = /obj/item/seeds/plump
	name = "plump-helmet"
	desc = "<I>Plumus Hellmus</I>Plump, macio e tão convidativo"
	icon_state = "plumphelmet"
	distill_reagent = /datum/reagent/consumable/ethanol/manly_dorf

// Walking Mushroom
/obj/item/seeds/plump/walkingmushroom
	name = "walking mushroom mycelium pack"
	desc = "Este micélio vai se tornar uma coisa enorme!"
	icon_state = "mycelium-walkingmushroom"
	species = "walkingmushroom"
	plantname = "Walking Mushrooms"
	product = /obj/item/food/grown/mushroom/walkingmushroom
	lifespan = 30
	endurance = 30
	maturation = 5
	yield = 1
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/mob_transformation/shroom)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.05, /datum/reagent/consumable/nutriment = 0.15)
	rarity = 30
	graft_gene = /datum/plant_gene/trait/eyes

/obj/item/food/grown/mushroom/walkingmushroom
	seed = /obj/item/seeds/plump/walkingmushroom
	name = "walking mushroom"
	desc = "<I>Plumus Locomotus</I>O começo da grande caminhada."
	icon_state = "walkingmushroom"
	can_distill = FALSE

// Chanterelle
/obj/item/seeds/chanter
	name = "chanterelle mycelium pack"
	desc = "Este micélio cresce em cogumelos chanterelle."
	icon_state = "mycelium-chanter"
	species = "chanter"
	plantname = "Chanterelle Mushrooms"
	product = /obj/item/food/grown/mushroom/chanterelle
	lifespan = 35
	endurance = 20
	maturation = 7
	production = 1
	yield = 5
	potency = 15
	instability = 20
	growthstages = 3
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	mutatelist = list(/obj/item/seeds/chanter/jupitercup)
	graft_gene = /datum/plant_gene/trait/plant_type/fungal_metabolism

/obj/item/food/grown/mushroom/chanterelle
	seed = /obj/item/seeds/chanter
	name = "chanterelle cluster"
	desc = "<I>Cantharellus Cibarius</I>Esses cogumelos amarelos parecem deliciosos!"
	icon_state = "chanterelle"

/obj/item/food/grown/mushroom/chanterelle/attackby(obj/item/I, mob/user, list/modifiers, list/attack_modifiers)
	if(!istype(I, /obj/item/kitchen/spoon))
		return ..()
	if(seed.potency < 95)
		return ..()

	to_chat(user, span_notice("Você esconde a cantora com[I]."))
	remove_item_from_storage(user)
	if(seed.resistance_flags & FIRE_PROOF)
		user.put_in_hands(new /obj/item/clothing/head/wizard/chanterelle/fr())
	else
		user.put_in_hands(new /obj/item/clothing/head/wizard/chanterelle())
	qdel(src)

//Jupiter Cup
/obj/item/seeds/chanter/jupitercup
	name = "jupiter cup mycelium pack"
	desc = "Este micélio cresce em copos jupiter. Zeus teria inveja do poder ao seu alcance."
	icon_state = "mycelium-jupitercup"
	species = "jupitercup"
	plantname = "Jupiter Cups"
	product = /obj/item/food/grown/mushroom/jupitercup
	lifespan = 40
	production = 4
	endurance = 8
	yield = 4
	growthstages = 2
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/reagent/preset/liquidelectricity, /datum/plant_gene/trait/carnivory/jupitercup)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	mutatelist = null
	graft_gene = /datum/plant_gene/trait/carnivory

/obj/item/food/grown/mushroom/jupitercup
	seed = /obj/item/seeds/chanter/jupitercup
	name = "jupiter cup"
	desc = "Um estranho cogumelo vermelho, sua superfície é úmida e escorregadia. Você se pergunta quantos pequenos vermes tiveram seu destino lá dentro."
	icon_state = "jupitercup"

// Glowshroom
/obj/item/seeds/glowshroom
	name = "glowshroom mycelium pack"
	desc = "Esse micélio brilha em cogumelos!"
	icon_state = "mycelium-glowshroom"
	species = "glowshroom"
	plantname = "Glowshrooms"
	product = /obj/item/food/grown/mushroom/glowshroom
	lifespan = 100 //ten times that is the delay
	endurance = 30
	maturation = 15
	production = 1
	yield = 3 //-> spread
	potency = 30 //-> brightness
	instability = 20
	growthstages = 4
	rarity = PLANT_MODERATELY_RARE
	genes = list(/datum/plant_gene/trait/glow, /datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	mutatelist = list(/obj/item/seeds/glowshroom/glowcap, /obj/item/seeds/glowshroom/shadowshroom)
	reagents_add = list(/datum/reagent/uranium/radium = 0.1, /datum/reagent/phosphorus = 0.1, /datum/reagent/consumable/nutriment = 0.04)
	graft_gene = /datum/plant_gene/trait/glow

/obj/item/food/grown/mushroom/glowshroom
	seed = /obj/item/seeds/glowshroom
	name = "glowshroom cluster"
	desc = "<I>Mycena Bregprox</I>Esta espécie de cogumelo brilha no escuro."
	icon_state = "glowshroom"
	var/effect_path = /obj/structure/glowshroom
	wine_power = 50

/obj/item/food/grown/mushroom/glowshroom/attack_self(mob/user)
	if(isspaceturf(user.loc))
		return FALSE
	if(!isturf(user.loc))
		to_chat(user, span_warning("Você precisa de mais espaço para plantar[src]."))
		return FALSE
	var/count = 0
	var/maxcount = 1
	for(var/tempdir in GLOB.cardinals)
		var/turf/closed/wall = get_step(user.loc, tempdir)
		if(istype(wall))
			maxcount++
	for(var/obj/structure/glowshroom/G in user.loc)
		count++
	if(count >= maxcount)
		to_chat(user, span_warning("Há muitos cogumelos aqui para plantar.[src]."))
		return FALSE
	new effect_path(user.loc, seed)
	to_chat(user, span_notice("Você planta.[src]."))
	seed = null // We pass our seed to our planted shroom, null it here
	qdel(src)
	return TRUE


// Glowcap
/obj/item/seeds/glowshroom/glowcap
	name = "glowcap mycelium pack"
	desc = "Este micélio - pode - em cogumelos!"
	icon_state = "mycelium-glowcap"
	species = "glowcap"
	icon_harvest = "glowcap-harvest"
	plantname = "Glowcaps"
	product = /obj/item/food/grown/mushroom/glowshroom/glowcap
	genes = list(/datum/plant_gene/trait/glow/red, /datum/plant_gene/trait/cell_charge, /datum/plant_gene/trait/plant_type/fungal_metabolism)
	mutatelist = null
	reagents_add = list(/datum/reagent/teslium = 0.1, /datum/reagent/consumable/nutriment = 0.04)
	rarity = 30
	graft_gene = /datum/plant_gene/trait/cell_charge

/obj/item/food/grown/mushroom/glowshroom/glowcap
	seed = /obj/item/seeds/glowshroom/glowcap
	name = "glowcap cluster"
	desc = "<I>Mycena Ruthenia</I>Esta espécie de cogumelo brilha no escuro, mas não é realmente bioluminescente. Estão quentes ao toque..."
	icon_state = "glowcap"
	effect_path = /obj/structure/glowshroom/glowcap
	tastes = list("glowcap" = 1)


//Shadowshroom
/obj/item/seeds/glowshroom/shadowshroom
	name = "shadowshroom mycelium pack"
	desc = "Este micélio se tornará algo sombrio."
	icon_state = "mycelium-shadowshroom"
	species = "shadowshroom"
	icon_grow = "shadowshroom-grow"
	icon_dead = "shadowshroom-dead"
	plantname = "Shadowshrooms"
	product = /obj/item/food/grown/mushroom/glowshroom/shadowshroom
	genes = list(/datum/plant_gene/trait/glow/shadow, /datum/plant_gene/trait/plant_type/fungal_metabolism)
	mutatelist = null
	reagents_add = list(/datum/reagent/uranium/radium = 0.2, /datum/reagent/consumable/nutriment = 0.04)
	rarity = 30
	graft_gene = /datum/plant_gene/trait/glow/shadow

/obj/item/food/grown/mushroom/glowshroom/shadowshroom
	seed = /obj/item/seeds/glowshroom/shadowshroom
	name = "shadowshroom cluster"
	desc = "<I>Mycena Umbra</I>Esta espécie de cogumelo emite sombra em vez de luz."
	icon_state = "shadowshroom"
	effect_path = /obj/structure/glowshroom/shadowshroom
	tastes = list("shadow" = 1, "mushroom" = 1)
	wine_power = 60

/obj/item/food/grown/mushroom/glowshroom/shadowshroom/attack_self(mob/user)
	. = ..()
	if(.)
		investigate_log("was planted by [key_name(user)] at [AREACOORD(user)]", INVESTIGATE_BOTANY)

/obj/item/seeds/odious_puffball
	name = "odious pullball spore pack"
	desc = "Esses esporos fedem! Nojento."
	icon_state = "seed-odiouspuffball"
	species = "odiouspuffball"
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	icon_grow = "odiouspuffball-grow"
	icon_dead = "odiouspuffball-dead"
	icon_harvest = "odiouspuffball-harvest"
	plantname = "Odious Puffballs"
	maturation = 3
	production = 8
	potency = 30
	instability = 65
	growthstages = 3
	product = /obj/item/food/grown/mushroom/odious_puffball
	genes = list(/datum/plant_gene/trait/smoke, /datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/squash)
	reagents_add = list(/datum/reagent/toxin/spore = 0.2, /datum/reagent/consumable/nutriment = 0.04)
	rarity = 35
	graft_gene = /datum/plant_gene/trait/smoke

/obj/item/food/grown/mushroom/odious_puffball
	seed = /obj/item/seeds/odious_puffball
	name = "odious puffball"
	desc = "<I>Lycoperdon Faetidus</I>Esta bola é considerada um grande incômodo não só por causa da natureza altamente irritante de seus esporos, mas também por causa de seu tamanho considerável e aparência desagradável."
	icon_state = "odious_puffball"
	tastes = list("rotten garlic" = 2, "mushroom" = 1, "spores" = 1)
	wine_power = 50
