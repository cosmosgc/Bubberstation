
/datum/chemical_reaction/formaldehyde
	results = list(/datum/reagent/toxin/formaldehyde = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1, /datum/reagent/oxygen = 1, /datum/reagent/silver = 1)
	mix_message = "A mistura faz e produz um irmão feroz."
	is_cold_recipe = FALSE
	required_temp = 420
	optimal_temp = 520
	overheat_temp = 900
	optimal_ph_min = 0
	optimal_ph_max = 7
	determin_ph_range = 2
	temp_exponent_factor = 2
	ph_exponent_factor = 1.2
	thermic_constant = 200
	H_ion_release = -3
	rate_up_lim = 15
	purity_min = 0.5
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_CHEMICAL | REACTION_TAG_BRUTE | REACTION_TAG_TOXIN

/datum/chemical_reaction/fentanyl
	results = list(/datum/reagent/toxin/fentanyl = 1)
	required_reagents = list(/datum/reagent/drug/space_drugs = 1)
	mix_message = "A mistura fica nublada, depois fica clara novamente."
	is_cold_recipe = FALSE
	required_temp = 674
	optimal_temp = 774
	overheat_temp = 874
	optimal_ph_min = 7
	optimal_ph_max = 11
	determin_ph_range = 3
	temp_exponent_factor = 0.7
	ph_exponent_factor = 10
	thermic_constant = 50
	H_ion_release = 3
	rate_up_lim = 5
	purity_min = 0.5
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_ORGAN | REACTION_TAG_TOXIN

/datum/chemical_reaction/cyanide
	results = list(/datum/reagent/toxin/cyanide = 3)
	required_reagents = list(/datum/reagent/fuel/oil = 1, /datum/reagent/ammonia = 1, /datum/reagent/oxygen = 1)
	mix_message = "A mistura emite o fraco cheiro de amêndoas."
	is_cold_recipe = FALSE
	required_temp = 380
	optimal_temp = 420
	overheat_temp = NO_OVERHEAT
	optimal_ph_min = 9
	optimal_ph_max = 11
	determin_ph_range = 3
	temp_exponent_factor = 0.7
	ph_exponent_factor = 2
	thermic_constant = -300
	H_ion_release = 3.2
	rate_up_lim = 10
	purity_min = 0.4
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_OXY | REACTION_TAG_TOXIN

/datum/chemical_reaction/itching_powder
	results = list(/datum/reagent/toxin/itching_powder = 3)
	required_reagents = list(/datum/reagent/fuel = 1, /datum/reagent/ammonia = 1, /datum/reagent/medicine/c2/multiver = 1)
	mix_message = "Uma mistura emite gases irritantes do nariz."
	is_cold_recipe = FALSE
	required_temp = 280
	optimal_temp = 360
	overheat_temp = 700
	optimal_ph_min = 5
	optimal_ph_max = 9
	determin_ph_range = 4
	temp_exponent_factor = 0.7
	ph_exponent_factor = 1.5
	thermic_constant = -200
	H_ion_release = 5.7
	rate_up_lim = 20
	purity_min = 0.3
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_BRUTE

/datum/chemical_reaction/facid
	results = list(/datum/reagent/toxin/acid/fluacid = 4)
	required_reagents = list(/datum/reagent/toxin/acid = 1, /datum/reagent/fluorine = 1, /datum/reagent/hydrogen = 1, /datum/reagent/potassium = 1)
	mix_message = "As bolas de confusão fervilham."
	is_cold_recipe = FALSE
	required_temp = 380
	optimal_temp = 680
	overheat_temp = 800
	optimal_ph_min = 0
	optimal_ph_max = 2
	determin_ph_range = 5
	temp_exponent_factor = 2
	ph_exponent_factor = 10
	thermic_constant = -200
	H_ion_release = -25
	rate_up_lim = 20
	purity_min = 0.5
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_PLANT | REACTION_TAG_BURN | REACTION_TAG_TOXIN

/datum/chemical_reaction/nitracid
	results = list(/datum/reagent/toxin/acid/nitracid = 2)
	required_reagents = list(/datum/reagent/toxin/acid/fluacid = 1, /datum/reagent/nitrogen = 1,  /datum/reagent/hydrogen_peroxide = 1)
	mix_message = "As bolhas de mistura fervilham e dão um cheiro pungente."
	is_cold_recipe = FALSE
	required_temp = 480
	optimal_temp = 680
	overheat_temp = 900
	optimal_ph_min = 0
	optimal_ph_max = 4.1
	determin_ph_range = 5
	temp_exponent_factor = 2
	ph_exponent_factor = 10
	thermic_constant = -200
	H_ion_release = -20
	rate_up_lim = 20
	purity_min = 0.5
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_BURN | REACTION_TAG_TOXIN

/datum/chemical_reaction/sulfonal
	results = list(/datum/reagent/toxin/sulfonal = 3)
	required_reagents = list(/datum/reagent/acetone = 1, /datum/reagent/diethylamine = 1, /datum/reagent/sulfur = 1)
	mix_message = "A mistura muda de cor e fica clara."
	is_cold_recipe = FALSE
	required_temp = 100
	optimal_temp = 450
	overheat_temp = 900
	optimal_ph_min = 4
	optimal_ph_max = 9
	determin_ph_range = 2
	temp_exponent_factor = 1.5
	ph_exponent_factor = 1.5
	thermic_constant = 200
	H_ion_release = 5
	rate_up_lim = 10
	purity_min = 0.5
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_TOXIN | REACTION_TAG_OTHER

/datum/chemical_reaction/lipolicide
	results = list(/datum/reagent/toxin/lipolicide = 3)
	required_reagents = list(/datum/reagent/mercury = 1, /datum/reagent/diethylamine = 1, /datum/reagent/medicine/ephedrine = 1)
	mix_message = "Uma mistura de mágica turva."
	is_cold_recipe = FALSE
	required_temp = 100
	optimal_temp = 450
	overheat_temp = 900
	optimal_ph_min = 4
	optimal_ph_max = 8.5
	determin_ph_range = 2
	temp_exponent_factor = 1
	ph_exponent_factor = 0.2
	thermic_constant = 500
	H_ion_release = 2.5
	rate_up_lim = 10
	purity_min = 0.7
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_OTHER

/datum/chemical_reaction/mutagen
	results = list(/datum/reagent/toxin/mutagen = 3)
	required_reagents = list(/datum/reagent/uranium/radium = 1, /datum/reagent/phosphorus = 1, /datum/reagent/chlorine = 1)
	mix_message = "A mistura brilha levemente, então pára."
	is_cold_recipe = FALSE
	required_temp = 100
	optimal_temp = 450
	overheat_temp = 900
	optimal_ph_min = 3
	optimal_ph_max = 9
	determin_ph_range = 1
	temp_exponent_factor = 2
	ph_exponent_factor = 5
	thermic_constant = 350
	H_ion_release = 0.1
	rate_up_lim = 10
	purity_min = 0.7
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_PLANT | REACTION_TAG_OTHER | REACTION_TAG_COMPONENT

/datum/chemical_reaction/lexorin
	results = list(/datum/reagent/toxin/lexorin = 3)
	required_reagents = list(/datum/reagent/toxin/plasma = 1, /datum/reagent/hydrogen = 1, /datum/reagent/medicine/salbutamol = 1)
	mix_message = "A mistura fica clara e pára de reagir."
	is_cold_recipe = FALSE
	required_temp = 100
	optimal_temp = 450
	overheat_temp = 900
	optimal_ph_min = 1.8
	optimal_ph_max = 7
	determin_ph_range = 3
	temp_exponent_factor = 2
	ph_exponent_factor = 5
	thermic_constant = -400
	H_ion_release = 0.1
	rate_up_lim = 25
	purity_min = 0.4
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_OXY

/datum/chemical_reaction/hot_ice_melt
	results = list(/datum/reagent/toxin/plasma = 12) //One sheet of hot ice makes 200m of plasma
	required_reagents = list(/datum/reagent/toxin/hot_ice = 1)
	required_temp = T0C + 30 //Don't burst into flames when you melt
	thermic_constant = -200//Counter the heat
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_CHEMICAL | REACTION_TAG_TOXIN | REACTION_TAG_ACTIVE

/datum/chemical_reaction/chloralhydrate
	results = list(/datum/reagent/toxin/chloralhydrate = 1)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1, /datum/reagent/chlorine = 3, /datum/reagent/water = 1)
	mix_message = "A mistura fica muito azul."
	is_cold_recipe = FALSE
	required_temp = 200
	optimal_temp = 450
	overheat_temp = 900
	optimal_ph_min = 7
	optimal_ph_max = 9
	determin_ph_range = 2
	temp_exponent_factor = 2
	ph_exponent_factor = 2
	thermic_constant = 250
	H_ion_release = 2
	rate_up_lim = 10
	purity_min = 0.6
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_OTHER

/datum/chemical_reaction/mutetoxin //i'll just fit this in here snugly between other unfun chemicals :v
	results = list(/datum/reagent/toxin/mutetoxin = 2)
	required_reagents = list(/datum/reagent/uranium = 2, /datum/reagent/water = 1, /datum/reagent/carbon = 1)
	mix_message = "Uma mistura se acalma."
	is_cold_recipe = FALSE
	required_temp = 100
	optimal_temp = 450
	overheat_temp = 900
	optimal_ph_min = 6
	optimal_ph_max = 14
	determin_ph_range = 2
	temp_exponent_factor = 3
	ph_exponent_factor = 1
	thermic_constant = -250
	H_ion_release = -0.2
	rate_up_lim = 15
	purity_min = 0.4
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_OTHER

/datum/chemical_reaction/zombiepowder
	results = list(/datum/reagent/toxin/zombiepowder = 2)
	required_reagents = list(/datum/reagent/toxin/carpotoxin = 5, /datum/reagent/medicine/morphine = 5, /datum/reagent/copper = 5)
	mix_message = "A mistura se transforma em um estranho pó verde."
	is_cold_recipe = FALSE
	required_temp = 100
	optimal_temp = 450
	overheat_temp = 900
	optimal_ph_min = 5
	optimal_ph_max = 14
	determin_ph_range = 2
	temp_exponent_factor = 3
	ph_exponent_factor = 1
	thermic_constant = 150
	H_ion_release = -0.25
	rate_up_lim = 15
	purity_min = 0.3
	reaction_flags = REACTION_CLEAR_INVERSE
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_OTHER

/datum/chemical_reaction/ghoulpowder
	results = list(/datum/reagent/toxin/ghoulpowder = 2)
	required_reagents = list(/datum/reagent/toxin/zombiepowder = 1, /datum/reagent/medicine/epinephrine = 1)
	mix_message = "A mistura se transforma em um estranho pó marrom."
	is_cold_recipe = FALSE
	required_temp = 100
	optimal_temp = 450
	overheat_temp = 900
	optimal_ph_min = 5
	optimal_ph_max = 14
	determin_ph_range = 2
	temp_exponent_factor = 3
	ph_exponent_factor = 1
	thermic_constant = 150
	H_ion_release = -0.25
	rate_up_lim = 15
	purity_min = 0.4
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_OTHER

/datum/chemical_reaction/mindbreaker
	results = list(/datum/reagent/toxin/mindbreaker = 5)
	required_reagents = list(/datum/reagent/silicon = 1, /datum/reagent/hydrogen = 1, /datum/reagent/medicine/c2/multiver = 1)
	mix_message = "A mistura se transforma em um líquido vermelho vívido."
	is_cold_recipe = FALSE
	required_temp = 100
	optimal_temp = 450
	overheat_temp = 900
	optimal_ph_min = 6
	optimal_ph_max = 14
	determin_ph_range = 3
	temp_exponent_factor = 2.5
	ph_exponent_factor = 2
	thermic_constant = 150
	H_ion_release = -0.06
	rate_up_lim = 15
	purity_min = 0.4
	reaction_flags = REACTION_CLEAR_INVERSE
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_OTHER

/datum/chemical_reaction/heparin
	results = list(/datum/reagent/toxin/heparin = 3)
	required_reagents = list(/datum/reagent/toxin/formaldehyde = 1, /datum/reagent/consumable/salt = 1, /datum/reagent/lithium = 1)
	mix_message = span_danger("A mistura diminui e perde toda a cor.")
	is_cold_recipe = FALSE
	required_temp = 100
	optimal_temp = 450
	overheat_temp = 800
	optimal_ph_min = 5
	optimal_ph_max = 9.5
	determin_ph_range = 3
	temp_exponent_factor = 2.5
	ph_exponent_factor = 2
	thermic_constant = 375
	H_ion_release = -0.6
	rate_up_lim = 10
	purity_min = 0.6
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_OTHER

/datum/chemical_reaction/rotatium
	results = list(/datum/reagent/toxin/rotatium = 3)
	required_reagents = list(/datum/reagent/toxin/mindbreaker = 1, /datum/reagent/teslium = 1, /datum/reagent/toxin/fentanyl = 1)
	mix_message = span_danger("Após faíscas, fogo, e o cheiro de quebra-cabeças, a mistura está constantemente girando sem parar à vista.")
	is_cold_recipe = FALSE
	required_temp = 100
	optimal_temp = 450
	overheat_temp = 900
	optimal_ph_min = 3
	optimal_ph_max = 9
	determin_ph_range = 2.5
	temp_exponent_factor = 2.5
	ph_exponent_factor = 2
	thermic_constant = -425
	H_ion_release = 4
	rate_up_lim = 15
	purity_min = 0.6
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_TOXIN | REACTION_TAG_OTHER

/datum/chemical_reaction/anacea
	results = list(/datum/reagent/toxin/anacea = 3)
	required_reagents = list(/datum/reagent/medicine/haloperidol = 1, /datum/reagent/impedrezene = 1, /datum/reagent/uranium/radium = 1)
	mix_message = "A mistura se transforma em uma estrela lama verde."
	is_cold_recipe = FALSE
	required_temp = 100
	optimal_temp = 450
	overheat_temp = 900
	optimal_ph_min = 6
	optimal_ph_max = 9
	determin_ph_range = 4
	temp_exponent_factor = 1.6
	ph_exponent_factor = 2.4
	thermic_constant = 250
	H_ion_release = 3
	rate_up_lim = 10
	purity_min = 0.7
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_TOXIN | REACTION_TAG_OTHER

/datum/chemical_reaction/mimesbane
	results = list(/datum/reagent/toxin/mimesbane = 3)
	required_reagents = list(/datum/reagent/uranium/radium = 1, /datum/reagent/toxin/mutetoxin = 1, /datum/reagent/consumable/nothing = 1)
	mix_message = "A mistura se transforma em um branco indescritível."
	is_cold_recipe = FALSE
	required_temp = 100
	optimal_temp = 450
	overheat_temp = 900
	optimal_ph_min = 0
	optimal_ph_max = 8
	determin_ph_range = 4
	temp_exponent_factor = 1.5
	ph_exponent_factor = 3
	thermic_constant = -400
	H_ion_release = -2
	rate_up_lim = 15
	purity_min = 0.5
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_OTHER

/datum/chemical_reaction/bonehurtingjuice
	results = list(/datum/reagent/toxin/bonehurtingjuice = 5)
	required_reagents = list(/datum/reagent/toxin/mutagen = 1, /datum/reagent/toxin/itching_powder = 3, /datum/reagent/consumable/milk = 1)
	mix_message = span_danger("A mistura de repente se torna clara e parece muito com água. Você sente uma forte vontade de beber.")
	is_cold_recipe = FALSE
	required_temp = 100
	optimal_temp = 450
	overheat_temp = 900
	optimal_ph_min = 5
	optimal_ph_max = 9
	determin_ph_range = 3
	temp_exponent_factor = 0.5
	ph_exponent_factor = 1
	thermic_constant = -400
	H_ion_release = -0.4
	rate_up_lim = 15
	purity_min = 0.4
	reaction_flags = REACTION_PH_VOL_CONSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DAMAGING | REACTION_TAG_OTHER
