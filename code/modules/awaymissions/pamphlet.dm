/obj/item/paper/pamphlet
	name = "pamphlet"
	icon_state = "pamphlet"
	show_written_words = FALSE

/obj/item/paper/pamphlet/radstorm
	name = "pamphlet - \'Radstorm Safety Measures and How to Not Become Monkey\'"
	default_raw_text = "O alarme de segurança de radstorm da sua estação disparou e você não vê uma escotilha de manutenção próxima para escapar? Não tema, porque NT realmente pensa em tudo!\
Vários abrigos de acesso público foram instalados ao redor da estação superior com o propósito expresso de proteger seus frágeis pedaços de carne de se tornar o próximo desastre médico!\
Por favor, veja a subseção 4.3 V2-3 em seu manual de funcionários para procedimentos apropriados para lidar com danos excessivos à radiação se você não chegar a um abrigo a tempo."


/obj/item/paper/pamphlet/violent_video_games
	name = "pamphlet - \'Violent Video Games and You\'"
	desc = "Um panfleto encorajando o leitor a manter um estilo de vida equilibrado e cuidar de sua saúde mental, enquanto ainda desfruta de vídeo games de uma forma saudável. Você provavelmente não precisa disso..."
	default_raw_text = "Eles não fazem você matar pessoas. Pronto, já dissemos. Agora volte ao trabalho!"

/obj/item/paper/pamphlet/gateway
	default_raw_text = "<b>Bem-vindos ao projeto Nanotrasen Gateway...</b><br>\
Parabéns! Se você está lendo isso, você e seus superiores decidiram que você é\
Pronto para se comprometer com uma vida passada colonizando as colinas de mundos distantes. Você.\
deve estar pronto para uma vida de aventura, um pouco de trabalho duro, e um prêmio\
Mas isso não é tudo que o projeto Nanotrasen Gateway tem a oferecer.<br>\
			<br>Porque nos importamos com você, achamos que é justo ter certeza de que você sabe os riscos.\
Antes de se comprometer a se juntar ao projeto Nanotrasen Gateway. Todos os destinos distantes têm\
foi totalmente escaneado por uma equipe expedicionária Nanotrasen, e são certificados para ser 100% seguro.\
Até deixamos uma caixa de cerveja espacial junto com os materiais básicos que precisa expandir.\
A área operacional de Nanotrasen e começar sua nova vida.<br><br>\
			<b>Operação do Portal Básico</b><br>\
Todas as Gateways aprovadas por Nanotrasen operam nos mesmos princípios básicos. Eles operam\
E sem esse suprimento, não pode funcionar com segurança.\
Causá-lo para rejeitar todas as tentativas de operação.<br><br>\
Uma vez que esteja corretamente montado, e uma vez que tenha energia suficiente para operar, o portal começará.\
procurando um local de saída. O tempo que isso leva é variável, mas o portal\
A interface lhe dará uma estimativa exata até o minuto. A perda de energia não vai interromper.\
processo de busca. Influenza não vai interromper o processo de busca. Anomalias temporais\
Pode fazer com que a estimativa seja incorreta, mas não interromperá o processo de busca.<br><br> \
			<b>A vida do outro lado</b><br>\
Uma vez atravessado o portal, você pode experimentar alguma desorientação. Não entre em pânico.\
Este é um efeito colateral normal de viajar grandes distâncias em um curto período de tempo. Você deveria.\
Pesquise a área imediata, e tente localizar sua caixa de cerveja espacial. Nossa.\
Equipes expedicionárias garantiram a total segurança de todos os locais distantes, mas em um pequeno\
Número de casos, o portal que eles estabeleceram pode não ser imediatamente óbvio.\
Não entre em pânico se não conseguir localizar o portal de retorno. Comece a colonização do destino.\
			<br><br><b>Um Novo Mundo</b><br>\
Como participante do Projeto Nanotrasen Gateway, você estará nas fronteiras do espaço.\
Embora a segurança total esteja assegurada, os participantes são aconselhados a se preparar para o inóspito\
Environs."

/obj/item/paper/pamphlet/cybernetics
	name = "pamphlet - 'Synthman's Cybernetic Starter Gear!'"
	default_raw_text = "Junte-se à Revolução do Corpo Modder hoje! Estamos oferecendo amostras gratuitas das mais recentes e maiores\
cybernetic aumenta por Synthman Co. para você nesta rara oferta exclusiva! Com esta carta, você está sendo dotado de\
Edição limitada especial escolha NTSDA certificado grau um implante cibernético, livre de carga! Construir seu corpo para\
GRANDE COM A nova linha exclusiva de produtos cibernéticos do Synthman! Torne-se maior, mais forte e melhor hoje!"
	var/obj/item/organ/heart/cybernetic/sample

/obj/item/paper/pamphlet/cybernetics/Initialize(mapload)
	. = ..()
	sample = new(src)
	update_desc()

/obj/item/paper/pamphlet/cybernetics/update_desc(updates)
	. = ..()
	desc = "A pamphlet encouraging the reader to implant themselves.[sample ? " Has an attached \"sample\"..." : ""]"

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
