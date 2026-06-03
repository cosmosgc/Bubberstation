/obj/item/holosign_creator/sex
	name = "holographic sex projector"
	desc = "Apesar do nome, ela não projeta sexo, mas cria uma barreira não bloqueante que informa quem deseja entrar de que há sexo lá dentro."
	max_signs = 4
	creation_time = 10
	holosign_type = /obj/structure/holosign/sexsign
	w_class = WEIGHT_CLASS_TINY
	//The janitor sign is also purple so no need to make custom sprites here.
/obj/structure/holosign/sexsign
	name = "sex sign"
	desc = "As palavras piscam 'NÃO DEIXE SEU SEXO ENTRAR'. Acho que isso significa que há sexo além desta porta e que você provavelmente não deve entrar, a menos que esteja preparado para consequências inesperadas."
	icon = 'modular_zubbers/icons/effects/sex_barrier.dmi'
	icon_state = "yes_i_spent_time_on_this"
