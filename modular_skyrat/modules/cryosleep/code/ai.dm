/mob/living/silicon/ai/verb/ai_cryo()
	set name = "AI Cryogenic Stasis"
	set desc = "Puts the current AI personality into cryogenic stasis, freeing the space for another."
	set category = "AI Commands"

	if(incapacitated)
		return
	switch(alert("Gostaria de entrar em crio? Isso vai te assombrar. Lembre-se da AELP antes de sair de papéis importantes, mesmo sem administradores online.",,"Yes.","No."))
		if("Yes.")
			src.ghostize(FALSE)
			var/announce_rank = "Artificial Intelligence,"
			if(GLOB.announcement_systems.len)
				// Sends an announcement the AI has cryoed.
				var/obj/machinery/announcement_system/announcer = pick(GLOB.announcement_systems)
				announcer.announce("CRYOSTORAGE", src.real_name, announce_rank, list())
			new /obj/structure/ai_core/latejoin_inactive(loc)
			if(src.mind)
				//Handle job slot/tater cleanup.
				if(src.mind.assigned_role.title == JOB_AI)
					SSjob.FreeRole(JOB_AI)
			LAZYNULL(src.mind.special_roles)
			qdel(src)
		else
			return
