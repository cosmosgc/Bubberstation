/obj/item/paper/pamphlet
	name = "pamphlet"
	icon_state = "pamphlet"
	show_written_words = FALSE

/obj/item/paper/pamphlet/radstorm
	name = "pamphlet - \'Radstorm Safety Measures and How to Not Become Monkey\'"
	default_raw_text = "O alarme de segurança de radstorm da sua estação disparou e você não vê uma escotilha de manutenção próxima para escapar? Não tema, porque NT realmente pensa em tudo! Vários abrigos de acesso público foram instalados ao redor da estação superior com o propósito expresso de proteger seus frágeis pedaços de carne de se tornar o próximo desastre médico! Por favor, veja a subseção 4.3 V2-3 em seu manual de funcionários para procedimentos apropriados para lidar com danos excessivos à radiação se você não chegar a um abrigo a tempo."


/obj/item/paper/pamphlet/violent_video_games
	name = "pamphlet - \'Violent Video Games and You\'"
	desc = "Um panfleto encorajando o leitor a manter um estilo de vida equilibrado e cuidar de sua saúde mental, enquanto ainda desfruta de vídeo games de uma forma saudável. Você provavelmente não precisa disso..."
	default_raw_text = "Eles não fazem você matar pessoas. Pronto, já dissemos. Agora volte ao trabalho!"

/obj/item/paper/pamphlet/gateway
	default_raw_text = "<b>Bem-vindo ao projeto Nanotrasen Gateway...</b><br>Parabéns! Se você está lendo isso, você e seus superiores decidiram que você está pronto para se comprometer com uma vida passada colonizando as colinas de mundos distantes. Você deve estar pronto para uma vida de aventura, um pouco de trabalho duro, e um plano odontológico premiado, mas isso não é tudo que o projeto Nanotrasen Gateway tem a oferecer.<br>			<br>Porque nos importamos com você, achamos que é justo ter certeza de que você sabe os riscos antes de se comprometer a se juntar ao projeto Nanotrasen Gateway. Todos os destinos fora foram totalmente escaneados por uma equipe expedicionária Nanotrasen, e estão certificados como 100% seguros. Até deixamos uma caixa de cerveja espacial junto com os materiais básicos que precisa para expandir a área operacional de Nanotrasen e começar sua nova vida.<br><br>			<b>Operação do Portal Básico</b><br>Todas as Gateways aprovadas por Nanotrasen operam nos mesmos princípios básicos. Eles operam fora da área de energia do equipamento como você esperaria, e sem este fornecimento, ele não pode funcionar com segurança, causando-o para rejeitar todas as tentativas de operação.<br><br>Uma vez que esteja corretamente configurado, e uma vez que tenha energia suficiente para operar, o Gateway começará a procurar um local de saída. O tempo que isso leva é variável, mas a interface do Gateway lhe dará uma estimativa exata até o minuto. A perda de energia não interromperá o processo de busca. Influenza não vai interromper o processo de busca. Anomalias temporais podem fazer com que a estimativa seja incorreta, mas não interromperão o processo de busca.<br><br> 			<b>A vida do outro lado</b><br>Uma vez atravessado o portal, você pode experimentar alguma desorientação. Não entre em pânico. Este é um efeito colateral normal de viajar grandes distâncias em um curto período de tempo. Você deve examinar a área imediata, e tentar localizar sua caixa de cerveja espacial. Nossas equipes expedicionárias garantiram a total segurança de todos os locais distantes, mas em um pequeno número de casos, o portal que eles estabeleceram pode não ser imediatamente óbvio. Não entre em pânico se não conseguir localizar o portal de retorno. Comece a colonização do destino.<br><br><b>Um Novo Mundo</b><br>Como participante do Projeto Nanotrasen Gateway, você estará nas fronteiras do espaço. Embora a segurança total esteja assegurada, os participantes são aconselhados a se preparar para ambientes inóspitos."

/obj/item/paper/pamphlet/cybernetics
	name = "pamphlet - 'Synthman's Cybernetic Starter Gear!'"
	default_raw_text = "Junte-se à Revolução do Corpo Modder hoje! Estamos oferecendo amostras gratuitas dos mais recentes e maiores aumentos cibernéticos da Synthman Co. para você nesta rara oferta exclusiva! Com esta carta, você está sendo dotado de uma edição limitada especial escolha NTSDA certificado grau um implante cibernético, livre de carga! Construa seu corpo com a nova linha exclusiva de produtos cibernéticos do Synthman! Torne-se maior, mais forte e melhor hoje!"
	var/obj/item/organ/heart/cybernetic/sample

/obj/item/paper/pamphlet/cybernetics/Initialize(mapload)
	. = ..()
	sample = new(src)
	update_desc()

/obj/item/paper/pamphlet/cybernetics/update_desc(updates)
	. = ..()
	desc = "Um panfleto encorajando o leitor a se implantar.[sample ? " Has an attached \"sample\"..." : ""]"

/obj/item/paper/pamphlet/cybernetics/Destroy()
	QDEL_NULL(sample)
	return ..()

/obj/item/paper/pamphlet/cybernetics/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == sample)
		sample = null
		update_desc()

/obj/item/paper/pamphlet/cybernetics/attack_self(mob/user, modifiers)
	. = ..()
	to_chat(user, span_notice("Ao ler o panfleto, uma amostra grátis cai!"))
	sample.forceMove(drop_location())
	playsound(sample, 'sound/misc/splort.ogg', 50, vary = TRUE)
