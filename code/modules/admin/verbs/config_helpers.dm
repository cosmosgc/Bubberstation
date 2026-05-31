#define GENERATE_JOB_CONFIG_VERB_DESC "Generate a job configuration (jobconfig.toml) file for the server. If TOML file already exists, will re-generate it based off the already existing config values. Will migrate from the old jobs.txt format if necessary."

ADMIN_VERB(generate_job_config, R_SERVER, "Generate Job Configuration", GENERATE_JOB_CONFIG_VERB_DESC, ADMIN_CATEGORY_SERVER)
	if(tgui_alert(user, "Este verbo não é útil se você não é um operador de servidor com acesso à pasta de configuração. Deseja continuar?", "Generate jobconfig.toml for download", list("Yes", "No")) != "Yes")
		return

	if(SSjob.generate_config(user))
		to_chat(user, span_notice("Arquivo de configuração de trabalho gerado. O download deve aparecer agora."))
	else
		to_chat(user, span_warning("O arquivo de configuração do trabalho não pôde ser gerado. Verifique os registros/runtimes do servidor / mensagens de aviso acima para mais informações."))

	BLACKBOX_LOG_ADMIN_VERB("Generate Job Configuration")

#undef GENERATE_JOB_CONFIG_VERB_DESC
