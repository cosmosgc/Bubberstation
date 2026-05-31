/obj/structure/closet/crate/secure
	desc = "Uma caixa segura."
	name = "secure crate"
	icon_state = "securecrate"
	base_icon_state = "securecrate"
	secure = TRUE
	locked = TRUE
	max_integrity = 500
	armor_type = /datum/armor/crate_secure
	damage_deflection = 25

	var/tamperproof = 0

/datum/armor/crate_secure
	melee = 30
	bullet = 50
	laser = 50
	energy = 100
	fire = 80
	acid = 80

/obj/structure/closet/crate/secure/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_MISSING_ITEM_ERROR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NO_MANIFEST_CONTENTS_ERROR, TRAIT_GENERIC)

/obj/structure/closet/crate/secure/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	if(prob(tamperproof) && damage_amount >= DAMAGE_PRECISION)
		boom()
	else
		return ..()

/obj/structure/closet/crate/secure/proc/boom(mob/user)
	if(user)
		to_chat(user, span_danger("O sistema anti-tampão da caixa se ativa!"))
		log_bomber(user, "has detonated a", src)
	dump_contents()
	explosion(src, heavy_impact_range = 1, light_impact_range = 5, flash_range = 5)
	qdel(src)

/obj/structure/closet/crate/secure/weapon
	desc = "Uma caixa de armas segura."
	name = "weapons crate"
	icon_state = "weaponcrate"
	base_icon_state = "weaponcrate"

/obj/structure/closet/crate/secure/plasma
	desc = "Uma caixa de plasma segura."
	name = "plasma crate"
	icon_state = "plasmacrate"
	base_icon_state = "plasmacrate"

/obj/structure/closet/crate/secure/gear
	desc = "Uma caixa segura."
	name = "gear crate"
	icon_state = "secgearcrate"
	base_icon_state = "secgearcrate"

/obj/structure/closet/crate/secure/hydroponics
	desc = "Uma caixa com uma fechadura, pintada no esquema dos botânicos da estação."
	name = "secure hydroponics crate"
	icon_state = "hydrosecurecrate"
	base_icon_state = "hydrosecurecrate"

/obj/structure/closet/crate/secure/freezer //for consistency with other "freezer" closets/crates
	desc = "Uma geladeira com fechadura, usada para proteger perecíveis."
	name = "secure kitchen icebox"
	icon_state = "kitchen_secure_crate"
	base_icon_state = "kitchen_secure_crate"
	paint_jobs = null

/obj/structure/closet/crate/secure/freezer/pizza
	name = "secure pizza crate"
	desc = "Uma caixa isolada com uma fechadura, usada para proteger pizza."
	tamperproof = 10
	req_access = list(ACCESS_KITCHEN)

/obj/structure/closet/crate/secure/freezer/pizza/PopulateContents()
	. = ..()
	new /obj/effect/spawner/random/food_or_drink/pizzaparty(src)

/obj/structure/closet/crate/secure/centcom
	name = "secure centcom crate"
	icon_state = "centcom_secure"
	base_icon_state = "centcom_secure"

/obj/structure/closet/crate/secure/cargo
	name = "secure cargo crate"
	icon_state = "cargo_secure"
	base_icon_state = "cargo_secure"

/obj/structure/closet/crate/secure/cargo/mining
	name = "secure mining crate"
	icon_state = "mining_secure"
	base_icon_state = "mining_secure"

/obj/structure/closet/crate/secure/radiation
	name = "secure radioation crate"
	icon_state = "radiation_secure"
	base_icon_state = "radiation_secure"

/obj/structure/closet/crate/secure/engineering
	desc = "Uma caixa com uma fechadura, pintada no esquema dos engenheiros da estação."
	name = "secure engineering crate"
	icon_state = "engi_secure_crate"
	base_icon_state = "engi_secure_crate"

/obj/structure/closet/crate/secure/engineering/atmos
	name = "secure atmospherics crate"
	desc = "Uma caixa com uma fechadura, pintada no esquema dos engenheiros atmosféricos da estação."
	icon_state = "atmos_secure"
	base_icon_state = "atmos_secure"


/obj/structure/closet/crate/secure/science
	name = "secure science crate"
	desc = "Uma caixa com uma fechadura, pintada no esquema dos cientistas da estação."
	icon_state = "scisecurecrate"
	base_icon_state = "scisecurecrate"

/obj/structure/closet/crate/secure/science/robo
	name = "robotics science crate"
	icon_state = "robo_secure"
	base_icon_state = "robo_secure"

/obj/structure/closet/crate/secure/trashcart
	desc = "Um carrinho de lixo pesado com rodas. Tem uma trava eletrônica."
	name = "secure trash cart"
	max_integrity = 250
	damage_deflection = 10
	icon_state = "securetrashcart"
	base_icon_state = "securetrashcart"
	weld_z = 5
	paint_jobs = null
	req_access = list(ACCESS_JANITOR)

/obj/structure/closet/crate/secure/trashcart/filled

/obj/structure/closet/crate/secure/trashcart/filled/PopulateContents()
	. = ..()
	for(var/i in 1 to rand(8,12))
		new /obj/effect/spawner/random/trash/deluxe_garbage(src)
		if(prob(35))
			new /obj/effect/spawner/random/trash/garbage(src)
	for(var/i in 1 to rand(4,6))
		if(prob(30))
			new /obj/item/storage/bag/trash/filled(src)

/obj/structure/closet/crate/secure/owned
	name = "private crate"
	desc = "Uma capa de caixa projetada só para abrir para quem comprou seu conteúdo."
	icon_state = "privatecrate"
	base_icon_state = "privatecrate"
	///Account of the person buying the crate if private purchasing.
	var/datum/bank_account/buyer_account
	///Department of the person buying the crate if buying via the NIRN app.
	var/datum/bank_account/department/department_account
	///Is the secure crate opened or closed?
	var/privacy_lock = TRUE
	///Is the crate being bought by a person, or a budget card?
	var/department_purchase = FALSE

/obj/structure/closet/crate/secure/owned/examine(mob/user)
	. = ..()
	. += span_notice("Está trancada com uma fechadura de privacidade, e só pode ser desbloqueada pela identidade do comprador.")
	// BUBBER EDIT START - show department account on examine if bought with departmental funds
	if(department_purchase)
		. += span_notice("Esta caixa foi comprada com fundos departamentais de[department_account.account_holder], e pode ser aberto por qualquer um que tem uma identidade ligada a uma conta com um pagamento desse departamento.")
		. += span_notice("Ou substituído por alguém com acesso ao capitão.")
	// BUBBER EDIT END

/obj/structure/closet/crate/secure/owned/Initialize(mapload, datum/bank_account/_buyer_account)
	. = ..()
	buyer_account = _buyer_account
	if(IS_DEPARTMENTAL_ACCOUNT(buyer_account))
		department_purchase = TRUE
		department_account = buyer_account
		// captain access override that ignores lockout
		req_access = list(ACCESS_CAPTAIN)

/obj/structure/closet/crate/secure/owned/togglelock(mob/living/user, silent)
	if(privacy_lock)
		if(!broken)
			var/obj/item/card/id/id_card = user.get_idcard(TRUE)
			if(id_card)
				if(id_card.registered_account)
					// BUBBER EDIT START - allow captain access override for departmental private crates
					if(id_card.registered_account == buyer_account || (department_purchase && ((id_card.registered_account?.account_job?.paycheck_department) == (department_account.department_id) || check_access(id_card))))
					// BUBBER EDIT END
						if(iscarbon(user))
							add_fingerprint(user)
						locked = !locked
						user.visible_message(span_notice("[user]Destranca.[src]Fechamento de privacidade."),
										span_notice("Você abre.[src]Fechamento de privacidade."))
						privacy_lock = FALSE
						update_appearance()
					else if(!silent)
						to_chat(user, span_warning("Conta bancária não combina com comprador!"))
				else if(!silent)
					to_chat(user, span_warning("Nenhuma conta bancária identificada!"))
			else if(!silent)
				to_chat(user, span_warning("Nenhuma identificação detectada!"))
		else if(!silent)
			to_chat(user, span_warning("[src]Está quebrado!"))
	else ..()

/obj/structure/closet/crate/secure/freezer/interdyne
	name = "\improper Interdyne freezer"
	desc = "Este é um freezer da Interdyne Pharmaceuticals. Pode ou não conter órgãos frescos."
	icon_state = "interdynefreezer"
	base_icon_state = "interdynefreezer"
	req_access = list(ACCESS_SYNDICATE)

/obj/structure/closet/crate/secure/freezer/interdyne/blood
	name = "\improper Interdyne blood freezer"
	desc = "Este é um freezer da Interdyne Pharmaceuticals. É feito para conter sangue fresco e de alta qualidade."

/obj/structure/closet/crate/secure/freezer/interdyne/blood/PopulateContents()
	. = ..()
	for(var/i in 1 to 13)
		new /obj/item/reagent_containers/blood/random(src)

/obj/structure/closet/crate/secure/freezer/donk
	name = "\improper Donk Co. fridge"
	desc = "Uma geladeira da marca Donk Co., mantém seus donkpockets e munição espuma fresca!"
	icon_state = "donkcocrate_secure"
	base_icon_state = "donkcocrate_secure"
	req_access = list(ACCESS_SYNDICATE)

/obj/structure/closet/crate/secure/syndicate
	name = "\improper Syndicate crate"
	desc = "Uma caixa segura com a marca do Sindicato nela."
	icon_state = "syndicrate"
	base_icon_state = "syndicrate"
	req_access = list(ACCESS_SYNDICATE)

/obj/structure/closet/crate/secure/syndicate/interdyne
	name = "\improper Interdyne crate"
	desc = "Crate pertencente à Interdyne Pharmaceutics. Espero que não tenha armas biológicas dentro..."
	icon_state = "interdynecrate"
	base_icon_state = "interdynecrate"

/obj/structure/closet/crate/secure/syndicate/tiger
	name = "\improper Tiger Co-Op crate"
	icon_state = "tigercrate"
	base_icon_state = "tigercrate"

/obj/structure/closet/crate/secure/syndicate/self
	name = "\improper S.E.L.F. crate"
	desc = "Uma caixa segura trancada por dentro com um painel de varredura acima dele e exibição holográfica do status da fechadura. Engenheiros da Frente de Libertação de Motores são bem exibidos."
	icon_state = "selfcrate_secure"
	base_icon_state = "selfcrate_secure"

/obj/structure/closet/crate/secure/syndicate/mi13
	name = "mysterious secure crate"
	desc = "Uma caixa segura. Faltam logos óbvios ou até códigos de onde ele chegou, mas parece que foi tirado direto de um filme de espião."
	icon_state = "mithirteencrate"
	base_icon_state = "mithirteencrate"
	open_sound_volume = 15
	close_sound_volume = 20

/obj/structure/closet/crate/secure/syndicate/arc
	name = "\improper Animal Rights Consortium crate"
	icon_state = "arccrate"
	base_icon_state = "arccrate"

/obj/structure/closet/crate/secure/syndicate/cybersun
	name = "\improper Cybersun crate"

/obj/structure/closet/crate/secure/syndicate/cybersun/dawn
	desc = "Uma caixa segura das Indústrias Cybersun. Tem coloração laranja-verde distinta, provavelmente de algum departamento ou divisão, mas você não pode dizer o que é."
	icon_state = "cyber_dawncrate"
	base_icon_state = "cyber_dawncrate"

/obj/structure/closet/crate/secure/syndicate/cybersun/noon
	desc = "Uma caixa segura das Indústrias Cybersun. Tem coloração amarela-laranja distinta, provavelmente de algum departamento ou divisão, mas você não pode dizer o que é."
	icon_state = "cyber_nooncrate"
	base_icon_state = "cyber_nooncrate"

/obj/structure/closet/crate/secure/syndicate/cybersun/dusk
	desc = "Uma caixa segura das Indústrias Cybersun. Tem coloração roxo-verde distinta, provavelmente de algum departamento ou divisão, mas você não pode dizer o que é."
	icon_state = "cyber_duskcrate"
	base_icon_state = "cyber_duskcrate"

/obj/structure/closet/crate/secure/syndicate/cybersun/night
	desc = "Uma caixa segura das Indústrias Cybersun. Este adorna descaradamente as cores do sindicato. Você só pode imaginar que contém equipamento para agentes do sindicato."
	icon_state = "cyber_nightcrate"
	base_icon_state = "cyber_nightcrate"

/obj/structure/closet/crate/secure/syndicate/wafflecorp
	name = "\improper Waffle corp. crate"
	desc = "Um modelo muito antiquado e design de caixa de embarque com uma fechadura moderna amarrada nele, como adequado ao seu proprietário de marca, Waffle Corporation. Lettering dourado escrito em cursivo pelo logotipo diz 'trazê-lo consecutivamente top cinco mundial de classificação * café da manhã desde 2055. Uma letra muito menor, também em cursiva, esclarece: '* em anos 2099-2126'... É o ano 2563 agora, no entanto."
	icon_state = "wafflecrate"
	base_icon_state = "wafflecrate"

/obj/structure/closet/crate/secure/syndicate/gorlex
	name = "\improper Gorlex Marauders crate"
	icon_state = "gorlexcrate"
	base_icon_state = "gorlexcrate"

/obj/structure/closet/crate/secure/syndicate/gorlex/weapons
	desc = "Uma caixa de armas de Gorlex Marauders."
	name = "weapons crate"
	icon_state = "gorlex_weaponcrate"
	base_icon_state = "gorlex_weaponcrate"

/obj/structure/closet/crate/secure/syndicate/gorlex/weapons/bustedlock
	desc = "Uma caixa de armas espancada com Gorlex Marauders marcando. A fechadura parece quebrada."
	name = "damaged weapons crate"
	secure = FALSE
	locked = FALSE
	max_integrity = 400
	damage_deflection = 15
