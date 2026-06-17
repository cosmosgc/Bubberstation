/obj/item/reagent_containers/blood
	name = "blood pack"
	desc = "Contém sangue usado para transfusão. Deve estar ligado ao soro."
	icon = 'icons/obj/medical/bloodpack.dmi'
	icon_state = "bloodpack"
	volume = 200
	fill_icon_thresholds = list(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
	obj_flags = UNIQUE_RENAME | RENAME_NO_DESC
	var/blood_type = null
	var/labeled = FALSE

/obj/item/reagent_containers/blood/Initialize(mapload, vol)
	. = ..()
	if (!blood_type)
		return
	var/datum/blood_type/bloodtype = get_blood_type(blood_type)
	reagents.add_reagent(bloodtype.reagent_type, volume, list("blood_type" = bloodtype, "blood_DNA" = bloodtype.dna_string, BLOOD_DATA_SYNTH_CONTENT = 1), creation_callback = CALLBACK(src, PROC_REF(on_blood_created)))

/obj/item/reagent_containers/blood/proc/on_blood_created(datum/reagent/new_blood)
	new_blood.AddElement(/datum/element/blood_reagent, null, get_blood_type(blood_type))
	update_appearance()

/obj/item/reagent_containers/blood/update_name(updates)
	. = ..()
	if(!labeled)
		name = "blood pack[blood_type ? " - [blood_type]" : ""]"

/obj/item/reagent_containers/blood/random
	icon_state = "random_bloodpack"

/obj/item/reagent_containers/blood/random/Initialize(mapload, vol)
	icon_state = "bloodpack"
	blood_type = pick(BLOOD_TYPE_A_PLUS, BLOOD_TYPE_A_MINUS, BLOOD_TYPE_B_PLUS, BLOOD_TYPE_B_MINUS, BLOOD_TYPE_O_PLUS, BLOOD_TYPE_O_MINUS, BLOOD_TYPE_LIZARD)
	return ..()

/obj/item/reagent_containers/blood/a_plus
	blood_type = BLOOD_TYPE_A_PLUS

/obj/item/reagent_containers/blood/a_minus
	blood_type = BLOOD_TYPE_A_MINUS

/obj/item/reagent_containers/blood/b_plus
	blood_type = BLOOD_TYPE_B_PLUS

/obj/item/reagent_containers/blood/b_minus
	blood_type = BLOOD_TYPE_B_MINUS

/obj/item/reagent_containers/blood/o_plus
	blood_type = BLOOD_TYPE_O_PLUS

/obj/item/reagent_containers/blood/o_minus
	blood_type = BLOOD_TYPE_O_MINUS

/obj/item/reagent_containers/blood/lizard
	blood_type = BLOOD_TYPE_LIZARD

/obj/item/reagent_containers/blood/ethereal
	blood_type = BLOOD_TYPE_ETHEREAL

/obj/item/reagent_containers/blood/snail
	blood_type = BLOOD_TYPE_SNAIL

/obj/item/reagent_containers/blood/snail/examine()
	. = ..()
	. += span_notice("É um pouco viscoso... A etiqueta indica que isso é para caracóis.")

/obj/item/reagent_containers/blood/podperson
	blood_type = BLOOD_TYPE_H2O

/obj/item/reagent_containers/blood/podperson/examine()
	. = ..()
	. += span_notice("Parece ser uma água muito cara.")

// for slimepeople
/obj/item/reagent_containers/blood/toxin
	blood_type = BLOOD_TYPE_TOX

/obj/item/reagent_containers/blood/toxin/examine()
	. = ..()
	. += span_notice("Há um aviso de toxina no rótulo. Isso é para as pessoas viscosas.")

/obj/item/reagent_containers/blood/universal
	blood_type = BLOOD_TYPE_UNIVERSAL

/obj/item/reagent_containers/blood/nameformat(input, user)
	playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
	labeled = TRUE
	return "blood pack[input? " - [input]" : null]"
