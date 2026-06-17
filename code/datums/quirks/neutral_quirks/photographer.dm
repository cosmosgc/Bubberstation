/datum/quirk/item_quirk/photographer
	name = "Photographer"
	desc = "Você carrega sua câmera e álbum de fotos pessoais onde quer que vá, e seus álbuns são lendários entre seus colegas de trabalho."
	icon = FA_ICON_CAMERA
	value = 0
	mob_trait = TRAIT_PHOTOGRAPHER
	gain_text = span_notice("Você sabe tudo sobre fotografia.")
	lose_text = span_danger("Esqueceu como as câmeras funcionam.")
	medical_record_text = "O paciente menciona fotografia como um hobby de alívio de estresse."
	mail_goodies = list(/obj/item/camera_film)

/datum/quirk/item_quirk/photographer/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/storage/photo_album/personal/photo_album = new(get_turf(human_holder))
	photo_album.persistence_id = "personal_[human_holder.last_mind?.key]" // this is a persistent album, the ID is tied to the account's key to avoid tampering
	photo_album.persistence_load()
	photo_album.name = "[human_holder.real_name]'s photo album"

	give_item_to_holder(photo_album, list(LOCATION_BACKPACK, LOCATION_HANDS))
	give_item_to_holder(
		/obj/item/camera,
		list(
			LOCATION_NECK,
			LOCATION_LPOCKET,
			LOCATION_RPOCKET,
			LOCATION_BACKPACK,
			LOCATION_HANDS
		)
	)
