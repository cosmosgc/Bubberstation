// Because plushes have a second desc var that needs to be updated
/obj/item/toy/plush/on_loadout_custom_described()
	normal_desc = desc

// // MODULAR PLUSHES
/obj/item/toy/plush/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	inhand_icon_state = null

/obj/item/toy/plush/skyrat/borbplushie
	name = "borb plushie"
	desc = "Um adorável brinquedo de pelúcia que se parece com um pássaro redondo e fofo. Sem ser confundido com o amigo dele, o birb plushie."
	icon_state = "plushie_borb"
	attack_verb_continuous = list("pecks", "peeps")
	attack_verb_simple = list("peck", "peep")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/peep_once.ogg' = 1)

/obj/item/toy/plush/skyrat/deer
	name = "deer plushie"
	desc = "Um adorável brinquedo de pelúcia que se parece com um veado."
	icon_state = "plushie_deer"
	attack_verb_continuous = list("headbutts", "boops", "bapps", "bumps")
	attack_verb_simple = list("headbutt", "boop", "bap", "bump")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

/obj/item/toy/plush/skyrat/fermis
	name = "medcat plushie"
	desc = "Um afetuoso brinquedo de pelúcia que se parece com um certo medcat, vem completo com bateria abanando cauda! Você tem a impressão que ela está te torcendo para encontrar felicidade e ser gentil com as pessoas."
	icon_state = "plushie_fermis"
	attack_verb_continuous = list("cuddles", "petpatts", "wigglepurrs")
	attack_verb_simple = list("cuddle", "petpatt", "wigglepurr")
	squeak_override = list('modular_zubbers/sound/voice/merowr.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/skyrat/fermis/chen
	name = "securicat plushie"
	desc = "O companheiro oficial de pelúcia para o petisco! Parece um certo securicat. Você tem a impressão que ela está encorajando você a ser corajoso e proteger aqueles que você gosta."
	icon_state = "plushie_chen"
	attack_verb_continuous = list("snuggles", "meowhuggies", "wigglepurrs")
	attack_verb_simple = list("snuggle", "meowhuggie", "wigglepurr")
	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list(JOB_ASSISTANT, JOB_HEAD_OF_SECURITY)
	special_desc = "Há um bolso embaixo do casaco escondendo uma pequena imagem do plushie de medcat e um anel de diamante de fita menor. D'awww."

/obj/item/toy/plush/skyrat/sechound
	name = "sec-hound plushie"
	desc = "Um adorável brinquedo de pelúcia de um SecHound, o confiável Nanotrasen patrocinou o borg da segurança!"
	icon_state = "plushie_securityk9"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/skyrat/medihound
	name = "medi-hound plushie"
	desc = "Um adorável brinquedo de pelúcia."
	icon_state = "plushie_medihound"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/skyrat/engihound
	name = "engi-hound plushie"
	desc = "Um adorável brinquedo de pelúcia de um engihound."
	icon_state = "plushie_engihound"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/skyrat/scrubpuppy
	name = "scrub-puppy plushie"
	desc = "Um adorável brinquedo de pelúcia de um Scrubpuppy, o cachorro trabalhador que mantém a estação limpa!"
	icon_state = "plushie_scrubpuppy"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/skyrat/meddrake
	name = "medi-drake plushie"
	desc = "Um adorável brinquedo de pelúcia de um Medidrake."
	icon_state = "plushie_meddrake"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/skyrat/secdrake
	name = "sec-drake plushie"
	desc = "Um adorável brinquedo de pelúcia de um Secdrake."
	icon_state = "plushie_secdrake"
	attack_verb_continuous = list("beeps", "boops", "pings")
	attack_verb_simple = list("beep", "boop", "ping")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/skyrat/fox
	name = "fox plushie"
	desc = "Um adorável brinquedo de pelúcia de uma raposa."
	icon_state = "plushie_fox"
	attack_verb_continuous = list("geckers", "boops", "nuzzles")
	attack_verb_simple = list("gecker", "boop", "nuzzle")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

/obj/item/toy/plush/skyrat/duffmoth
	name = "suspicious moth plushie"
	desc = "Uma pelúcia retratando uma certa mariposa. Ele provavelmente se transformou em uma pelúcia comercializável."
	icon_state = "plushie_duffy"
	attack_verb_continuous = list("flutters", "flaps", "squeaks")
	attack_verb_simple = list("flutter", "flap", "squeak")
	squeak_override = list('modular_zubbers/sound/emotes/mothsqueak.ogg' = 1)
	gender = MALE

/obj/item/toy/plush/skyrat/leaplush
	name = "suspicious deer plushie"
	desc = "Um veado bonito e muito familiar."
	icon_state = "plushie_lea"
	attack_verb_continuous = list("headbutts", "plaps")
	attack_verb_simple = list("headbutt", "plap")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/leaplush.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/skyrat/sarmieplush
	name = "cosplayer plushie"
	desc = "Um brinquedo de pelúcia que parece um cosplayer familiar,<b>Ele parece baste.</b>"
	icon_state = "plushie_sarmie"
	attack_verb_continuous = list("baps")
	attack_verb_simple = list("bap")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/weh.ogg' = 1)
	gender = MALE

/obj/item/toy/plush/skyrat/sharknet
	name = "gluttonous shark plushie"
	desc = "Um pedacinho pesado de um tubarão grande e faminto"
	icon_state = "plushie_sharknet"
	attack_verb_continuous = list("cuddles", "squishes", "wehs")
	attack_verb_simple = list("cuddle", "squish", "weh")
	w_class = WEIGHT_CLASS_NORMAL
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/slime_squish.ogg' = 1)
	young = TRUE //No.

/obj/item/toy/plush/sharknet/Initialize(mapload)
	. = ..()
	create_storage(max_slots = 2, max_specific_storage = WEIGHT_CLASS_SMALL, canhold = list(/obj/item/toy/plush/skyrat/pintaplush))

/obj/item/toy/plush/skyrat/pintaplush
	name = "smaller deer plushie"
	desc = "Um cervine do tamanho de uma cerveja com um olhar vago."
	icon_state = "plushie_pinta"
	attack_verb_continuous = list("bonks", "snugs")
	attack_verb_simple = list("bonk", "snug")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/slime_squish.ogg' = 1)
	young = TRUE //No.

/obj/item/toy/plush/skyrat/szaplush
	name = "suspicious spider"
	desc = "Uma pelúcia de um drider tímido, colorido em cinza."
	icon_state = "plushie_sza"
	attack_verb_continuous = list("scuttles", "chitters", "bites")
	attack_verb_simple = list("scuttle", "chitter", "bite")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/spiderplush.ogg' = 1)
	young = TRUE //No.

/obj/item/toy/plush/skyrat/riffplush
	name = "valid plushie"
	desc = "Um brinquedo de pelúcia na semelhança de um demoníaco peculiar. Provavelmente se transformou em uma pelúcia para vender isso. Eles parecem muito bem sobre isso."
	icon_state = "plushie_riffy"
	attack_verb_continuous = list("slaps", "challenges")
	attack_verb_simple = list("slap", "challenge")
	squeak_override = list('sound/items/weapons/slap.ogg' = 1)

/obj/item/toy/plush/skyrat/ian
	name = "plush corgi"
	desc = "Um corgi adorável! Você não quer apenas abraçá-lo, apertar e chamá-lo\"Ian.\"?"
	icon_state = "ianplushie"
	attack_verb_continuous = list("barks", "woofs", "wags his tail at")
	attack_verb_simple = list("lick", "nuzzle", "bite")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/bark2.ogg' = 1)
	young = TRUE //No.

/obj/item/toy/plush/skyrat/ian/small
	name = "small plush corgi"
	desc = "Um corgi adorável! Você não quer apenas abraçá-lo, apertar e chamá-lo\"Ian.\"?"
	icon_state = "corgi"

/obj/item/toy/plush/skyrat/ian/lisa
	name = "plush girly corgi"
	desc = "Um corgi adorável! Você não quer apenas abraçá-lo, apertar e chamá-lo\"Lisa.\"?"
	icon_state = "girlycorgi"
	attack_verb_continuous = list("barks", "woofs", "wags her tail at")
	gender = FEMALE

/obj/item/toy/plush/skyrat/cat
	name = "cat plushie"
	desc = "Um pequeno gato de pelúcia com olhos pretos."
	icon_state = "blackcat"
	attack_verb_continuous = list("cuddles", "meows", "hisses")
	attack_verb_simple = list("cuddle", "meow", "hiss")
	squeak_override = list('modular_zubbers/sound/voice/merowr.ogg' = 1)

/obj/item/toy/plush/skyrat/cat/tux
	name = "tux cat plushie"
	icon_state = "tuxedocat"

/obj/item/toy/plush/skyrat/cat/white
	name = "white cat plushie"
	icon_state = "whitecat"

/obj/item/toy/plush/skyrat/seaduplush
	name = "sneed plushie"
	desc = "Uma fantasia de um particular, empacotado IPC. Debaixo do manto, você pode ver uma recriação do sabre do capitão."
	icon_state = "plushie_seadu"
	attack_verb_continuous = list("beeps", "sneeds", "swords")
	attack_verb_simple = list("beep", "sneed", "sword")
	squeak_override = list('sound/machines/synth/synth_no.ogg' = 1,'sound/machines/synth/synth_yes.ogg' = 1)

/obj/item/toy/plush/skyrat/lizzyplush
	name = "odd yoga lizzy plushie"
	desc = "O Programa Nanotrasen Wellness é o Yoga Odd Lizzy! Ele cheira vagamente a mirtilos, e provavelmente se parece com um amante horrível."
	icon_state = "plushie_lizzy"
	attack_verb_continuous = list("wehs")
	attack_verb_simple = list("weh")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/weh.ogg' = 1)

/obj/item/toy/plush/skyrat/mechanic_fox
	name = "mechanist fox plushie"
	desc = "Uma raposa com um cabelo fabuloso! Tem a tendência de fazer synth pelúcias parecerem novas quando colocadas ao lado delas."
	icon_state = "plushie_cali"
	attack_verb_continuous = list("fixes", "updates", "hugs")
	attack_verb_simple = list("fix", "update", "hug")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

/obj/item/toy/plush/skyrat/tribal_salamander
	name = "tribal salamander plushie"
	desc = "Um plushie seguro de água que sempre parece perder qualquer roupa que você tenta colocar nele."
	icon_state = "plushie_azu"
	attack_verb_continuous = list("wurbles at", "warbles at")
	attack_verb_simple = list("wurbles at", "warbles at")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/wurble.ogg' = 1)

/obj/item/toy/plush/skyrat/commanding_teshari
	name = "commanding teshari plushy"
	desc = "Uma pelúcia muito suave que se assemelha a um certo amante da ciência, comando inclinado Teshari. Segurar faz você se sentir bem."
	icon_state = "plushie_alara"
	attack_verb_continuous = list("peeps", "wurbles", "hugs")
	attack_verb_simple = list("peeps", "wurbles", "hugs")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/peep_once.ogg' = 1)

/obj/item/toy/plush/skyrat/breakdancing_bird
	name = "breakdancing bird plushie"
	desc = "Este pequeno pássaro robótico adora dar-lhe uma pequena dança em celebração de suas conquistas, não importa o quão mundano."
	icon_state = "plushie_cadicus"
	attack_verb_continuous = list("boops", "dances next to")
	attack_verb_simple = list("boop", "dance next to")
	squeak_override = list('sound/machines/ping.ogg' = 1)

/obj/item/toy/plush/skyrat/skreking_vox
	name = "skreking vox plushie"
	desc = "Uma plushie vox que parece pronta para apontar uma arma para você e exigir seu dinheiro! Há rumores de que se você cutucá-lo de uma forma específica, ele vai mostrar-lhe sua técnica skrektual."
	icon_state = "plushie_toko"
	attack_verb_continuous = list("rustles at", "threatens", "skreks at")
	attack_verb_simple = list("rustle at", "threaten", "skrek at")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/voxrustle.ogg' = 1)

/obj/item/toy/plush/skyrat/blue_dog
	name = "blue dog plushie"
	desc = "Um desonesta que parece está implorando por headpats. Cheira um mirtillos."
	icon_state = "plushie_cobalt"
	attack_verb_continuous = list("barks at", "borks at", "woofs at")
	attack_verb_simple = list("bark at", "bork at", "woof at")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/bark1.ogg'=1, 'modular_skyrat/modules/emotes/sound/voice/bark2.ogg'=1)

/obj/item/toy/plush/skyrat/engi_snek
	name = "engineering snek plushie"
	desc = "Essa peluche parece saber a diferença entre bombas e tubos! O braço é destacável, então não o perca!"
	icon_state = "plushie_tyri"
	attack_verb_continuous = list("fixes", "unbolts", "welds")
	attack_verb_simple = list("fix", "unbolt", "weld")
	squeak_override = list('sound/items/tools/screwdriver.ogg' = 1, 'sound/items/tools/drill_use.ogg' = 1, 'sound/items/tools/welder.ogg' = 1)

/obj/item/toy/plush/skyrat/glitch_synth
	name = "glitching synthetic plushie"
	desc = "Uma pelúcia sintética, a interface parece falhar toda vez que você dá um abraço ou chama de fofo!"
	icon_state = "plushie_rex"
	attack_verb_continuous = list("beeps", "hugs", "health analyzes")
	attack_verb_simple = list("beep", "hug", "health analyze")
	squeak_override = list('sound/machines/beep/twobeep_high.ogg' = 1)

/obj/item/toy/plush/skyrat/boom_bird
	name = "boom bird plushie"
	desc = "Este passarinho pode parecer um nerd, mas você suspeita que pode ser válido! Por que sua pele começa a brilhar quando a abraça?"
	icon_state = "plushie_dima"
	attack_verb_continuous = list("punches", "explodes on", "peeps")
	attack_verb_simple = list("punch", "explode on", "peep")
	squeak_override = list('sound/machines/sm/accent/delam/1.ogg' = 1)

/obj/item/toy/plush/skyrat/blue_cat
	name = "blue cat plushie"
	desc = "Um gato azul brilhante com cabelo rosa neon, aqui para dar beijos onde os beijos precisarem. Normalmente encontrado perto de seu habitat, o bonde."
	icon_state = "plushie_skyy"
	attack_verb_continuous = list("kisses", "nuzzles", "cuddles", "purrs against")
	attack_verb_simple = list("kiss", "nuzzle", "cuddle", "purr against")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/nya.ogg' = 1)

/obj/item/toy/plush/skyrat/igneous_synth
	name = "igneous synth plushie"
	desc = "Não é feito de rocha ígnea, dar um abraço a essa pelúcia vai te deixar sentir como se estivesse sendo espremido pelas mandíbulas da vida!"
	icon_state = "plushie_granite"
	attack_verb_continuous = list("bleps", "SQUEEZES", "pies")
	attack_verb_simple = list("blep", "SQUEEZE", "pie")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/twobeep.ogg' = 1)

/obj/item/toy/plush/skyrat/edgy_bird
	name = "edgy birb plushie"
	desc = "Um pássaro nervoso. Você pode jurar que está se teletransportando para um lugar diferente toda vez que você olha para o outro lado..."
	icon_state = "plushie_koto"
	attack_verb_continuous = list("pecks", "teleports behind", "caws at")
	attack_verb_simple = list("peck", "teleport behind", "caw at")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/caw.ogg' = 1)

/obj/item/toy/plush/skyrat/fox/mia
	name = "silver fox plushie"
	desc = "Uma pequena raposa de prata recheada com um colarinho que diz \"Eavy.\"e um pequeno sino em sua causa má."
	icon_state = "miafox"

/obj/item/toy/plush/skyrat/fox/kailyn
	name = "teasable fox plushie"
	desc = "Uma megera familiar em um traje de pacificador, perfeito para todos que pretendem aventurar-se no escuro sozinhos! Tem uma etiqueta que diz para não bater no nariz."
	icon_state = "teasefox"
	attack_verb_continuous = list("sneezes on", "detains", "tazes")
	attack_verb_simple = list("sneeze on", "detain", "taze")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/female/female_sneeze.ogg' = 1)

/obj/item/toy/plush/skyrat/xixi
	name = "familiar looking harpy plushie"
	desc = "Uma pelúcia retratando uma harpia brilhante e estranhamente familiar! A etiqueta no verso lista informações do distribuidor e uma tagline dizendo como vai adicionar um pouco de 'skree' ao seu trabalho diário."
	icon_state = "plushie_xixi"
	attack_verb_continuous = list("caws", "skrees", "pecks")
	attack_verb_simple = list("caw", "skree", "peck")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/peep_once.ogg' = 1,'modular_skyrat/modules/emotes/sound/voice/caw.ogg' = 1,'modular_skyrat/modules/emotes/sound/voice/bawk.ogg' = 1,'modular_skyrat/modules/emotes/sound/emotes/voxscream.ogg' = 1)

/obj/item/toy/plush/skyrat/zapp
	name = "Lil' Zapp"
	desc = "Um autêntico pedaço de mercadoria Pwr Game! Este companheiro fofinho é o ornamento perfeito para decorar sua batalha. Ele fica sentado sem assistência, e pode segurar seu fone, webcam, ou manter seu jogo Pwr seguro. Este está equipado com um leitor de habilidades de última geração, aperte-o bem e Zapp dirá se estiver pronto para o próximo grande jogo!"
	icon_state = "plushie_zapp"
	attack_verb_continuous = list("boops", "nuzzles")
	attack_verb_simple = list("boop", "nuzzle")
	squeak_override = list('sound/items/can/can_open1.ogg' = 1, 'sound/items/can/can_open2.ogg' = 1, 'sound/items/can/can_open3.ogg' = 1)
	///the list that is chosen from depending on gaming skill
	var/static/list/skill_response = list(
		"Weak! What are you, a mobile gamer?",
		"Come on, you can do better than that! Play some Orion Trial and try again.",
		"Hey, not bad! Try and work on your APM.",
		"Nice! You should see about competing in some local tournaments, gamer!",
		"Now that's real skill! I think you deserve some Pwr Game.",
		"Gamer God in the house! Look upon them and weep, console peasants!",
		"Whoa! Gamer overload! Stand clear!!",
	)
	///the list that is chosen from when it hits a human or is hit by something
	var/static/list/hit_response = list(
		"Hey, watch the mohawk!",
		"Easy, I earn my livin' with this face!",
		"Oof, I think my resale value just went down...",
		"This jacket isn't armored, you know!",
		"I'm a collectible! You can't treat me like this!",
		"Cut it out, or I'm telling chat!",
	)

/obj/item/toy/plush/skyrat/zapp/attackby(obj/item/attacking_item, mob/living/user, params)
	. = ..()
	say(pick(hit_response))

/obj/item/toy/plush/skyrat/zapp/attack(mob/living/target, mob/living/user, params)
	. = ..()
	say(pick(hit_response))

/obj/item/toy/plush/skyrat/zapp/attack_self(mob/user)
	. = ..()
	var/turf/src_turf = get_turf(src)
	playsound(src_turf, 'sound/items/drink.ogg', 50, TRUE)
	var/skill_level = user.mind.get_skill_level(/datum/skill/gaming)
	if(user.ckey == "cameronlancaster")
		skill_level = (max(6, skill_level))
	say(skill_response[skill_level])
	if(skill_level == 7)
		playsound(src_turf, 'sound/items/can/can_pop.ogg', 80, TRUE)
		new /obj/effect/abstract/liquid_turf/pwr_gamr(src_turf)
		playsound(src_turf, 'sound/effects/bubbles/bubbles.ogg', 50, TRUE)
		qdel(src)

/obj/effect/abstract/liquid_turf/pwr_gamr
	///the starting temp for the liquid
	var/starting_temp = T20C
	///the starting mixture for the liquid
	var/list/starting_mixture = list(/datum/reagent/consumable/pwr_game = 10)

/obj/effect/abstract/liquid_turf/pwr_gamr/Initialize(mapload)
	. = ..()
	reagent_list = starting_mixture
	total_reagents = 0
	for(var/key in reagent_list)
		total_reagents += reagent_list[key]
	temp = starting_temp
	calculate_height()
	set_reagent_color_for_liquid()

/obj/item/toy/plush/skyrat/rubi
	name = "huggable bee plushie"
	desc = "Isso te lembra uma abelha muito, muito, muito abraçável."
	icon_state = "plushie_rubi"
	gender = FEMALE
	squeak_override = list('sound/items/weapons/thudswoosh.ogg' = 1)
	attack_verb_continuous = list("hugs")
	attack_verb_simple = list("hug")

/obj/item/toy/plush/skyrat/rubi/attack_self(mob/user)
	. = ..()
	user.changeNext_move(CLICK_CD_MELEE) // To avoid spam, in some cases (sadly not all of them)
	var/mob/living/living_user = user
	if(istype(living_user))
		living_user.add_mood_event("hug", /datum/mood_event/warmhug/rubi, src)
	user.visible_message(span_notice("[user]Abraços\the [src]."), span_notice("Você se abraça.\the [src]."))

/datum/mood_event/warmhug/rubi
	description = span_nicegreen("Abraços aconchegantes são os melhores!")
	mood_change = 0
	timeout = 2 MINUTES

/obj/item/toy/plush/skyrat/roselia
	name = "obscene sergal plushie"
	desc = "Uma recriação de um sergal rosa. O peito é extremamente acolchoado e as pequenas roupas de pelúcia mal estão se segurando."
	icon_state = "plushie_roselia"
	attack_verb_continuous = list("hugs")
	attack_verb_simple = list("hug")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/merp.ogg' = 1)
	young = FALSE

/obj/item/toy/plush/skyrat/chunko
	name = "chunko fop"
	desc = "Uma criatura sem alma que assombra seus sonhos."
	icon_state = "plushie_pfbonnie"
	var/responses = list("Do you fear death? Do you fear the world you live in? What 'God's so called infinite mercy is? A neverending life of constant and unending misery. Being forced to work and go on as millions, trillions suffer around you as you are either too powerless or too lazy to do anything? Is this worth living? Capitalism in overdrive, life in hell. Why?", "Hi!!", )
	COOLDOWN_DECLARE(chunko_cooldown)

/obj/item/toy/plush/skyrat/chunko/attackby()
	. = ..()
	if(!COOLDOWN_FINISHED(src, chunko_cooldown))
		return
	say(pick(responses))
	COOLDOWN_START(src, chunko_cooldown, 2 SECONDS)

/obj/item/toy/plush/skyrat/chunko/attack()
	. = ..()
	if(!COOLDOWN_FINISHED(src, chunko_cooldown))
		return
	say(pick(responses))
	COOLDOWN_START(src, chunko_cooldown, 2 SECONDS)

/obj/item/toy/plush/skyrat/chunko/bonnie
	name = "chunko fop blue bunny"
	desc = "Uma garota\"adorável\", se de olhos grandes. Este é azul. Produzido pela Companhia Chunko Fop<b><i>TM</i></b>Cuspa vários fatos Rabbit de validade duvidosa."
	icon_state = "plushie_pfbonnie"
	gender = FEMALE
	attack_verb_continuous = list("pats", "hugs", "scolds", "pets")
	attack_verb_simple = list("pat", "hug", "scold", "pet")
	squeak_override = list('sound/mobs/non-humanoids/mouse/mousesqueek.ogg' = 1, 'modular_zubbers/sound/emotes/mothsqueak.ogg' = 1,)
	responses = list("Rabbits are prey animals and are therefore constantly aware of their surroundings.", "Things to jump up on (they like to be in high places)", "become a rabbit today!", "Be cunning and full of tricks...", "Subscription confirmed! Thank you for choosing RABBITFACTS +TM+!", "Holland Lops are a breed of rabbit originating in the Netherlands.", "Rabbits may need medication to keep themselves healthy, and that's ok! Make sure to take yours too!", "rabbits really liked this product", "A healthy rabbit diet includes fresh vegetables.", "Rabbits do not hibernate. Their schedules are much too busy.", "the rate of bunnies is measured by RPB (rabbits per bunny)", )

/obj/item/toy/plush/skyrat/chunko/andrew
	name = "chunko fop green and orange bunny"
	desc = "Uma garota\"adorável\", se de olhos grandes. Este é verde e laranja. Produzido pela Companhia Chunko Fop<b><i>TM</i></b>Cospe vários coelhos de existência duvidosa."
	icon_state = "plushie_pfandrew"
	gender = MALE
	attack_verb_continuous = list("pats", "hugs", "scolds", "pets")
	attack_verb_simple = list("pat", "hug", "scold", "pet")
	squeak_override = list('sound/mobs/non-humanoids/mouse/mousesqueek.ogg' = 1, 'modular_zubbers/sound/emotes/mothsqueak.ogg' = 1,)
	// All lowercase messages are intentional
	responses = list("bunny who you best pray you never encounter, lest you suffer a fate worse than death.", "this is a bunny!", "I wonder what would happen if you took bunnies, and combined them with rabbits, and merged their properties and characteristics. It's something to think about.", "If you're cold, they're cold. Give them the deed to your house.", "bunny that goes yeah! woo! yeah! woo! yeah! woo! yeah! woo! yeah! woo! yeah!", "the bunnies are beyond my comprehension", "it's a bunny thing, you wouldn't get it", "this bunny has an unfathomable power level", "%pull the string and I'll bink at you...I'm your bunny.", "Bunny (1954)", "the bunny that pulls the strings....", )

/obj/item/toy/plush/skyrat/chunko/inessa
	name = "chunko fop medical bear"
	desc = "Uma mulher de urso\"adorável\" e cansada. Este produz fumaça falsa! Produzido pela Companhia Chunko Fop<b><i>TM</i></b>Cospe vários fatos médicos com uma caixa de voz quebrada."
	icon_state = "plushie_pfinessa"
	gender = FEMALE
	attack_verb_continuous = list("slashes", "dissects", "yawns", "smokes")
	attack_verb_simple = list("slash", "dissect", "yawn", "smoke")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/female/female_cough_3.ogg' = 1, 'modular_skyrat/modules/emotes/sound/emotes/female/female_cough_2.ogg' = 1, 'modular_skyrat/modules/emotes/sound/emotes/female/female_cough_1.ogg' = 1)
	responses = list("The human body can survive three weeks without skiiiiiiiiiiin.", "The thigh bone is connected to the hip boooooooooone.", "Yeeeessss?", "Helloooooo.", "Don't be such a baby, ribs grow baaaaaaaaaack.",)

// Donation reward for shyshadow
/obj/item/toy/plush/skyrat/chunko/plushie_winrow
	name = "dark and brooding lizard plush"
	desc = "Um lagarto preto quase intimidante pelúcia, este tem uma pequena boina para vir com ele! Melhor não separar os dois. Seus olhos brilham com sugestão, sem donzelas?"
	icon_state = "plushie_shyshadow"
	gender = MALE
	attack_verb_continuous = list("slashes", "bites", "rizzes")
	attack_verb_simple = list("slash", "bite", "rizz")
	responses = list("Am I looking in a mirror? Because what I see is beautiful.", "I'm not just a toy. I'm a romantic.", "I'm the diamond, and you're the rough because sooner or later...", "Is that mouth just for talking?", "Come on, don't be so hard on me. I'm so soft!", "Is that a glass of scotch? Because I've been thinking about buttering you up.", "Don't look stare for too long. You might get lost in my eyes.", "Oh wow! Looks like I'm not the only handsome thing around these parts.", "Do NOT the plushie. I am not a voodoo doll.",)

// Donation reward for tobjv
/obj/item/toy/plush/skyrat/tesh
	name = "Squish-Me-Tesh"
	desc = "Vencedor de ser transformado em um Plushy pela PalhaçoCo!"
	icon_state = "plushie_tobjv2"

// Donation reward for tobjv
/obj/item/toy/plush/skyrat/immovable_rod
	name = "immovable rod"
	desc = "Realista! Mas também mole e certamente não tão perigoso quanto sua verdadeira contraparte."
	icon_state = "plushie_tobjv"

/obj/item/toy/plush/skyrat/immovable_rod/Bump(atom/clong)
	. = ..()
	if(isliving(clong))
		playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
		return

// Donation reward for gamerguy14948
/obj/item/toy/plush/skyrat/voodoo
	name = "voodoo doll"
	desc = "Uma boneca de vodu não tão pequena feita de sacos de batata cortados e costurados. Quase parece bonito."
	icon_state = "plushie_gamerguy"

// Donation reward for Dudewithatude
/obj/item/toy/plush/skyrat/plushie_star
	name = "star angel plush"
	desc = "O plushie de um celestial no universo sabecido."
	icon_state = "plushie_star"
	gender = FEMALE
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/trills.ogg' = 1)

// Donation reward for SRQ
/obj/item/toy/plush/skyrat/plushie_chiara
	name = "commanding fox plush"
	desc = "Uma grande raposa empalhada que irradia confiança e vigor de seus olhos de esmeralda."
	icon_state = "plushie_chiara"

// Donation reward for Superlagg
/obj/item/toy/plush/skyrat/plushie_dan
	name = "comfy fox plush"
	desc = "Uma raposa de pelúcia com uma aura de carinho vazando de seu exterior macio."
	icon_state = "plushie_dan"

//Donation reward for KLB100
/obj/item/toy/plush/skyrat/fox/plushie_jeanne
	name = "masked roboticist plushie"
	desc = "Um Vulpkanin branco de neve familiar. Este parece estar usando uma máscara ocultando seu rosto."
	icon_state = "plushie_jeanne"
	attack_verb_continuous = list("cuddles", "squishes", "blushes")
	attack_verb_simple = list("cuddle", "squish", "blush")

//Donation reward for Dalao Azure
/obj/item/toy/plush/skyrat/plushie_azyre
	name = "handsome chef plushie"
	desc = "A necessidade de cozinhar só rivaliza com uma fome de cauda de raposa."
	icon_state = "plushie_azyre"

//Donation reward for Razurath
/obj/item/toy/plush/skyrat/plushie_razurath
	name = "science shark plushie"
	desc = "Um cientista determinado com uma pitada de travessura em seu sorriso."
	icon_state = "plush_scishark"
	attack_verb_continuous = list("bites", "eats", "fin slaps")
	attack_verb_simple = list("bite", "eat", "fin slap")
	squeak_override = list('sound/items/weapons/bite.ogg'=1)

//Other donation reward for Razurath
/obj/item/toy/plush/skyrat/plushie_razurath/second
	name = "dwarf shark plushie"
	desc = "Apesar de sua altura, a pelúcia o vê com olhos aguçados e francamente desconcertados, o olhar em seu rosto, e a elegância de seu pequeno casaco lhe dizem que ela sabe algo que você não sabe."
	icon_state = "plushie_nedilla"

//Donation reward for October23
/obj/item/toy/plush/skyrat/plushie_elofy
	name = "bumbling wolfgirl plushie"
	desc = "Uma lobinha de cabelos brancos com uma elegante saia de segurança vermelha. Apesar de seu assustador braço cibernético, ela é macia para abraçar e só deseja ser elogiada e confortada."
	icon_state = "plush_lonie"
	attack_verb_continuous = list("snuggles", "nibbles", "awoos", "tail whaps")
	attack_verb_simple = list("snuggle", "nibble", "awoo", "tail whap")
	squeak_override = list('modular_zubbers/sound/voice/merowr.ogg' = 1)

//Donation reward for syntax1112
/obj/item/toy/plush/skyrat/plushie_syntax1112
	name = "lop bunny plushie"
	desc = "Um coelho de orelhas moles em forma de pelúcia. Completo com um dispositivo de auto-inflação interna!"
	icon_state = "fuzz_bunny"
	attack_verb_continuous = list("nibbles", "squeaks", "nose twitches", "thumps", "whops")
	attack_verb_simple = list("nibble", "squeak", "nose twitch", "thump", "whop")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/deerplush.ogg' = 1)

// Donation reward for SomeRandomOwl
/obj/item/toy/plush/skyrat/snow_owl
	name = "snowy owl plush"
	desc = "Uma pelúcia muito macia parecida com uma pluma e bruxa como coruja que é conhecida por frequentar ciência e medicina."
	icon_state = "plushie_owl"
	attack_verb_continuous = list("hoots", "screms", "hugs")
	attack_verb_simple = list("hoot", "screm", "hug")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/hoot.ogg' = 1)

// Donation reward for Jolly66
/obj/item/toy/plush/skyrat/derg_plushie
	name = "wingless dragon plush"
	desc = "Um lindo dragão verde e amarelo sem asas! Se vale de algo, tem uma cauda cômica. Vem com um boné de paramédico adicional."
	icon_state = "plushie_derg"
	attack_verb_continuous = list("wehs", "wehs softly", "stutters")
	attack_verb_simple = list("weh", "weh softly", "stutter")
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/weh.ogg' = 1)

// Donation reward for Gofawful5
/obj/item/toy/plush/skyrat/tracy
	name = "creature plushie"
	desc = "Um catfox super bem-dotado... Parece satisfeito."
	icon_state = "plush_tracy"
	attack_verb_continuous = list("expands")
	attack_verb_simple = list("expand")
	squeak_override = list('modular_skyrat/modules/customization/game/objects/items/sound/tracymrowr.ogg' = 1)
	gender = FEMALE

//Donation reward for Frixit
/obj/item/toy/plush/skyrat/plushie_synthia
	name = "adventurous synth plushie"
	desc = "Esta pelúcia é perfeita para aventuras no espaço e na cama, um sintético roxo fofinho, seu cachecol é extra macio!"
	icon_state = "plushie_synthia"
	attack_verb_continuous = list("blushes", "hugs", "whips")
	attack_verb_simple = list("blush", "hug", "whip")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/twobeep.ogg' = 1)

//Donation reward for Kitsun
/obj/item/toy/plush/skyrat/jecca
	name = "sexy snoodle plushie"
	desc = "Por alguma razão, esta plushie é bastante brilhante, com brilhantes, escalas brilhantes, e seus olhos rubi coloridos parecem ser bastante atraente e cheio de pensamentos travessos e lascivos atrás deles."
	icon_state = "plushie_jecca"
	attack_verb_continuous = list("sighs")
	attack_verb_simple = list("sigh")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/female/female_sigh.ogg' = 1)
	gender = FEMALE

//Donation reward for BriareosBlue
/obj/item/toy/plush/skyrat/courier_synth
	name = "courier synth plushie"
	desc = "Este synth plushie parece pronto para dar abraços e bips direto para o coração! A etiqueta parece ter um anúncio para uma empresa de entrega..."
	icon_state = "plushie_courier"
	attack_verb_continuous = list("delivers", "export scans", "dwoops", "bwuhs", "stamps")
	attack_verb_simple = list("deliver", "export scan", "dwoop", "bwuh", "stamp")
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/twobeep.ogg' = 1)

//Donation reward for olirant
/obj/item/toy/plush/skyrat/plush_janiborg
	name = "Friendly Janiborg Plush"
	desc = "Um brinquedo omnidroid em miniatura direto do departamento de marketing da Lockstep Enterprises Corporation, em roxo bonito. Agora com ação esguichada de verdade!"
	icon_state = "plush_janiborg"
	attack_verb_continuous = list("beeps", "washes", "mops", "squirts", "soaps")
	attack_verb_simple = list("beep", "wash", "mop", "squirt", "soap")
	squeak_override = list('sound/machines/beep/twobeep.ogg' = 1)
