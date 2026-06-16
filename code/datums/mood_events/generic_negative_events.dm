/datum/mood_event/handcuffed
	description = "Acho que meus comportamentos acabaram me alcançando."
	mood_change = -1

/datum/mood_event/broken_vow //Used for when mimes break their vow of silence
	description = "Trago vergonha ao meu nome e trai minha companhia de mimes ao romper nosso voto sagrado...,"
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/on_fire
	description = "ESTOU EM FOGO!!!"
	mood_change = -12
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/suffocation
	description = "NÃO... CONSIGO RESPIRAR..."
	mood_change = -12
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/burnt_thumb
	description = "Não deveria brincar com fósforos..."
	mood_change = -1
	timeout = 2 MINUTES

/datum/mood_event/cold
	description = "Está muito frio aqui."
	mood_change = -5

/datum/mood_event/hot
	description = "Está ficando quente aqui."
	mood_change = -5

/datum/mood_event/creampie
	description = "Fui atingido. Tem sabor de bolo."
	mood_change = -2
	timeout = 3 MINUTES
	event_flags = MOOD_EVENT_WHIMSY // if whimsical, no penalty

/datum/mood_event/inked
	description = "Fui regado com tinta de polvo. Tem sabor de sal."
	mood_change = -3
	timeout = 3 MINUTES

/datum/mood_event/slipped
	description = "Deslizei. Deveria ter mais cuidado da próxima vez..."
	mood_change = -2
	timeout = 3 MINUTES
	event_flags = MOOD_EVENT_WHIMSY // if whimsical, no penalty

/datum/mood_event/eye_stab
	description = "Antes era um aventurero como você, até que usei uma chave de fenda no olho."
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/delam //SM delamination
	description = "Esses infernos engenheiros não conseguem fazer nada certo..."
	mood_change = -2
	timeout = 4 MINUTES

/datum/mood_event/cascade // Big boi delamination
	description = "Nunca pensei que veria uma cascata de ressonância, nem experimentaria uma..."
	mood_change = -8
	timeout = 5 MINUTES

/datum/mood_event/depression
	description = "Sinto tristeza por razões semelhantes."
	mood_change = -12
	timeout = 2 MINUTES

/datum/mood_event/shameful_suicide //suicide_acts that return SHAME, like sord
	description = "Não consigo mesmo acabar com tudo!"
	mood_change = -15
	timeout = 60 SECONDS

/datum/mood_event/dismembered
	description = "AH! MEU LIMBO! ESTAVA USANDO ISSO!"
	mood_change = -10
	timeout = 8 MINUTES

/datum/mood_event/dismembered/add_effects(obj/item/bodypart/limb)
	if(limb)
		description = "AH! MEU [uppertext(limb.plaintext_zone)]! ESTAVA USANDO ISSO!"

/datum/mood_event/reattachment
	description = "Uau! Meu limbo sente como se eu tivesse dormido nele."
	mood_change = -3
	timeout = 2 MINUTES
	event_flags = MOOD_EVENT_PAIN

/datum/mood_event/reattachment/add_effects(obj/item/bodypart/limb)
	if(limb)
		description = "Uau! Meu [limb.plaintext_zone] sente como se eu tivesse dormido nele."

/datum/mood_event/tased
	description = "Não há 'z' em 'taser'. Está no 'zap'."
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/embedded
	description = "Tire isso!"
	mood_change = -7

/datum/mood_event/table
	description = "Alguém me jogou numa mesa!"
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/table/add_effects()
	if(isfelinid(owner)) //Holy snowflake batman!
		var/mob/living/carbon/human/feline = owner
		feline.wag_tail(3 SECONDS)
		description = "Eles querem brincar na mesa!"
		mood_change = 2

/datum/mood_event/table_limbsmash
	description = "Essa maldita mesa, cara, dói..."
	mood_change = -3
	timeout = 3 MINUTES
	event_flags = MOOD_EVENT_PAIN

/datum/mood_event/table_limbsmash/add_effects(obj/item/bodypart/banged_limb)
	if(banged_limb)
		description = "Meu [banged_limb.plaintext_zone], cara, dói..."

/datum/mood_event/brain_damage
	mood_change = -3

/datum/mood_event/brain_damage/add_effects()
	var/damage_message = pick_list_replacements(BRAIN_DAMAGE_FILE, "brain_damage")
	description = "Hurr durr... [damage_message]"

/datum/mood_event/hulk //Entire duration of having the hulk mutation
	description = "HULK SMASH!"
	mood_change = -4

/datum/mood_event/epilepsy //Only when the mutation causes a seizure
	description = "Deveria ter prestado atenção na advertência de epilepsia."
	mood_change = -3
	timeout = 5 MINUTES

/datum/mood_event/photophobia
	description = "As luzes estão muito brilhantes..."
	mood_change = -3
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/nyctophobia
	description = "É bem escuro por aqui..."
	mood_change = -3
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/claustrophobia
	description = "Por que sinto-me preso?! Liberte-me!!!"
	mood_change = -7
	timeout = 1 MINUTES
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/bright_light
	description = "Odiar o ambiente iluminado... preciso encontrar um lugar mais escuro..."
	mood_change = -12

/datum/mood_event/family_heirloom_missing
	description = "Estou perdendo meu herança familiar..."
	mood_change = -4

/datum/mood_event/healsbadman
	description = "Sinto que estou unido por uma corda frágil e posso desabar a qualquer momento!,"
	mood_change = -4
	timeout = 2 MINUTES

/datum/mood_event/healsbadman/long_term
	timeout = 10 MINUTES

/datum/mood_event/jittery
	description = "Estou nervoso, inquieto e não consigo ficar parado!!"
	mood_change = -2

/datum/mood_event/jittery/add_effects(...)
	if(HAS_PERSONALITY(owner, /datum/personality/paranoid))
		mood_change -= 1

/datum/mood_event/choke
	description = "NÃO CONSIGO RESPIRAR!!!"
	mood_change = -10
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/vomit
	description = "Acabei de vomitar. Feio."
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/vomitself
	description = "Acabei de vomitar em mim mesmo. Isso é desagradável."
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/painful_medicine
	description = "A medicina pode ser boa para mim, mas agora dói como a morte."
	mood_change = -5
	timeout = 60 SECONDS
	event_flags = MOOD_EVENT_PAIN

/datum/mood_event/startled
	description = "Ouvir aquela palavra me fez pensar em algo assustador."
	mood_change = -1
	timeout = 1 MINUTES
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/phobia
	description = "Vi algo muito assustador!"
	mood_change = -4
	timeout = 4 MINUTES
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/spooked
	description = "O ranger dessas ossos... ainda me persegue."
	mood_change = -4
	timeout = 4 MINUTES
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/notcreeping
	description = "As vozes não estão felizes e distorcem minhas ideias com dor para voltar ao trabalho.,"
	mood_change = -6
	timeout = 3 SECONDS
	hidden = TRUE

/datum/mood_event/notcreepingsevere//not hidden since it's so severe
	description = "ELES NEEEEEEED OBSESSIONNNN!!"
	mood_change = -30
	timeout = 3 SECONDS

/datum/mood_event/notcreepingsevere/add_effects(name)
	var/list/unstable = list(name)
	for(var/i in 1 to rand(3,5))
		unstable += copytext_char(name, -1)
	var/unhinged = uppertext(unstable.Join(""))//example Tinea Luxor > TINEA LUXORRRR (with randomness in how long that slur is)
	description = "ELES NEEEEEEED [unhinged]!!"

/datum/mood_event/tower_of_babel
	description = "Minha capacidade de comunicação é um babilônico incoerente..."
	mood_change = -1
	timeout = 15 SECONDS

/datum/mood_event/back_pain
	description = "As mochilas nunca ficam bem no meu ombro, isso dói como a morte!"
	mood_change = -15
	event_flags = MOOD_EVENT_PAIN

/datum/mood_event/sacrifice_bad
	description = "Esses malditos selvagens!"
	mood_change = -5
	timeout = 2 MINUTES
	event_flags = MOOD_EVENT_SPIRITUAL

/datum/mood_event/artbad
	description = "Produzi arte melhor do que aquela com minha bunda."
	mood_change = -2
	timeout = 2 MINUTES
	event_flags = MOOD_EVENT_ART

/datum/mood_event/artbad/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/creative))
		mood_change = 0
		description = "Todos precisam começar sua jornada artística em algum lugar!"

/datum/mood_event/graverobbing
	description = "Acabei de desrespeitar um túmulo... não acredito que fiz isso..."
	mood_change = -8
	timeout = 3 MINUTES

/datum/mood_event/deaths_door
	description = "É isso... realmente vou morrer."
	mood_change = -20

/datum/mood_event/gunpoint
	description = "Esse cara é louco! Melhor me cuidar..."
	mood_change = -10
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/tripped
	description = "Não acredito que caí na velha trapaça!"
	mood_change = -5
	timeout = 2 MINUTES

/datum/mood_event/untied
	description = "Odiar quando os meus sapatos se soltam!"
	mood_change = -3
	timeout = 60 SECONDS

/datum/mood_event/gates_of_mansus
	description = "OH DEUS, tive um vislumbre do horror além deste mundo. A REALIDADE SE DESENROLA DIANTE MEUS OLHOS!"
	mood_change = -25
	timeout = 4 MINUTES
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/high_five_full_hand
	description = "Oh Deus, não sei nem como fazer o high-five corretamente..."
	mood_change = -1
	timeout = 45 SECONDS

/datum/mood_event/too_slow
	description = "NÃO! COMO PODEI SER... MUITO LENTO????"
	mood_change = -2 // multiplied by how many people saw it happen, up to 8, so potentially massive. the ULTIMATE prank carries a lot of weight
	timeout = 2 MINUTES

/datum/mood_event/too_slow/add_effects(param)
	var/people_laughing_at_you = 1 // start with 1 in case they're on the same tile or something
	for(var/mob/living/carbon/iter_carbon in oview(owner, 7))
		if(iter_carbon.stat == CONSCIOUS)
			people_laughing_at_you++
			if(people_laughing_at_you > 7)
				break

	mood_change *= people_laughing_at_you
	return ..()

/datum/mood_event/surgery
	description = "ELES ESTÃO ME CORTANDO!!"
	mood_change = -8
	event_flags = MOOD_EVENT_FEAR
	var/surgery_completed = FALSE

/datum/mood_event/surgery/success
	description = "Aquele procedimento realmente doeu... Aliviado, talvez tenha funcionado..."
	timeout = 3 MINUTES
	surgery_completed = TRUE

/datum/mood_event/surgery/failure
	description = "AHHHHGH! ELES ME FILATARAM VIVO!"
	timeout = 10 MINUTES
	surgery_completed = TRUE

/datum/mood_event/bald
	description = "Preciso de algo para cobrir minha cabeça..."
	mood_change = -3

/datum/mood_event/bald_reminder
	description = "Lembrei-me que não consigo crescer meu cabelo de volta! Isso é terrível!"
	mood_change = -5
	timeout = 4 MINUTES

/datum/mood_event/bad_touch
	description = "Não gosto quando as pessoas me tocam."
	mood_change = -3
	timeout = 4 MINUTES

/datum/mood_event/very_bad_touch
	description = "Realmente não gosto quando as pessoas me tocam."
	mood_change = -5
	timeout = 4 MINUTES

/datum/mood_event/noogie
	description = "Uau! Isso é como a escola espacial novamente..."
	mood_change = -2
	timeout = 60 SECONDS

/datum/mood_event/noogie_harsh
	description = "OW!! Foi pior do que um noogie comum!"
	mood_change = -4
	timeout = 60 SECONDS

/datum/mood_event/aquarium_negative
	description = "Todos os peixes estão mortos..."
	mood_change = -3
	timeout = 90 SECONDS

/datum/mood_event/tail_lost
	description = "Meu rabo!! Por quê?!"
	mood_change = -8
	timeout = 10 MINUTES

/datum/mood_event/tail_balance_lost
	description = "Sinto-me desequilibrado sem meu rabo."
	mood_change = -2

/datum/mood_event/tail_regained_wrong
	description = "Isso é algum tipo de piada doentia?! Isso NÃO é o rabo certo."
	mood_change = -12 // -8 for tail still missing + -4 bonus for being frakenstein's monster
	timeout = 5 MINUTES

/datum/mood_event/tail_regained_species
	description = "Esse rabo não é meu, mas pelo menos me equilibra..."
	mood_change = -5
	timeout = 5 MINUTES

/datum/mood_event/tail_regained_right
	description = "Meu rabo está de volta, mas foi traumático..."
	mood_change = -2
	timeout = 5 MINUTES

/datum/mood_event/burnt_wings
	description = "MINHAS AVESSAS PRECIOSAS!!"
	mood_change = -10
	timeout = 10 MINUTES

/datum/mood_event/holy_smite //punished
	description = "Fui punido por meu deus!"
	mood_change = -5
	timeout = 5 MINUTES

/datum/mood_event/banished //when the chaplain is sus! (and gets forcably de-holy'd)
	description = "Fui excomungado!"
	mood_change = -10
	timeout = 10 MINUTES

/datum/mood_event/heresy
	description = "Quase não consigo respirar com todo esse HERESIA acontecendo!"
	mood_change = -5
	timeout = 5 MINUTES

/datum/mood_event/soda_spill
	description = "Legal! Isso está bem, queria usar a garrafa, não beber..."
	mood_change = -2
	timeout = 1 MINUTES

/datum/mood_event/watersprayed
	description = "Odiar ser regado com água!"
	mood_change = -1
	timeout = 30 SECONDS

/datum/mood_event/gamer_withdrawal
	description = "Gostaria de estar jogando agora..."
	mood_change = -5
	event_flags = MOOD_EVENT_GAMING

/datum/mood_event/gamer_lost
	description = "Se não sou bom em jogos de vídeo, posso realmente chamar-me jogador?"
	mood_change = -6
	timeout = 10 MINUTES
	event_flags = MOOD_EVENT_GAMING

/datum/mood_event/lost_52_card_pickup
	description = "Isso é muito vergonhoso! Estou envergonhado por pegar todas essas cartas do chão..."
	mood_change = -3
	timeout = 3 MINUTES
	event_flags = MOOD_EVENT_WHIMSY | MOOD_EVENT_GAMING

/datum/mood_event/russian_roulette_lose_cheater
	description = "Joguei e perdi! Foi uma boa coisa que não estava mirando na cabeça..."
	mood_change = -10
	timeout = 10 MINUTES

/datum/mood_event/russian_roulette_lose
	description = "Joguei minha vida e perdi! Acho que é o fim..."
	mood_change = -20
	timeout = 10 MINUTES

/datum/mood_event/russian_roulette_lose/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/gambler))
		mood_change *= 0.5
		description = "Joguei minha vida e perdi! Na verdade, o jogo foi manipulado desde o início..."
		return

/datum/mood_event/bad_touch_bear_hug
	description = "Acabei de ser comprimido demais."
	mood_change = -1
	timeout = 2 MINUTES

/datum/mood_event/rippedtail
	description = "Cortei seu rabo direto, o que fiz?!"
	mood_change = -5
	timeout = 30 SECONDS

/datum/mood_event/sabrage_fail
	description = "Poxa! Esse truque não saiu como planejado!"
	mood_change = -2
	timeout = 4 MINUTES

/datum/mood_event/body_purist
	description = "Sinto cyberneticos ligados a mim e ODIAR!,"

/datum/mood_event/body_purist/add_effects(power)
	mood_change = power

/datum/mood_event/unsatisfied_nomad
	description = "Fiquei aqui demais! Quero sair e explorar o espaço!"
	mood_change = -3

/datum/mood_event/moon_insanity
	description = "A LUA JULGA E ENCONTRA-ME INSUFICIENTE!!"
	mood_change = -3
	timeout = 5 MINUTES
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/moon_insanity/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/spiritual))
		mood_change *= 2

/datum/mood_event/amulet_insanity
	description = "EU VEJO A LUZ, ELA DEVE SER PARADA!"
	mood_change = -6
	timeout = 5 MINUTES
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/mallet_humiliation
	description = "Ser atingido por uma arma tão estúpida sente-se bastante humilhante..."
	mood_change = -3
	timeout = 10 SECONDS

///Wizard cheesy grand finale - what everyone but the wizard gets
/datum/mood_event/madness_despair
	description = "INÚTIL, INÚTIL, INÚTIL!!!"
	mood_change = -200
	special_screen_obj = "mood_despair"

/datum/mood_event/all_nighter
	description = "Não dormi nada ontem. Estou exausto."
	mood_change = -5

//Used by the Veteran Advisor trait job
/datum/mood_event/desentized
	description = "Nada jamais rivalizará com o que já vi antes..."
	mood_change = -3
	special_screen_obj = "mood_desentized"

//Used for the psychotic brawling martial art, if the person is a pacifist.
/datum/mood_event/pacifism_bypassed
	description = "NÃO QUERIA LESAR ELES!"
	mood_change = -20
	timeout = 10 MINUTES

//Gained when you're hit over the head with wrapping paper or cardboard roll
/datum/mood_event/bapped
	description = "Uau... minha cabeça, sinto-me um pouco tolo agora!"
	mood_change = -1
	timeout = 3 MINUTES

/datum/mood_event/bapped/add_effects()
	// Felinids apparently hate being hit over the head with cardboard
	if(isfelinid(owner))
		mood_change = -2

/datum/mood_event/encountered_evil
	description = "Não queria acreditar, mas há pessoas lá fora que são realmente maléficas."
	mood_change = -1
	timeout = 1 MINUTES

/datum/mood_event/smoke_in_face
	description = "O fumo de cigarro é desagradável."
	mood_change = -3
	timeout = 30 SECONDS

/datum/mood_event/smoke_in_face/add_effects(param)
	if(HAS_TRAIT(owner, TRAIT_ANOSMIA))
		description = "O fumo de cigarro é desagradável."
		mood_change = -1
	if(HAS_TRAIT(owner, TRAIT_SMOKER))
		description = "Fumando fumaça no meu rosto, realmente?"
		mood_change = 0

/datum/mood_event/slots/loss
	description = "Uau, que péssimo!"
	mood_change = -2
	timeout = 5 MINUTES
	event_flags = MOOD_EVENT_GAMING

/datum/mood_event/slots/loss/add_effects()
	if(HAS_PERSONALITY(owner, /datum/personality/gambler))
		mood_change = 0
		description = "Uau, que péssimo."
	if(HAS_PERSONALITY(owner, /datum/personality/industrious) || HAS_PERSONALITY(owner, /datum/personality/slacking/diligent))
		mood_change *= 1.5

/datum/mood_event/lost_control_of_life
	description = "Perdi o controle da minha vida."
	mood_change = -5
	timeout = 5 MINUTES

/datum/mood_event/empathetic_sad
	description = "Ver pessoas tristes me deixa triste."
	mood_change = -2
	timeout = 3 MINUTES

/datum/mood_event/misanthropic_sad
	description = "Ver pessoas felizes me deixa inseguro."
	mood_change = -2
	timeout = 3 MINUTES

/datum/mood_event/paranoid/one_on_one
	description = "Estou sozinho com alguém - e se quiser me matar?"
	mood_change = -3
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/paranoid/large_group
	description = "Há tantas pessoas ao redor - qualquer uma delas pode querer me machucar!"
	mood_change = -3
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/nt_disillusioned
	description = "Odiar a companhia, e tudo o que representa."
	mood_change = -2

/datum/mood_event/disillusioned_revs_lost
	description = "A revolução foi derrotada... greaaaat."
	mood_change = -2
	timeout = 10 MINUTES

/datum/mood_event/loyalist_revs_win
	description = "A revolução foi um sucesso... Isso vai prejudicar os lucros trimestrais."
	mood_change = -2
	timeout = 10 MINUTES

/datum/mood_event/slacking_off_diligent
	description = "Devo voltar ao trabalho."
	mood_change = -1

/datum/mood_event/unimaginative_patronage
	description = "Isso sentiu-se como um desperdício de dinheiro."
	mood_change = -2
	timeout = 5 MINUTES

/datum/mood_event/unimaginative_framing
	description = "Podia ter pendurado algo mais útil lá."
	mood_change = -2
	timeout = 5 MINUTES

/datum/mood_event/unimaginative_sculpting
	description = "Isso sentiu-se como um desperdício de materiais."
	mood_change = -2
	timeout = 5 MINUTES

/datum/mood_event/splattered_with_blood
	description = "Ugh, acabei de me cobrir com sangue!"
	mood_change = -4
	timeout = 4 MINUTES

/datum/mood_event/splattered_with_blood/can_effect_mob(datum/mood/home, mob/living/who, ...)
	if(isvampire(who))
		return FALSE

	return ..()

/datum/mood_event/splattered_with_blood/add_effects(...)
	if(HAS_TRAIT(owner, TRAIT_CULT_HALO))
		mood_change = 2
		description = "Sangue, sangue! O Geômetra ficará satisfeito."
		return
	if(HAS_TRAIT(owner, TRAIT_MORBID) || HAS_TRAIT(owner, TRAIT_EVIL))
		mood_change = 0
		description = "Acabei de me cobrir com sangue. Fascinante!"
		return
	if(IS_DESENSITIZED(owner))
		mood_change *= 0.5

/datum/mood_event/teetotal_hangover
	description = "Que desonra! Isso é o que acontece quando se se alimenta de álcool!"
	mood_change = -4
	timeout = 10 MINUTES

/datum/mood_event/normal_hangover
	description = "Ugh, que noite."
	mood_change = 0
	timeout = 10 MINUTES

/datum/mood_event/jabbed_with_tester
	description = "Man, ser picado com aquilo foi péssimo."
	mood_change = -4
	timeout = 5 MINUTES

/datum/mood_event/gizmo_negative
	description = "I hear a voice whispering, and I don't like what it says."
	mood_change = -3
	timeout = 30 SECONDS
