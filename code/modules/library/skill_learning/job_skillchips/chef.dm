/obj/item/skillchip/job/chef
	name = "B0RK-X3 skillchip" // bork bork bork
	desc = "Este biochip cheira levemente a alho, o que é estranho para algo que é normalmente preso dentro do cérebro de um usuário. Consulte um nutricionista antes de usar."
	skill_name = "Close Quarters Cooking"
	skill_description = "Uma forma especializada de auto-defesa, desenvolvida por sous-chef de cozinhas. Nenhum homem luta mais do que um chef para defender sua cozinha."
	skill_icon = "utensils"
	activate_message = span_notice("Você pode visualizar como defender sua cozinha com artes marciais.")
	deactivate_message = span_notice("Você esquece como controlar seus músculos para executar chutes, batidas e amarras enquanto em um ambiente de cozinha.")
	/// The Chef CQC given by the skillchip.
	var/datum/martial_art/cqc/under_siege/style

/obj/item/skillchip/job/chef/Initialize(mapload)
	. = ..()
	style = new(src)
	style.refresh_valid_areas()

/obj/item/skillchip/job/chef/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	style.teach(user)

/obj/item/skillchip/job/chef/on_deactivate(mob/living/carbon/user, silent = FALSE)
	style.unlearn(user)
	return ..()
