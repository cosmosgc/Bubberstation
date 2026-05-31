/obj/structure/chess
	anchored = FALSE
	density = FALSE
	icon = 'icons/obj/toys/chess.dmi'
	icon_state = "white_pawn"
	name = "\improper Probably a White Pawn"
	desc = "Isso é estranho. Por favor, informe a administração sobre como conseguiu a peça de xadrez dos pais. Obrigado!"
	max_integrity = 100
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/structure/chess/wrench_act(mob/user, obj/item/tool)
	if(flags_1 & HOLOGRAM_1)
		balloon_alert(user, "Passa direto!")
		return TRUE
	to_chat(user, span_notice("Começa a desmontar a peça de xadrez."))
	if(!do_after(user, 0.5 SECONDS, target = src))
		return TRUE
	var/obj/item/stack/sheet/iron/metal_sheets = new (drop_location(), 2)
	if (!QDELETED(metal_sheets))
		metal_sheets.add_fingerprint(user)
	tool.play_tool_sound(src)
	qdel(src)
	return TRUE

/obj/structure/chess/whitepawn
	name = "\improper white pawn"
	desc = "Uma peça de xadrez de peão branco. Ser acusado de trapacear quando executar um En Passant doente."
	icon_state = "white_pawn"

/obj/structure/chess/whiterook
	name = "\improper white rook"
	desc = "Uma peça de xadrez de torre branca. Também conhecido como castelo. Pode mover qualquer número de peças em linha reta. Tem um movimento especial chamado casting."
	icon_state = "white_rook"

/obj/structure/chess/whiteknight
	name = "\improper white knight"
	desc = "Uma peça de xadrez de cavaleiro branco. Ele pode pular sobre outras peças, movendo-se em formas L. Um kni branco. Hah!"
	icon_state = "white_knight"

/obj/structure/chess/whitebishop
	name = "\improper white bishop"
	desc = "Uma peça de xadrez do bispo branco. Pode mover qualquer número de peças em uma linha diagonal."
	icon_state = "white_bishop"

/obj/structure/chess/whitequeen
	name = "\improper white queen"
	desc = "Uma peça de xadrez rainha branca. Ele pode mover qualquer número de azulejos em diagonais e linhas retas."
	icon_state = "white_queen"

/obj/structure/chess/whiteking
	name = "\improper white king"
	desc = "Uma peça de xadrez do rei branco. Pode mover um azulejo em qualquer direção."
	icon_state = "white_king"

/obj/structure/chess/blackpawn
	name = "\improper black pawn"
	desc = "Uma peça de xadrez de peão preto. Ser acusado de trapacear quando executar um En Passant doente."
	icon_state = "black_pawn"

/obj/structure/chess/blackrook
	name = "\improper black rook"
	desc = "Uma peça de xadrez preta. Também conhecido como castelo. Pode mover qualquer número de peças em linha reta. Tem um movimento especial chamado casting."
	icon_state = "black_rook"

/obj/structure/chess/blackknight
	name = "\improper black knight"
	desc = "Uma peça de xadrez cavaleiro negro. Ele pode pular sobre outras peças, movendo-se em formas L."
	icon_state = "black_knight"

/obj/structure/chess/blackbishop
	name = "\improper black bishop"
	desc = "Uma peça de xadrez de bispo negro. Pode mover qualquer número de peças em uma linha diagonal."
	icon_state = "black_bishop"

/obj/structure/chess/blackqueen
	name = "\improper black queen"
	desc = "Uma peça de xadrez rainha negra. Ele pode mover qualquer número de azulejos em diagonais e linhas retas."
	icon_state = "black_queen"

/obj/structure/chess/blackking
	name = "\improper black king"
	desc = "Uma peça de xadrez do rei negro. Pode mover um azulejo em qualquer direção."
	icon_state = "black_king"

/obj/structure/chess/checker
	icon_state = "white_checker_man"
	name = "\improper Probably a White Checker"
	desc = "Isso é estranho. Por favor, informe a administração sobre como conseguiu a peça de verificação dos pais. Obrigado!"

/obj/structure/chess/checker/whiteman
	name = "\improper White Checker Man"
	desc = "Um pedaço de cheque branco. Parece um peão de xadrez achatado."
	icon_state = "white_checker_man"

/obj/structure/chess/checker/whiteking
	name = "\improper White Checker Man"
	desc = "Uma peça de cheque branco. Está empilhado!"
	icon_state = "white_checker_king"

/obj/structure/chess/checker/blackman
	name = "\improper Black Checker Man"
	desc = "Uma peça preta. Parece um peão de xadrez achatado."
	icon_state = "black_checker_man"

/obj/structure/chess/checker/blackking
	name = "\improper Black Checker King"
	desc = "Uma peça preta. Está empilhado!"
	icon_state = "black_checker_king"
