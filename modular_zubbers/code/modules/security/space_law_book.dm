/// The size of the window that the wiki books open in.
#define BOOK_WINDOW_BROWSE_SIZE "970x710"

#define WIKI_PAGE_IFRAME(wikiurl, link_identifier) {"
	<html>
	<head>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<style>
		iframe {
			display: none;
		}
	</style>
	</head>
	<body>
	<script type="text/javascript">
		function pageloaded(myframe) {
			document.getElementById("loading").style.display = "none";
			myframe.style.display = "inline";
	}
	</script>
	<p id='loading'>You start skimming through the manual...</p>
	<iframe width='100%' height='97%' onload="pageloaded(this)" src="[##wikiurl]/[##link_identifier]&remove_links=1" frameborder="0" id="main_frame"></iframe>
	</body>
	</html>
	"}



/obj/item/book/manual/wiki/security_space_law
	name = "Corporate Regulations"
	desc = "Um conjunto de regulamentos Nanotrasen para manter a lei, ordem e procedimento seguidos em suas estações espaciais."
	starting_title = "Corporate Regulations"
	page_link = "index.php?title=Space_Law"

/obj/item/book/manual/wiki/security_space_law/attack_self(mob/user) // Was in /tg/ folder, moved it here, made it 100% chance to learn language since you can spam it inhand anyhow. Saves us all from carpal tunnel.
	if(user.can_read(src) && !user.has_language(/datum/language/legalese, SPOKEN_LANGUAGE))
		to_chat(user, span_notice("Enquanto você inala o conteúdo do livro, você se sente mais sofisticado. Depois de ler a Lei Espacial apenas uma vez, você se sente como um especialista em fingir que sabe latim. Agora você pode falar Legalese."))
		user.grant_language(/datum/language/legalese, SPOKEN_LANGUAGE) //can speak but not understand
	else
		.=..()

/obj/item/book/manual/wiki/security_space_law/display_content(mob/living/user)
	var/wiki_url = "http://wiki.bubberstation.org"
	if(!wiki_url)
		user.balloon_alert(user, "Este livro está vazio!")
		return
	credit_book_to_reader(user)
	if(user.client.byond_version < 516) //Remove this once 516 is stable
		if(tgui_alert(user, "A página deste livro será aberta no seu navegador. Tem certeza?", "Open The Wiki", list("Yes", "No")) != "Yes")
			return
		DIRECT_OUTPUT(user, link("[wiki_url]/[page_link]"))
	else
		DIRECT_OUTPUT(user, browse(WIKI_PAGE_IFRAME(wiki_url, page_link), "window=manual;size=[BOOK_WINDOW_BROWSE_SIZE]")) // if you change this GUARANTEE that it works.

/obj/item/book/manual/wiki/security_space_law/weighted
	name = "Corporate Regulations: Collector's Edition"
	desc = "Um conjunto de diretrizes Nanotrasen para manter a lei e a ordem em suas estações espaciais. Este é bem pesado devido às suas páginas extras e capa de metal."
	icon = 'modular_zubbers/icons/obj/security_voucher.dmi'
	icon_state = "SpaceLawWeighted"
	force = 13
	throwforce = 13
	attack_verb_continuous = list("educates", "reprimands", "prosecutes", "teaches a lesson to")
	attack_verb_simple = list("educate", "reprimand", "prosecute", "remind","teach a lesson to")

/obj/item/book/manual/wiki/security_space_law/weighted/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(!isliving(target))
		return

	var/mob/living/living_target = target

	if(user == living_target)
		return

	if(living_target.stat == DEAD)
		return

	if(prob(10))
		living_target.grant_language(/datum/language/legalese, SPOKEN_LANGUAGE) //IMMA TEACH YOU A LESSON

#undef BOOK_WINDOW_BROWSE_SIZE
#undef WIKI_PAGE_IFRAME
