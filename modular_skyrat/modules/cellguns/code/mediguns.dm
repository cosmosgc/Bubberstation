// Base medigun code
/obj/item/gun/energy/cell_loaded/medigun
	name = "medigun"
	desc = "Esta é minha arma inteligente, não vai machucar ninguém amigável, na verdade vai fazê-los curar! Por favor, diga a Github se conseguir pegar essa arma."
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/projectile.dmi'
	icon_state = "medigun"
	inhand_icon_state = "chronogun" // Fits best with how the medigun looks, might be changed in the future
	ammo_type = list(/obj/item/ammo_casing/energy/medical) // The default option that heals oxygen
	w_class = WEIGHT_CLASS_NORMAL
	cell_type = /obj/item/stock_parts/power_store/cell/medigun
	modifystate = 1
	ammo_x_offset = 3
	charge_sections = 3
	maxcells = 3
	allowed_cells = list(/obj/item/weaponcell/medical)
	item_flags = null
	gun_flags = TURRET_INCOMPATIBLE

// Standard medigun - this is what you will get from Cargo, most likely.
/obj/item/gun/energy/cell_loaded/medigun/standard
	name = "VeyMedical CWM-479 cell-powered medigun"
	desc = "Este é um medigun modelo padrão produzido por Vey-Med, para cura em cenários menos do que ideal. A câmara médica está classificada para caber três células."

// Upgraded medigun
/obj/item/gun/energy/cell_loaded/medigun/upgraded
	name = "VeyMedical CWM-479-FC cell-powered medigun"
	desc = "Esta é uma variante atualizada do padrão CWM-479 medigun. Enquanto ele ainda só se encaixa em três células, sua célula foi atualizada para maior capacidade e carregamento mais rápido."
	cell_type = /obj/item/stock_parts/power_store/cell/medigun/upgraded

/obj/item/gun/energy/cell_loaded/medigun/upgraded/Initialize(mapload)
	. = ..()
	var/mutable_appearance/fastcharge_medigun = mutable_appearance('modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/projectile.dmi', "medigun_fastcharge")
	add_overlay(fastcharge_medigun)

// CMO and CC MediGun
/obj/item/gun/energy/cell_loaded/medigun/cmo
	name = "VeyMedical CWM-479-CC cell-powered medigun"
	desc = "A versão mais avançada da linha CWM-479 de mediguns, possui slots para seis células e uma bateria de recarga automática"
	cell_type = /obj/item/stock_parts/power_store/cell/medigun/experimental
	maxcells = 6
	selfcharge = 1
	can_charge = FALSE

/obj/item/gun/energy/cell_loaded/medigun/cmo/Initialize(mapload)
	. = ..()
	var/mutable_appearance/cmo_medigun = mutable_appearance('modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/projectile.dmi', "medigun_cmo")
	add_overlay(cmo_medigun)

// Medigun power cells
/obj/item/stock_parts/power_store/cell/medigun // This is the cell that mediguns from cargo will come with
	name = "basic medigun cell"
	maxcharge = STANDARD_CELL_CHARGE
	chargerate = STANDARD_CELL_CHARGE * 0.03

/obj/item/stock_parts/power_store/cell/medigun/upgraded
	name = "upgraded medigun cell"
	maxcharge = STANDARD_CELL_CHARGE * 1.4
	chargerate = STANDARD_CELL_CHARGE * 0.06

/obj/item/stock_parts/power_store/cell/medigun/experimental // This cell type is meant to be used in self charging mediguns like CMO and ERT one.
	name = "experimental medigun cell"
	maxcharge = 1.8 * STANDARD_CELL_CHARGE
	chargerate = 0.1 * STANDARD_CELL_CHARGE
// End of power cells

// Upgrade Kit
/obj/item/device/custom_kit/medigun_fastcharge
	name = "VeyMedical CWM-479 upgrade kit"
	desc = "Atualiza a bateria interna dentro do medigun, permitindo carregamento mais rápido e uma maior capacidade celular. Requer que as células do medigun sejam removidas primeiro!"
	// don't tinker with a loaded (medi)gun. fool
	from_obj = /obj/item/gun/energy/cell_loaded/medigun/standard
	to_obj = /obj/item/gun/energy/cell_loaded/medigun/upgraded

/obj/item/device/custom_kit/medigun_fastcharge/pre_convert_check(obj/target_obj, mob/user)
	var/obj/item/gun/energy/cell_loaded/medigun/standard/our_medigun = target_obj
	if(length(our_medigun.installedcells))
		balloon_alert(user, "Descarregue primeiro!")
		return FALSE
	return TRUE

// Medigun wiki book
/obj/item/book/manual/wiki/mediguns
	name = "medigun operating manual"
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/misc.dmi'
	icon_state = "manual"
	starting_author = "VeyMedical"
	starting_title = "Medigun Operating Manual"
	page_link = "Guide_to_Mediguns"

// Medigun Gunsets
/obj/item/storage/briefcase/medicalgunset
	name = "medigun supply kit"
	desc = "Um kit de suprimentos para o medigun."
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/misc.dmi'
	icon_state = "case_standard"
	inhand_icon_state = "lockbox"
	lefthand_file = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound =  'sound/items/handling/ammobox_pickup.ogg'

/obj/item/storage/briefcase/medicalgunset/standard
	name = "VeyMedical CWM-479 cell-powered medigun case"
	desc = "Uma pasta que contém o medigun CWM-479 e um manual de instruções."

/obj/item/storage/briefcase/medicalgunset/standard/PopulateContents()
	new /obj/item/gun/energy/cell_loaded/medigun/standard(src)
	new /obj/item/book/manual/wiki/mediguns(src)

/obj/item/storage/briefcase/medicalgunset/cmo
	name = "VeyMedical CWM-479-CC cell-powered medigun case"
	desc = "Uma pasta que contém o medigun experimental CWM-479-CC, um conjunto básico de três células medigun, e um manual de instruções."
	icon_state = "case_cmo"

/obj/item/storage/briefcase/medicalgunset/cmo/PopulateContents()
	new /obj/item/gun/energy/cell_loaded/medigun/cmo(src)
	new /obj/item/weaponcell/medical/brute(src)
	new /obj/item/weaponcell/medical/burn(src)
	new /obj/item/weaponcell/medical/toxin(src)
	new /obj/item/book/manual/wiki/mediguns(src)

/*
* Medigun Cells - Spritework is done by Arctaisia!
*/

// Default Cell
/obj/item/weaponcell/medical
	name = "default medicell"
	desc = "A célula de oxigênio padrão, a maioria das armas vem com isso já instalado."
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/medicells.dmi'
	icon_state = "Oxy1"
	w_class = WEIGHT_CLASS_SMALL
	ammo_type = /obj/item/ammo_casing/energy/medical // This is the ammo type that all mediguns come with.
	medicell_examine = TRUE

/obj/item/weaponcell/medical/oxygen
	name = "oxygen I medicell"
	desc = "Uma pequena célula com um leve brilho azul. Pode ser usado em mediguns para permitir a funcionalidade básica de cura da privação de oxigênio."

/*
* Tier I cells
*/

// Brute I
/obj/item/weaponcell/medical/brute
	name = "brute I medicell"
	desc = "Uma pequena célula com um leve brilho vermelho. Pode ser usado em mediguns para permitir a funcionalidade básica de cura de danos brutos."
	icon_state = "Brute1"
	ammo_type = /obj/item/ammo_casing/energy/medical/brute1/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/brute1
	primary_mode = /obj/item/ammo_casing/energy/medical/brute1/safe
	toggle_modes = TRUE

// Burn I
/obj/item/weaponcell/medical/burn
	name = "burn I medicell"
	desc = "Uma pequena célula com um leve brilho amarelo. Pode ser usado em mediguns para permitir a funcionalidade básica de cura de danos."
	icon_state = "Burn1"
	ammo_type = /obj/item/ammo_casing/energy/medical/burn1/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/burn1
	primary_mode = /obj/item/ammo_casing/energy/medical/burn1/safe
	toggle_modes = TRUE
// Toxin I
/obj/item/weaponcell/medical/toxin
	name = "toxin I medicell"
	desc = "Uma pequena célula com um leve brilho verde. Pode ser usado em mediguns para permitir a funcionalidade básica de cura de danos à toxina."
	icon_state = "Toxin1"
	ammo_type = /obj/item/ammo_casing/energy/medical/toxin1

/*
* Tier II Cells
*/

// Brute II
/obj/item/weaponcell/medical/brute/tier_2
	name = "brute II medicell"
	desc = "Uma pequena célula com um brilho vermelho notável. Pode ser usado em mediguns para melhorar a funcionalidade de cura de danos brutos."
	icon_state = "Brute2"
	ammo_type = /obj/item/ammo_casing/energy/medical/brute2/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/brute2
	primary_mode = /obj/item/ammo_casing/energy/medical/brute2/safe

// Burn II
/obj/item/weaponcell/medical/burn/tier_2
	name = "burn II medicell"
	desc = "Uma pequena célula com um notável brilho amarelo. Pode ser usado em mediguns para melhorar a funcionalidade de cura de danos."
	icon_state = "Burn2"
	ammo_type = /obj/item/ammo_casing/energy/medical/burn2/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/burn2
	primary_mode = /obj/item/ammo_casing/energy/medical/burn2/safe

// Toxin II
/obj/item/weaponcell/medical/toxin/tier_2
	name = "toxin II medicell"
	desc = "Uma pequena célula com um brilho verde visível. Pode ser usado em mediguns para melhorar a funcionalidade de cura de danos nas toxinas."
	icon_state = "Toxin2"
	ammo_type = /obj/item/ammo_casing/energy/medical/toxin2

// Oxygen II
/obj/item/weaponcell/medical/oxygen/tier_2
	name = "oxygen II medicell"
	desc = "Uma pequena célula com um notável brilho azul. Pode ser usado em mediguns para melhorar a funcionalidade de cura da privação de oxigênio."
	icon_state = "Oxy2"
	ammo_type = /obj/item/ammo_casing/energy/medical/oxy2

/*
* Tier III Cells
*/

// Brute III
/obj/item/weaponcell/medical/brute/tier_3
	name = "brute III medicell"
	desc = "Uma pequena célula com um intenso brilho vermelho e uma cápsula reforçada. Pode ser usado em mediguns para permitir a funcionalidade avançada de cura de danos brutos."
	icon_state = "Brute3"
	ammo_type = /obj/item/ammo_casing/energy/medical/brute3/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/brute3
	primary_mode = /obj/item/ammo_casing/energy/medical/brute3/safe

// Burn III
/obj/item/weaponcell/medical/burn/tier_3
	name = "burn III medicell"
	desc = "Uma pequena célula com um intenso brilho amarelo e uma cápsula reforçada. Pode ser usado em mediguns para permitir a cura avançada de danos."
	icon_state = "Burn3"
	ammo_type = /obj/item/ammo_casing/energy/medical/burn3/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/burn3
	primary_mode = /obj/item/ammo_casing/energy/medical/burn3/safe

// Toxin III
/obj/item/weaponcell/medical/toxin/tier_3
	name = "toxin III medicell"
	desc = "Uma pequena célula com um brilho verde intenso e uma cápsula reforçada. Pode ser usado em mediguns para permitir a funcionalidade avançada de cicatrização de danos nas toxinas."
	icon_state = "Toxin3"
	ammo_type = /obj/item/ammo_casing/energy/medical/toxin3

// Oxygen III
/obj/item/weaponcell/medical/oxygen/tier_3
	name = "oxygen III medicell"
	desc = "Uma pequena célula com um intenso brilho azul e uma cápsula reforçada. Pode ser usado em mediguns para permitir a funcionalidade avançada de cura da privação de oxigênio."
	icon_state = "Oxy3"
	ammo_type = /obj/item/ammo_casing/energy/medical/oxy3

/*
* Utility Cells
*/

/obj/item/weaponcell/medical/utility
	name = "utility class medicell"
	desc = "Você não deveria estar vendo isso. Se o fizer, grite com seus codificadores locais."

/obj/item/weaponcell/medical/utility/clotting
	name = "clotting medicell"
	desc = "Um médico projetado para ajudar a lidar com pacientes sangrando."
	icon_state = "clotting"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/clotting

/obj/item/weaponcell/medical/utility/temperature
	name = "temperature readjustment medicell"
	desc = "Um médico que ajusta a temperatura de um paciente ao ponto entre\"Sangue congelado nas veias.\"e\"Sangue borrifando nas veias\"."
	icon_state = "temperature"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/temperature

/obj/item/weaponcell/medical/utility/hardlight_gown
	name = "hardlight gown medicell"
	desc = "Um médico que cria um vestido de hospital no alvo."
	icon_state = "gown"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/gown

/obj/item/weaponcell/medical/utility/salve
	name = "hardlight salve medicell"
	desc = "Um medicell que aplica um globule de cura de matéria sintética para um paciente."
	icon_state = "salve"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/salve

/obj/item/weaponcell/medical/utility/bed
	name = "hardlight roller bed medicell"
	desc = "Um medicell que convoca uma cama temporária debaixo de um paciente já deitado no chão."
	icon_state = "gown"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/bed

/obj/item/weaponcell/medical/utility/body_teleporter
	name = "body transporter medicell"
	desc = "Um médico que permite ao usuário transportar um corpo para si."
	icon_state = "body"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/body_teleporter

/obj/item/weaponcell/medical/utility/relocation
	name = "oppressive force relocation medicell"
	desc = "Um médico que se desloca com segurança após um período de carência, se usado por alguém com o acesso apropriado e dentro de uma área apropriadamente designada (geralmente Medbay)."
	icon_state =  "body"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/relocation/standard

/obj/item/weaponcell/medical/utility/relocation/upgraded
	name = "upgraded oppressive force relocation medicell"
	desc = "Uma versão atualizada do Relocation Medicell. Ele tem os requisitos de acesso e área removidos, juntamente com ter o período padrão de graça desativado."
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/relocation

//Empty Medicell//
/obj/item/device/custom_kit/empty_cell //Having the empty cell as an upgrade kit sounds jank, but it should work well.
	name = "empty salve medicell"
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/medicells.dmi'
	icon_state = "empty"
	desc = "Uma pomada inativa, use isso em uma folha de aloé para transformar isso em uma célula utilizável."
	from_obj = /obj/item/food/grown/aloe
	to_obj = /obj/item/weaponcell/medical/utility/salve

/obj/item/device/custom_kit/empty_cell/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/item_scaling, 0.5, 1)

/obj/item/device/custom_kit/empty_cell/body_teleporter
	name = "empty body teleporter medicell"
	desc = "Um teletransportador de corpo inativo, Medicell, use isso em um extrato de lodo de espaço azul para transformar isso em uma célula utilizável."
	from_obj = /obj/item/slime_extract/bluespace
	to_obj = /obj/item/weaponcell/medical/utility/body_teleporter

/obj/item/device/custom_kit/empty_cell/relocator
	name = "empty oppressive force relocator medicell"
	desc = "Um relocador de força opressor inativo, Medicell, use isso em um extrato de lodo do espaço azul para transformar isso em uma célula utilizável."
	from_obj = /obj/item/slime_extract/bluespace
	to_obj = /obj/item/weaponcell/medical/utility/relocation
