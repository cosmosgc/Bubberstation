/obj/item/clothing/accessory/dogtag/unique_blood
	name = "Blood dogtag"
	desc = "Uma dogtag com uma lista de propriedades de sangue."

/obj/item/clothing/accessory/dogtag/unique_blood/Initialize(mapload, blood_type, color_string)
	. = ..()
	if(color_string && blood_type)
		display = span_notice("\"Hi! My blood is [blood_type] despite being [color_string]!\"")
	else
		display = span_notice("The dogtag is all scratched up.")
