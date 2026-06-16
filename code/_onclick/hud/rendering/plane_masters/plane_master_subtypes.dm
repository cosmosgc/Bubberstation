/atom/movable/screen/plane_master/field_of_vision_blocker
	name = "Field of vision blocker"
	documentation = "Este é um dos planos que só é usado como filtro. Ele corta uma parte da placa do jogo e aplica efeitos nela."
	plane = FIELD_OF_VISION_BLOCKER_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_target = FIELD_OF_VISION_BLOCKER_RENDER_TARGET
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_planes = list()
	// We do NOT allow offsetting, because there's no case where you would want to block only one layer, at least currently
	offsetting_flags = BLOCKS_PLANE_OFFSETTING
	// We mark as multiz_scaled FALSE so transforms don't effect us, and we draw to the planes below us as if they were us.
	// This is safe because we will ALWAYS be on the top z layer, so it DON'T MATTER
	multiz_scaled = FALSE
/atom/movable/screen/plane_master/field_of_vision_blocker/show_to(mob/mymob)
	. = ..()
	if(!. || !mymob)
		return .
	RegisterSignal(mymob, SIGNAL_ADDTRAIT(TRAIT_FOV_APPLIED), PROC_REF(fov_enabled), override = TRUE)
	RegisterSignal(mymob, SIGNAL_REMOVETRAIT(TRAIT_FOV_APPLIED), PROC_REF(fov_disabled), override = TRUE)
	if(HAS_TRAIT(mymob, TRAIT_FOV_APPLIED))
		fov_enabled(mymob)
	else
		fov_disabled(mymob)
/atom/movable/screen/plane_master/field_of_vision_blocker/proc/fov_enabled(mob/source)
	SIGNAL_HANDLER
	if(force_hidden == FALSE)
		return
	unhide_plane(source)
/atom/movable/screen/plane_master/field_of_vision_blocker/proc/fov_disabled(mob/source)
	SIGNAL_HANDLER
	hide_plane(source)
/atom/movable/screen/plane_master/clickcatcher
	name = "Click Catcher"
	documentation = "Contém o objeto tela que usamos como fundo para capturar cliques em partes da tela que, caso contrário, conteriam nada. <br>Sempre estará abaixo de quase tudo o mais"
	plane = CLICKCATCHER_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	multiz_scaled = FALSE
	critical = PLANE_CRITICAL_DISPLAY
/atom/movable/screen/plane_master/clickcatcher/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	RegisterSignal(SSmapping, COMSIG_PLANE_OFFSET_INCREASE, PROC_REF(offset_increased))
	offset_increased(SSmapping, 0, SSmapping.max_plane_offset)
/atom/movable/screen/plane_master/clickcatcher/proc/offset_increased(datum/source, old_off, new_off)
	SIGNAL_HANDLER
	// We only want need the lowest level
	// If my system better supported changing PM plane values mid op I'd do that, but I do NOT so
	if(new_off > offset)
		hide_plane(home?.our_hud?.mymob)
/atom/movable/screen/plane_master/parallax_white
	name = "Parallax whitifier"
	documentation = "Essencialmente um fundo para o plano de parallax. Renderizamos apenas abaixo dele, então seremos multiplicados por sua bem, parallax.<br>Se você quer algo que pareça ter parallax, desenhe-o nesse plano."
	plane = PLANE_SPACE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_planes = list(RENDER_PLANE_UNLIT_GAME, RENDER_PLANE_LIGHT_MASK)
	critical = PLANE_CRITICAL_FUCKO_PARALLAX // goes funny when touched. no idea why I don't trust byond
/atom/movable/screen/plane_master/parallax_white/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_EMISSIVE, offset), relay_layer = EMISSIVE_SPACE_LAYER)
/atom/movable/screen/plane_master/parallax_white/set_home(datum/plane_master_group/home)
	. = ..()
	if(home)
		RegisterSignal(home, COMSIG_GROUP_HUD_CHANGED, PROC_REF(hud_changed))
		hud_changed(null, null, home.our_hud)
/atom/movable/screen/plane_master/parallax_white/proc/hud_changed(datum/source, datum/hud/old_hud, datum/hud/new_hud)
	SIGNAL_HANDLER
	if(old_hud)
		UnregisterSignal(old_hud, list(SIGNAL_ADDTRAIT(TRAIT_PARALLAX_DISPLAYED), SIGNAL_REMOVETRAIT(TRAIT_PARALLAX_DISPLAYED)), PROC_REF(parallax_updated))
	if(new_hud)
		RegisterSignals(new_hud, list(SIGNAL_ADDTRAIT(TRAIT_PARALLAX_DISPLAYED), SIGNAL_REMOVETRAIT(TRAIT_PARALLAX_DISPLAYED)), PROC_REF(parallax_updated))
		parallax_updated(new_hud)
/atom/movable/screen/plane_master/parallax_white/proc/parallax_updated(datum/source)
	SIGNAL_HANDLER
	if(isnull(home.our_hud?.mymob))
		return
	if(HAS_TRAIT(home.our_hud, TRAIT_PARALLAX_DISPLAYED))
		// Gives parallax a fullwhite backdrop to multiply against
		color = list(
			0, 0, 0, 0,
			0, 0, 0, 0,
			0, 0, 0, 0,
			1, 1, 1, 1,
			0, 0, 0, 0
			)
	else
		color = initial(color)
///Contains space parallax
/atom/movable/screen/plane_master/parallax
	name = "Parallax"
	documentation = "Contains parallax, or to be more exact the screen objects that hold parallax.\
		<br>Note the BLEND_MULTIPLY. The trick here is how low our plane value is. Because of that, we draw below almost everything in the game.\
		<br>We abuse this to ensure we multiply against the Parallax whitifier plane, or space's plane. It's set to full white, so when you do the multiply you just get parallax out where it well, makes sense to be.\
		<br>Also notice that the parent parallax plane is mirrored down to all children. We want to support viewing parallax across all z levels at once."
	plane = PLANE_SPACE_PARALLAX
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	blend_mode = BLEND_MULTIPLY
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	multiz_scaled = FALSE
/atom/movable/screen/plane_master/parallax/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	if(offset != 0)
		// You aren't the source? don't change yourself
		critical = PLANE_CRITICAL_FUCKO_PARALLAX
		return
	RegisterSignal(SSmapping, COMSIG_PLANE_OFFSET_INCREASE, PROC_REF(on_offset_increase))
	RegisterSignal(SSdcs, COMSIG_NARSIE_SUMMON_UPDATE, PROC_REF(narsie_modified))
	if(GLOB.narsie_summon_count >= 1)
		narsie_start_midway(GLOB.narsie_effect_last_modified) // We assume we're on the start, so we can use this number
	offset_increase(0, SSmapping.max_plane_offset)
/atom/movable/screen/plane_master/parallax/set_home(datum/plane_master_group/home)
	. = ..()
	if(home)
		RegisterSignal(home, COMSIG_GROUP_HUD_CHANGED, PROC_REF(hud_changed))
		hud_changed(null, null, home.our_hud)
/atom/movable/screen/plane_master/parallax/proc/hud_changed(datum/source, datum/hud/old_hud, datum/hud/new_hud)
	SIGNAL_HANDLER
	if(old_hud)
		UnregisterSignal(old_hud, list(SIGNAL_ADDTRAIT(TRAIT_PARALLAX_DISPLAYED), SIGNAL_REMOVETRAIT(TRAIT_PARALLAX_DISPLAYED)), PROC_REF(parallax_updated))
	if(new_hud)
		RegisterSignals(new_hud, list(SIGNAL_ADDTRAIT(TRAIT_PARALLAX_DISPLAYED), SIGNAL_REMOVETRAIT(TRAIT_PARALLAX_DISPLAYED)), PROC_REF(parallax_updated))
		parallax_updated(new_hud)
/atom/movable/screen/plane_master/parallax/proc/parallax_updated(datum/source)
	SIGNAL_HANDLER
	if(isnull(home.our_hud?.mymob))
		return
	if(HAS_TRAIT(home.our_hud, TRAIT_PARALLAX_DISPLAYED))
		show_to(home.our_hud.mymob)
	else
		hide_from(home.our_hud.mymob)
/atom/movable/screen/plane_master/parallax/proc/on_offset_increase(datum/source, old_offset, new_offset)
	SIGNAL_HANDLER
	offset_increase(old_offset, new_offset)
/atom/movable/screen/plane_master/parallax/proc/offset_increase(old_offset, new_offset)
	// Parallax will be mirrored down to any new planes that are added, so it will properly render across mirage borders
	for(var/offset in old_offset to new_offset)
		if(offset != 0)
			// Overlay so we don't multiply twice, and thus fuck up our rendering
			add_relay_to(GET_NEW_PLANE(plane, offset), BLEND_OVERLAY)
// Hacky shit to ensure parallax works in perf mode
/atom/movable/screen/plane_master/parallax/outside_bounds(mob/relevant)
	if(offset == 0)
		remove_relay_from(GET_NEW_PLANE(RENDER_PLANE_UNLIT_GAME, 0))
		is_outside_bounds = TRUE // I'm sorry :(
		return
	// If we can't render, and we aren't the bottom layer, don't render us
	// This way we only multiply against stuff that's not fullwhite space
	var/atom/movable/screen/plane_master/parent_parallax = home.our_hud.get_plane_master(PLANE_SPACE_PARALLAX)
	var/turf/viewing_turf = get_turf(relevant)
	if(!viewing_turf || offset != GET_LOWEST_STACK_OFFSET(viewing_turf.z))
		parent_parallax.remove_relay_from(plane)
	else
		parent_parallax.add_relay_to(plane, BLEND_OVERLAY)
	return ..()
/atom/movable/screen/plane_master/parallax/inside_bounds(mob/relevant)
	if(offset == 0)
		add_relay_to(GET_NEW_PLANE(RENDER_PLANE_UNLIT_GAME, 0))
		is_outside_bounds = FALSE
		return
	// Always readd, just in case we lost it
	var/atom/movable/screen/plane_master/parent_parallax = home.our_hud.get_plane_master(PLANE_SPACE_PARALLAX)
	parent_parallax.add_relay_to(plane, BLEND_OVERLAY)
	return ..()
// Needs to handle rejoining on a lower z level, so we NEED to readd old planes
/atom/movable/screen/plane_master/parallax/check_outside_bounds()
	// If we're outside bounds AND we're the 0th plane, we need to show cause parallax is hacked to hell
	return offset != 0 && is_outside_bounds
/// Starts the narsie animation midway, so we can catch up to everyone else quickly
/atom/movable/screen/plane_master/parallax/proc/narsie_start_midway(start_time)
	var/time_elapsed = world.time - start_time
	narsie_summoned_effect(max(16 SECONDS - time_elapsed, 0))
/// Starts the narsie animation, make us grey, then red
/atom/movable/screen/plane_master/parallax/proc/narsie_modified(datum/source, new_count)
	SIGNAL_HANDLER
	if(new_count >= 1)
		narsie_summoned_effect(16 SECONDS)
	else
		narsie_unsummoned()
/atom/movable/screen/plane_master/parallax/proc/narsie_summoned_effect(animate_time)
	if(GLOB.narsie_summon_count >= 2)
		var/static/list/nightmare_parallax = list(255,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, -130,0,0,0)
		animate(src, color = nightmare_parallax, time = animate_time)
		return
	var/static/list/grey_parallax = list(0.4,0.4,0.4,0, 0.4,0.4,0.4,0, 0.4,0.4,0.4,0, 0,0,0,1, -0.1,-0.1,-0.1,0)
	// We're gonna animate ourselves grey
	// Then, once it's done, about 40 seconds into the event itself, we're gonna start doin some shit. see below
	animate(src, color = grey_parallax, time = animate_time)
/atom/movable/screen/plane_master/parallax/proc/narsie_unsummoned()
	animate(src, color = null, time = 8 SECONDS)
/atom/movable/screen/plane_master/displacement
	name = "Displacement"
	documentation = "Ok so this one's fun. Basically, we want to be able to distort the game plane when a grav annom or similar is around.\
		<br>So we draw the pattern we want to use to this plane, and it's then used as a render target by a distortion filter on the game plane.\
		<br>Note the blend mode and lack of relay targets. This plane exists only to distort, it's never rendered anywhere."
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	plane = DISPLACEMENT_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	blend_mode = BLEND_ADD
	render_target = DISPLACEMENT_RENDER_TARGET
	render_relay_planes = list()
	// We start out hidden as we do not need to render when there's no distortion on our level
	start_hidden = TRUE
/atom/movable/screen/plane_master/displacement/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	RegisterSignal(GLOB, SIGNAL_ADDTRAIT(TRAIT_DISTORTION_IN_USE(offset)), PROC_REF(distortion_enabled))
	RegisterSignal(GLOB, SIGNAL_REMOVETRAIT(TRAIT_DISTORTION_IN_USE(offset)), PROC_REF(distortion_disabled))
	if(HAS_TRAIT(GLOB, TRAIT_DISTORTION_IN_USE(offset)))
		distortion_enabled()
/atom/movable/screen/plane_master/displacement/proc/distortion_enabled(datum/source)
	SIGNAL_HANDLER
	var/mob/our_mob = home?.our_hud?.mymob
	unhide_plane(our_mob)
/atom/movable/screen/plane_master/displacement/proc/distortion_disabled(datum/source)
	SIGNAL_HANDLER
	hide_plane()
/// Contains just the floor
/atom/movable/screen/plane_master/floor
	name = "Floor"
	documentation = "A bem, piso. Isso é principalmente usado como mecanismo de ordenação, mas também nos permite criar um 'limite' ao redor do plano do mundo do jogo, para que sua sombra projetada funcione realmente."
	plane = FLOOR_PLANE
	render_relay_planes = list(RENDER_PLANE_UNLIT_GAME, RENDER_PLANE_LIGHT_MASK)
/atom/movable/screen/plane_master/transparent_floor
	name = "Transparent Floor"
	documentation = "Na verdade apenas espaço vazio, coisas que são terrenos mas sem cor nem alfa algum.<br>Usamos isso para desenhar diretamente no plano de máscara de luz, porque, se não estiver presente, aparecerão buracos de preto sobre o espaço vazio."
	plane = TRANSPARENT_FLOOR_PLANE
	render_relay_planes = list(RENDER_PLANE_LIGHT_MASK)
	// Needs to be critical or it uh, it'll look white
	critical = PLANE_CRITICAL_DISPLAY|PLANE_CRITICAL_NO_RELAY
/atom/movable/screen/plane_master/floor/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_EMISSIVE, offset), relay_layer = EMISSIVE_FLOOR_LAYER, relay_color = GLOB.em_block_color)
/atom/movable/screen/plane_master/wall
	name = "Wall"
	documentation = "Aguarda todas as paredes. Renderizamos isso sobre o mundo do jogo. Separado para que possamos usar esse plano junto com os planos de espaço e piso como referência para onde a escuridão de Byond NÃO está."
	plane = WALL_PLANE
	render_relay_planes = list(RENDER_PLANE_GAME_WORLD, RENDER_PLANE_LIGHT_MASK)
/atom/movable/screen/plane_master/wall/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_EMISSIVE, offset), relay_layer = EMISSIVE_WALL_LAYER, relay_color = GLOB.em_block_color)
/atom/movable/screen/plane_master/game
	name = "Game"
	documentation = "Aguarda a maioria dos objetos não relacionados ao piso ou às paredes. Qualquer coisa nesse plano 'deseja' intercalar-se dependendo da posição."
	plane = GAME_PLANE
	render_relay_planes = list(RENDER_PLANE_GAME_WORLD)
/atom/movable/screen/plane_master/game_world_above
	name = "Upper Game"
	documentation = "Para coisas que você quer desenhar como o plano do jogo, mas nunca abaixo de seus conteúdos."
	plane = ABOVE_GAME_PLANE
	render_relay_planes = list(RENDER_PLANE_GAME_WORLD)
/atom/movable/screen/plane_master/seethrough
	name = "Seethrough"
	documentation = "Aguarda as versões transparentes (feitas usando substituições de imagem) de objetos grandes. Transparência para o mouse, então você pode clicar por cima delas."
	plane = SEETHROUGH_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_planes = list(RENDER_PLANE_GAME_WORLD)
	start_hidden = TRUE
/**
 * Plane master that byond will by default draw to
 * Shouldn't be used, exists to prevent people using plane 0
 * NOTE: If we used SEE_BLACKNESS on a map format that wasn't SIDE_MAP, this is where its darkness would land
 * This would allow us to control it and do fun things. But we can't because side map doesn't support it, so this is just a stub
 */
/atom/movable/screen/plane_master/default
	name = "Default"
	documentation = "This is quite fiddly, so bear with me. By default (in byond) everything in the game is rendered onto plane 0. It's the default plane. \
		<br>But, because we've moved everything we control off plane 0, all that's left is stuff byond internally renders. \
		<br>What I'd like to do with this is capture byond blackness by giving mobs the SEE_BLACKNESS sight flag. \
		<br>But we CAN'T because SEE_BLACKNESS does not work with our rendering format. So I just eat it I guess"
	plane = DEFAULT_PLANE
	multiz_scaled = FALSE
	start_hidden = TRUE // Doesn't DO anything, exists to hold this place
/atom/movable/screen/plane_master/area
	name = "Area"
	documentation = "Aguarda as áreas em si, o que significa que contém quaisquer sobreposições/efeitos aplicados às áreas. NÃO neve ou tempestades radiais, essas vão acima do plano de iluminação."
	plane = AREA_PLANE
/atom/movable/screen/plane_master/weather
	name = "Weather"
	documentation = "Aguarda os sprites principais de 32x32 com padrão de clima. Faz máscara contra paredes que estão na borda dos efeitos climáticos."
	plane = WEATHER_PLANE
	start_hidden = TRUE
	critical = PLANE_CRITICAL_DISPLAY
/atom/movable/screen/plane_master/weather/set_home(datum/plane_master_group/home)
	. = ..()
	if(!.)
		return
	home.AddComponent(/datum/component/hide_weather_planes, src)
/atom/movable/screen/plane_master/massive_obj
	name = "Massive object"
	documentation = "Objetos grandes precisam ser renderizados acima de tudo no plano do jogo, caso contrário, bem, serão cortados e parecerão não tão grandes. Esse plano faz isso."
	plane = MASSIVE_OBJ_PLANE
/atom/movable/screen/plane_master/point
	name = "Point"
	documentation = "Quero dizer, o que eu deveria dizer? Os pontos são desenhados sobre quase tudo o mais, então têm seu próprio plano. Lembre-se de que usamos camadas de renderização para desenhar os planos na ordem correta nos painéis de renderização."
	plane = POINT_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
///Contains all turf lighting
/atom/movable/screen/plane_master/turf_lighting
	name = "Turf Lighting"
	documentation = "Contém toda a iluminação desenhada em terrenos. Não é muito complexo, desenha diretamente no plano de iluminação."
	plane = LIGHTING_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_planes = list(RENDER_PLANE_TURF_LIGHTING)
	blend_mode_override = BLEND_ADD
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	critical = PLANE_CRITICAL_DISPLAY
/// This will not work through multiz, because of a byond bug with BLEND_MULTIPLY
/// Bug report is up, waiting on a fix
/atom/movable/screen/plane_master/o_light_visual
	name = "Overlight light visual"
	documentation = "Holds overlay lighting objects, or the sort of lighting that's a well, overlay stuck to something.\
		<br>Exists because lighting updating is really slow, and movement needs to feel smooth.\
		<br>We draw to the game plane, and mask out space for ourselves on the lighting plane so any color we have has the chance to display."
	plane = O_LIGHTING_VISUAL_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_target = O_LIGHTING_VISUAL_RENDER_TARGET
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	blend_mode = BLEND_ADD
	render_relay_planes = list(RENDER_PLANE_LIGHTING)
	critical = PLANE_CRITICAL_DISPLAY
/atom/movable/screen/plane_master/o_light_visual/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	// I'd love for this to be HSL but filters don't work with blend modes
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_TURF_LIGHTING, offset), BLEND_MULTIPLY, relay_color = list(
		-1, -1, -1, 0,
		-1, -1, -1, 0,
		-1, -1, -1, 0,
		0, 0, 0, OVERLAY_LIGHTING_WEIGHT,
		1, 1, 1, 0,
	))
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_SPECULAR, offset), relay_color = list(
		SPECULAR_EMISSIVE_OVERLAY_CONTRAST, 0, 0, 0,
		0, SPECULAR_EMISSIVE_OVERLAY_CONTRAST, 0, 0,
		0, 0, SPECULAR_EMISSIVE_OVERLAY_CONTRAST, 0,
		0, 0, 0, 1,
		-SPECULAR_EMISSIVE_CUTOFF, -SPECULAR_EMISSIVE_CUTOFF, -SPECULAR_EMISSIVE_CUTOFF, 0,
	))
/atom/movable/screen/plane_master/above_lighting
	name = "Above lighting"
	plane = ABOVE_LIGHTING_PLANE
	documentation = "Qualquer coisa no plano do jogo que precise de um espaço para ser desenhada estará acima do plano de iluminação.<br>Principalmente pequenos alertas e efeitos, também às vezes contém coisas que pareçam brilhantes."
	render_relay_planes = list(RENDER_PLANE_GAME)
/atom/movable/screen/plane_master/weather_glow
	name = "Weather Glow"
	documentation = "Aguarda as partes brilhantes dos sprites principais de 32x32 com padrão de clima."
	plane = WEATHER_GLOW_PLANE
	start_hidden = TRUE
	critical = PLANE_CRITICAL_DISPLAY
	render_relay_planes = list(RENDER_PLANE_GAME)
/atom/movable/screen/plane_master/weather_glow/set_home(datum/plane_master_group/home)
	. = ..()
	if(!.)
		return
	home.AddComponent(/datum/component/hide_weather_planes, src)
/**
 * Handles emissive overlays and emissive blockers.
 */
/atom/movable/screen/plane_master/emissive
	name = "Emissive"
	documentation = "Holds things that will be used to mask the lighting plane later on. Masked by the Emissive Mask plane to ensure we don't emiss out under a wall.\
		<br>Relayed onto the Emissive render plane to do the actual masking of lighting, since we need to be transformed and other emissive stuff needs to be transformed too.\
		<br>Don't want to double scale now."
	plane = EMISSIVE_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_planes = list()
	critical = PLANE_CRITICAL_DISPLAY
/atom/movable/screen/plane_master/emissive/Initialize(mapload, datum/hud/hud_owner, datum/plane_master_group/home, offset)
	. = ..()
	/// Okay, so what we're doing here is making all emissives convert to white for actual emissive masking (i.e. adding light so objects glow)
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_EMISSIVE, offset), relay_color = list(1,1,1,0, 1,1,1,0, 0,0,0,0, 0,0,0,1, 0,0,0,0))
	/// But for the bloom plate we convert only the red color into full white, this way we can have emissives in green channel unaffected by bloom
	/// which allows us to selectively bloom only a part of our emissives
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_EMISSIVE_BLOOM, offset), relay_color = list(255,255,255,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0))
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_EMISSIVE_BLOOM_MASK, offset), relay_color = list(1,1,1,1, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0))
	// Blue channel is dedicated to specular, i.e. our bootleg implementation of shiny objects
	// We map it onto alpha so we can use the mask plate in an alpha mask filter to cut out only the shiny bits
	add_relay_to(GET_NEW_PLANE(RENDER_PLANE_SPECULAR_MASK, offset), relay_color = list(0,0,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0, 1,1,1,0))
/atom/movable/screen/plane_master/pipecrawl
	name = "Pipecrawl"
	documentation = "Aguarda imagens geradas durante o bem, pipecrawling.<br>Tem alguns efeitos e uma matriz de cores estranha projetada para tornar as coisas um pouco mais visíveis visualmente."
	plane = PIPECRAWL_IMAGES_PLANE
	start_hidden = TRUE
	render_relay_planes = list(RENDER_PLANE_GAME)
/atom/movable/screen/plane_master/pipecrawl/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	// Makes everything on this plane slightly brighter
	// Has a nice effect, makes thing stand out
	color = list(1.2,0,0,0, 0,1.2,0,0, 0,0,1.2,0, 0,0,0,1, 0,0,0,0)
	// This serves a similar purpose, I want the pipes to pop
	add_filter("pipe_dropshadow", 1, drop_shadow_filter(x = -1, y= -1, size = 1, color = COLOR_HALF_TRANSPARENT_BLACK))
	mirror_parent_hidden()
/atom/movable/screen/plane_master/camera_static
	name = "Camera static"
	documentation = "Aguarda imagens estáticas da câmera. Normalmente apenas visíveis para pessoas que conseguem bem, ver o estático.<br>Usamos imagens em vez de conteúdo de visibilidade porque são leves no mapa tick e o mapa tick é péssimo.,"
	plane = CAMERA_STATIC_PLANE
	render_relay_planes = list(RENDER_PLANE_GAME)
/atom/movable/screen/plane_master/camera_static/set_home(datum/plane_master_group/home)
	. = ..()
	if(home)
		RegisterSignal(home, COMSIG_GROUP_HUD_CHANGED, PROC_REF(hud_changed))
		hud_changed(null, null, home.our_hud)
/atom/movable/screen/plane_master/camera_static/proc/hud_changed(datum/source, datum/hud/old_hud, datum/hud/new_hud)
	SIGNAL_HANDLER
	if(old_hud)
		UnregisterSignal(old_hud, COMSIG_HUD_EYE_CHANGED, PROC_REF(eye_changed))
	if(new_hud)
		RegisterSignal(new_hud, COMSIG_HUD_EYE_CHANGED, PROC_REF(eye_changed))
		eye_changed(new_hud, null, new_hud.mymob?.canon_client?.eye)
/atom/movable/screen/plane_master/camera_static/proc/eye_changed(datum/hud/source, atom/old_eye, atom/new_eye)
	SIGNAL_HANDLER
	if(istype(new_eye, /obj/effect/landmark/ai_multicam_room))
		if(force_hidden)
			unhide_plane(source.mymob)
		return
	if(!iscameramob(new_eye))
		if(!force_hidden)
			hide_plane(source.mymob)
		return
	if(force_hidden)
		unhide_plane(source.mymob)
/atom/movable/screen/plane_master/high_game
	name = "High Game"
	documentation = "Holds anything that wants to be displayed above the rest of the game plane, and doesn't want to be clickable. \
		<br>This includes atmos debug overlays, blind sound images, and mining scanners. \
		<br>Really only exists for its layering potential, we don't use this for any vfx"
	plane = HIGH_GAME_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	render_relay_planes = list(RENDER_PLANE_GAME)
/atom/movable/screen/plane_master/ghost
	name = "Ghost"
	documentation = "Os fantasmas desenham aqui, então não se misturam com as visualizações do mundo do jogo. Observação: isso não é como escondemos fantasmas das pessoas; isso é feito com invisível e ver_invisible.,"
	plane = GHOST_PLANE
	render_relay_planes = list(RENDER_PLANE_NON_GAME)
/atom/movable/screen/plane_master/fullscreen
	name = "Fullscreen"
	documentation = "Aguarda qualquer coisa que se aplique ou esteja acima da tela inteira.<br>Observação: ainda é renderizado abaixo dos objetos do HUD, mas isso nos permite controlar a ordem em que efeitos como morte/efeito de dano são exibidos.,"
	plane = FULLSCREEN_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_planes = list(RENDER_PLANE_NON_GAME)
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	offsetting_flags = BLOCKS_PLANE_OFFSETTING|OFFSET_RELAYS_MATCH_HIGHEST
/atom/movable/screen/plane_master/runechat
	name = "Runechat"
	documentation = "Aguarda imagens do runechat, o texto que aparece quando alguém diz algo. Usa uma sombra para bem, parecer bonito."
	plane = RUNECHAT_PLANE
	render_relay_planes = list(RENDER_PLANE_NON_GAME)
/atom/movable/screen/plane_master/runechat/show_to(mob/mymob)
	. = ..()
	if(!.)
		return
	remove_filter("AO")
	if(istype(mymob) && mymob.canon_client?.prefs?.read_preference(/datum/preference/toggle/ambient_occlusion))
		// We use outlines instead of drop shadow due to how extremely expensive it is, and there's no reason to use it for runechat
		// which already has high drop shadow transparency at just 32 alpha, so outline does the job good enough
		add_filter("AO", 1, outline_filter(size = 2, color = "#04080F20", flags = OUTLINE_SQUARE))
/atom/movable/screen/plane_master/balloon_chat
	name = "Balloon chat"
	documentation = "Aguarda imagens de chat de balão, essas pequenas barras de texto que aparecem por um segundo quando você faz alguma ação. NÃO é runechat."
	plane = BALLOON_CHAT_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_planes = list(RENDER_PLANE_NON_GAME)
/atom/movable/screen/plane_master/hud
	name = "HUD"
	documentation = "Contém tudo o que deseja ser renderizado no HUD. Normalmente são apenas elementos da tela."
	plane = HUD_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_planes = list(RENDER_PLANE_NON_GAME)
	offsetting_flags = BLOCKS_PLANE_OFFSETTING|OFFSET_RELAYS_MATCH_HIGHEST
/atom/movable/screen/plane_master/above_hud
	name = "Above HUD"
	documentation = "Qualquer coisa que deseje ser desenhada ACIMA do resto do HUD. Normalmente são botões de fechar e outros elementos que precisam estar sempre visíveis. Pense em prevenir memes com botões de ação dragável."
	plane = ABOVE_HUD_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_planes = list(RENDER_PLANE_NON_GAME)
	offsetting_flags = BLOCKS_PLANE_OFFSETTING|OFFSET_RELAYS_MATCH_HIGHEST
/atom/movable/screen/plane_master/splashscreen
	name = "Splashscreen"
	documentation = "Cinemas e tela inicial."
	plane = SPLASHSCREEN_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_planes = list(RENDER_PLANE_NON_GAME)
	offsetting_flags = BLOCKS_PLANE_OFFSETTING|OFFSET_RELAYS_MATCH_HIGHEST
/atom/movable/screen/plane_master/escape_menu
	name = "Escape Menu"
	documentation = "Tudo relacionado ao menu de escape."
	plane = ESCAPE_MENU_PLANE
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR
	render_relay_planes = list(RENDER_PLANE_MASTER)
	offsetting_flags = BLOCKS_PLANE_OFFSETTING|OFFSET_RELAYS_MATCH_HIGHEST
/atom/movable/screen/plane_master/escape_menu/show_to(mob/mymob)
	. = ..()
	if(!.)
		return
	var/datum/hud/our_hud = home.our_hud
	if(!our_hud)
		return
	RegisterSignal(our_hud, SIGNAL_ADDTRAIT(TRAIT_ESCAPE_MENU_OPEN), PROC_REF(escape_opened), override = TRUE)
	RegisterSignal(our_hud, SIGNAL_REMOVETRAIT(TRAIT_ESCAPE_MENU_OPEN), PROC_REF(escape_closed), override = TRUE)
	if(!HAS_TRAIT(our_hud, TRAIT_ESCAPE_MENU_OPEN))
		escape_closed()
/atom/movable/screen/plane_master/escape_menu/proc/escape_opened(datum/source)
	SIGNAL_HANDLER
	var/mob/our_mob = home?.our_hud?.mymob
	unhide_plane(our_mob)
/atom/movable/screen/plane_master/escape_menu/proc/escape_closed(datum/source)
	SIGNAL_HANDLER
	var/mob/our_mob = home?.our_hud?.mymob
	hide_plane(our_mob)
