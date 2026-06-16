/obj/item/instrument/violin/festival
	name = "Cogitandi Fidis"
	desc = "Um violino que tem um interesse especial nas músicas tocadas a partir de suas cordas."
	icon_state = "holy_violin"
	inhand_icon_state = "holy_violin"

/obj/item/instrument/violin/festival/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_INSTRUMENT_START, PROC_REF(on_instrument_start))

/// signal fired when the festival instrument starts to play.
/obj/item/instrument/violin/festival/proc/on_instrument_start(datum/source, datum/song/starting_song, atom/player)
	SIGNAL_HANDLER

	if(!starting_song || !isliving(player))
		return
	analyze_song(starting_song, player)

///Reports some relevant information when the song begins playing.
/obj/item/instrument/violin/festival/proc/analyze_song(datum/song/song, mob/living/playing_song)
	var/list/analysis = list()
	//check tempo and lines
	var/song_length = song.lines.len * song.tempo
	analysis += span_revenbignotice("[src] Fala com você...")
	analysis += span_revennotice("\"Esta canção tem<b>[song.lines.len]</b>linhas e um ritmo de<b>[song.tempo]</b>.\"")
	analysis += span_revennotice("\"Multiplicar estes juntos dá uma música longa de<b>[song_length]</b>.\"")
	analysis += span_revennotice("\"Para obter um efeito bônus de [GLOB.deity] Ao terminar uma apresentação, você precisa de uma música longa de<b>[FESTIVAL_SONG_LONG_ENOUGH]</b>.\"")

	to_chat(playing_song, analysis.Join("\n"))
