#define BRASS_TOOLSPEED_MOD 0.5

/obj/item/wirecutters/brass
	name = "brass wirecutters"
	desc = "Um par de cortadores de bronze. O cabo parece levemente quente."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "cutters_brass"
	flags_1 = null
	random_color = FALSE
	toolspeed = BRASS_TOOLSPEED_MOD
	greyscale_config = null
	greyscale_config_belt = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = null

/obj/item/screwdriver/brass
	name = "brass screwdriver"
	desc = "Uma chave de fenda feita de bronze. O cabo parece quente ao toque."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "screwdriver_brass"
	post_init_icon_state = null
	toolspeed = BRASS_TOOLSPEED_MOD
	random_color = FALSE
	greyscale_config = null
	greyscale_config_belt = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = null

/obj/item/weldingtool/experimental/brass
	name = "brass welding tool"
	desc = "Um soldador de bronze que parece se reabastecer constantemente. Está levemente quente ao toque."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "welder_brass"
	toolspeed = BRASS_TOOLSPEED_MOD

/obj/item/crowbar/brass
	name = "brass crowbar"
	desc = "Um pé de cabra de bronze. Parece levemente quente ao toque."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "crowbar_brass"
	worn_icon_state = "crowbar"
	toolspeed = BRASS_TOOLSPEED_MOD

/obj/item/wrench/brass
	name = "brass wrench"
	desc = "Uma chave inglesa. Está levemente quente ao toque."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	icon = 'modular_skyrat/modules/clock_cult/icons/tools.dmi'
	icon_state = "wrench_brass"
	toolspeed = BRASS_TOOLSPEED_MOD

/obj/item/storage/belt/utility/clock
	name = "old toolbelt"
	desc = "Segura ferramentas. Este já viu dias melhores. Há o contorno de uma engrenagem aproximadamente cortada no couro de um lado."

/obj/item/storage/belt/utility/clock/PopulateContents()
	new /obj/item/screwdriver/brass(src)
	new /obj/item/crowbar/brass(src)
	new /obj/item/weldingtool/experimental/brass(src)
	new /obj/item/wirecutters/brass(src)
	new /obj/item/wrench/brass(src)
	new /obj/item/multitool(src)

#undef BRASS_TOOLSPEED_MOD
