/obj/item/card/emag/one_shot
	name = "cryptographic sequencer"
	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list(JOB_DETECTIVE, JOB_HEAD_OF_SECURITY)
	special_desc = "Após a inspeção você pode dizer instantaneamente que este é um verdadeiro sequenciador criptográfico comumente comercializado a granel por barato em incontáveis mercados negros. Eles são conhecidos por sua falta de confiabilidade e quebra após apenas um uso de sua construção desajeitada."
	/// How many uses does it have left?
	var/charges = 1
	/// Who summoned this?
	var/caller

/obj/item/card/emag/one_shot/examine(mob/user)
	. = ..()
	if(user == caller)
		. += span_notice("Parece barato, eles disseram que dá apenas uma chance...")
	else
		. += span_notice("Parece frágil e idêntico ao\"Donk Co.\"Toy.")

/obj/item/card/emag/one_shot/can_emag(atom/target, mob/user)
	if(charges <= 0)
		balloon_alert(user, "sem resposta!")
		return FALSE
	use_charge(user)
	return TRUE

/obj/item/card/emag/one_shot/proc/use_charge(mob/user)
	balloon_alert(user, "Fora das cargas!")
	charges --
