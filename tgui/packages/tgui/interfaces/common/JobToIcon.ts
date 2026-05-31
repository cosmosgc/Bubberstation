export type AvailableJob = keyof typeof JOB2ICON;

/** Icon map of jobs to their fontawesome5 (free) counterpart. */
// SKYRAT EDIT START - ORIGINAL: export const JOB2ICONs = {
const BASEICONS = {
  // SKYRAT EDIT - END
  AI: 'eye',
  Assistant: 'toolbox',
  'Técnico Atmosférico': 'fan',
  Bartender: 'cocktail',
  'Bit Avatar': 'code',
  Bitrunner: 'gamepad',
  Botanist: 'seedling',
  Blacksmith: 'hammer', // BUBBER EDIT
  'Assistente da Ponte.': 'building-shield',
  Captain: 'crown',
  'Carga Gorila': 'paw',
  'Técnico de Carga': 'box',
  'Comandante CentCom.': 'star',
  'Estágio Chefe da CentCom': 'pen-fancy',
  'Estagiário CentCom': 'pen-alt',
  'Oficial da CentCom': 'medal',
  Chaplain: 'cross',
  Chef: 'utensils',
  Chemist: 'prescription-bottle',
  'Engenheiro Chefe.': 'user-astronaut',
  'Oficial Médico Chefe.': 'user-md',
  Clown: 'face-grin-tears',
  Cook: 'utensils',
  Coroner: 'skull',
  Curator: 'book',
  'Polícia cibernética': 'qrcode',
  Cyborg: 'robot',
  Detective: 'user-secret',
  Geneticist: 'dna',
  'Chefe de Pessoal': 'dog',
  'Chefe de Segurança': 'user-shield',
  'Grande Irmão.': 'eye',
  Janitor: 'soap',
  Lawyer: 'gavel',
  'Médico': 'staff-snake',
  Mime: 'comment-slash',
  Paramedic: 'truck-medical',
  'AI pesoal': 'mobile-alt',
  Prisoner: 'lock',
  Psychologist: 'brain',
  Quartermaster: 'sack-dollar',
  'Diretor de Pesquisa': 'user-graduate',
  Roboticist: 'battery-half',
  Scientist: 'flask',
  Stowaway: 'person-running', // BUBBER EDIT
  'Oficial de Segurança (Carga)': 'shield-halved',
  'Oficial de Segurança (Engenharia)': 'shield-halved',
  'Oficial de Segurança (Medical)': 'shield-halved',
  'Oficial de Segurança (Ciência)': 'shield-halved',
  'Oficial de Segurança.': 'shield-halved',
  'Shaft Miner': 'digging',
  'Engenheiro de Estação.': 'gears',
  'Sindicar agente': 'dragon',
  'Conselheiro de Segurança Veterano': 'wheelchair', // BUBBER EDIT
  'Pun': 'paw',
  Warden: 'handcuffs',
  // SKYRAT EDIT START - Skyrat-exclusive jobs have icons too

  'Especialista em Telecomms': 'tower-cell',
  Barber: 'scissors',
  Blueshield: 'shield-dog',
  Bouncer: 'shield-heart',
  'Oficial de Correções.': 'hands-bound',
  'Agente da Alfândega': 'shield-heart',
  'Guarda de Engenharia.': 'shield-heart',
  'Consultor Nanotrasen': 'clipboard-check',
  Orderly: 'shield-heart',
  'Guarda da Ciência': 'shield-heart',
  'Médico de Segurança': 'heart-pulse',
  Virologist: 'virus',
  // SKYRAT EDIT END
} as const;

// SKYRAT EDIT START - ALT TITLES
const ALTTITLES = {
  // AI - eye
  'Inteligência da Estação': BASEICONS.AI,
  'Supervisor Automático': BASEICONS.AI,
  // Assistant - toolbox
  Civilian: BASEICONS.Assistant,
  Tourist: BASEICONS.Assistant,
  Businessman: BASEICONS.Assistant,
  Businesswoman: BASEICONS.Assistant,
  Trader: BASEICONS.Assistant,
  Entertainer: BASEICONS.Assistant,
  Freelancer: BASEICONS.Assistant,
  Artist: BASEICONS.Assistant,
  'Off-Duty Staff': BASEICONS.Assistant,
  'Equipe Fora do Serviço': BASEICONS.Assistant,
  // Atmospheric Technician - fan
  'Técnico de Suporte à Vida': BASEICONS['Técnico Atmosférico'],
  'Técnico de Fogo de Emergência': BASEICONS['Técnico Atmosférico'],
  Firefighter: BASEICONS['Técnico Atmosférico'],
  // Barber - scissors
  'Gerente de Salão': BASEICONS.Barber,
  'Técnico de Salão': BASEICONS.Barber,
  Stylist: BASEICONS.Barber,
  Colorist: BASEICONS.Barber,
  // Bartender - cocktail
  Mixologist: BASEICONS.Bartender,
  Barkeeper: BASEICONS.Bartender,
  Barista: BASEICONS.Bartender,
  // Blueshield - shield-dog
  'Comando do guarda-costas.': BASEICONS.Blueshield,
  'Agente Executivo de Proteção': BASEICONS.Blueshield,
  'Oficial de Proteção do Comando.': BASEICONS.Blueshield,
  Henchman: BASEICONS.Blueshield,
  // Botanist - seedling
  Hydroponicist: BASEICONS.Botanist,
  Gardener: BASEICONS.Botanist,
  'Pesquisador Botânico': BASEICONS.Botanist,
  Herbalist: BASEICONS.Botanist,
  Florist: BASEICONS.Botanist,
  // Bouncer - shield-heart
  'Guarda de serviço.': BASEICONS.Bouncer,
  // Captain - crown
  'Comandante da Estação.': BASEICONS.Captain,
  'Comandante.': BASEICONS.Captain,
  'Gerente fazer site': BASEICONS.Captain,
  // Cargo Technician - box
  'Técnico de Depósitos': BASEICONS['Técnico de Carga'],
  'Trabalhor de Deck': BASEICONS['Técnico de Carga'],
  Mailman: BASEICONS['Técnico de Carga'],
  'Sócio da União': BASEICONS['Técnico de Carga'],
  'Inventário Associado': BASEICONS['Técnico de Carga'],
  // Chaplain - cross
  Priest: BASEICONS.Chaplain,
  Preacher: BASEICONS.Chaplain,
  Reverend: BASEICONS.Chaplain,
  Oracle: BASEICONS.Chaplain,
  Pontifex: BASEICONS.Chaplain,
  Magister: BASEICONS.Chaplain,
  'Sumo Sacerdote.': BASEICONS.Chaplain,
  Imam: BASEICONS.Chaplain,
  Rabbi: BASEICONS.Chaplain,
  Monk: BASEICONS.Chaplain,
  // Chemist - prescription-bottle
  Pharmacist: BASEICONS.Chemist,
  Pharmacologist: BASEICONS.Chemist,
  'Farmacêutico Estagiário': BASEICONS.Chemist,
  // Chief Engineer - user-astronaut
  'Engenharia Foreman': BASEICONS['Engenheiro Chefe.'],
  'Chefe de Engenharia': BASEICONS['Engenheiro Chefe.'],
  // Chief Medical Officer - user-md
  'Diretor Médico': BASEICONS['Oficial Médico Chefe.'],
  'Chefe de Medicina': BASEICONS['Oficial Médico Chefe.'],
  'Médico Chefe.': BASEICONS['Oficial Médico Chefe.'],
  'Médico Chefe.': BASEICONS['Oficial Médico Chefe.'],
  // Clown - face-grin-tears
  Jester: BASEICONS.Clown,
  Joker: BASEICONS.Clown,
  Comedian: BASEICONS.Clown,
  // Cook/Chef - utensils
  Butcher: BASEICONS.Cook,
  'Artista Culinária': BASEICONS.Cook,
  'Sous-Chef': BASEICONS.Cook,
  // Coroner - skull
  Mortician: BASEICONS.Coroner,
  'Diretor funerário': BASEICONS.Coroner,
  // Curator - book
  Librarian: BASEICONS.Curator,
  Journalist: BASEICONS.Curator,
  Archivist: BASEICONS.Curator,
  // Cyborg - robot
  Robot: BASEICONS.Cyborg,
  Android: BASEICONS.Cyborg,
  // Detective - user-secret
  'Técnico forense': BASEICONS.Detective,
  'Investigador Privado': BASEICONS.Detective,
  'Cientista Forense': BASEICONS.Detective,
  'Oficial da CID': BASEICONS.Detective,
  // Geneticist - dna
  'Pesquisador de Mutação': BASEICONS.Geneticist,
  // Head of Personnel - dog
  'Executivo oficial.': BASEICONS['Chefe de Pessoal'],
  'Oficial de Emprego.': BASEICONS['Chefe de Pessoal'],
  'Supervisor da tripulação': BASEICONS['Chefe de Pessoal'],
  // Head of Security - user-shield
  'Comandante de Segurança.': BASEICONS['Chefe de Segurança'],
  'Chefe de Polícia.': BASEICONS['Chefe de Segurança'],
  'Chefe de Segurança.': BASEICONS['Chefe de Segurança'],
  Sheriff: BASEICONS['Chefe de Segurança'],
  // Janitor - soap
  Custodian: BASEICONS.Janitor,
  'Técnico de custódia': BASEICONS.Janitor,
  'Técnico de Saneamento': BASEICONS.Janitor,
  'Técnico de Manutenção': BASEICONS.Janitor,
  Concierge: BASEICONS.Janitor,
  Maid: BASEICONS.Janitor,
  // Lawyer - gavel
  'Agente da Corregedoria': BASEICONS.Lawyer,
  'Agente de Recursos Humanos': BASEICONS.Lawyer,
  'Advogado de Defesa.': BASEICONS.Lawyer,
  'Defensor Público': BASEICONS.Lawyer,
  Barrister: BASEICONS.Lawyer,
  Prosecutor: BASEICONS.Lawyer,
  'Oficial Jurídico.': BASEICONS.Lawyer,
  // Medical Doctor - staff-snake
  Surgeon: BASEICONS['Médico'],
  Nurse: BASEICONS['Médico'],
  'Praticante Geral': BASEICONS['Médico'],
  'Médico residente.': BASEICONS['Médico'],
  Pathologist: 'virus',
  'Patólogo Júnior': 'virus',
  Physician: BASEICONS['Médico'],
  // Mime - comment-slash
  Pantomimist: BASEICONS.Mime,
  // Nanotrasen Consultant - clipboard-check
  'Nanotrasen Diplomat': BASEICONS['Consultor Nanotrasen'],
  'Consultora Corporativa': BASEICONS['Consultor Nanotrasen'],
  // Paramedic - truck-medical
  'Técnico Médico de Emergência.': BASEICONS.Paramedic,
  'Técnico de Busca e Resgate': BASEICONS.Paramedic,
  // Prisoner - lock
  'Prisioneiro de Segurança Mínima': BASEICONS.Prisoner,
  'Prisioneiro de Segurança Máxima': BASEICONS.Prisoner,
  'Prisioneiro de Segurança SuperMax': BASEICONS.Prisoner,
  'Prisioneiro de custódia protetora': BASEICONS.Prisoner,
  Convict: BASEICONS.Prisoner,
  Felon: BASEICONS.Prisoner,
  Inmate: BASEICONS.Prisoner,
  // Psychologist - brain
  Psychiatrist: BASEICONS.Psychologist,
  Therapist: BASEICONS.Psychologist,
  Counsellor: BASEICONS.Psychologist,
  // Quartermaster - sack-dollar
  'Oficial de Requisições da União': BASEICONS.Quartermaster,
  'Chefe do convés.': BASEICONS.Quartermaster,
  'Supervisor do Depósito': BASEICONS.Quartermaster,
  'Foreman de Fornecimento': BASEICONS.Quartermaster,
  'Chefe de Abastecimento': BASEICONS.Quartermaster,
  'Coordenador de Logística': BASEICONS.Quartermaster,
  // Research Director - user-graduate
  'Administrador de Silício': BASEICONS['Diretor de Pesquisa'],
  'Pesquisador Chefe': BASEICONS['Diretor de Pesquisa'],
  'Diretor Biorobótico': BASEICONS['Diretor de Pesquisa'],
  'Supervisor de Pesquisa': BASEICONS['Diretor de Pesquisa'],
  'Chefe de Ciência': BASEICONS['Diretor de Pesquisa'],
  // Roboticist - battery-half
  'Engenheiro biomecânico': BASEICONS.Roboticist,
  'Engenheiro Mecatrônico': BASEICONS.Roboticist,
  'Aprendiz Roboticista': BASEICONS.Roboticist,
  // Scientist - flask
  'Designer de Circuitos': BASEICONS.Scientist,
  Xenobiologist: BASEICONS.Scientist,
  Cytologist: BASEICONS.Scientist,
  'Pesquisador de Plasma': BASEICONS.Scientist,
  Anomalist: BASEICONS.Scientist,
  'Técnico de Laboratório': BASEICONS.Scientist,
  'Físico Teórico': BASEICONS.Scientist,
  'Técnico de artilharia': BASEICONS.Scientist,
  Xenoarchaeologist: BASEICONS.Scientist,
  'Ajudante de Pesquisa': BASEICONS.Scientist,
  'Estudante Graduado': BASEICONS.Scientist,
  // Security Medic - heart-pulse
  'Médico de campo.': BASEICONS['Médico de Segurança'],
  'Médico de Segurança.': BASEICONS['Médico de Segurança'],
  'Médico Brig': BASEICONS['Médico de Segurança'],
  'Médico de Combate': BASEICONS['Médico de Segurança'],
  // Security Officer - shield-halved
  'Agente de Segurança': BASEICONS['Oficial de Segurança.'],
  'Especialista em Segurança': BASEICONS['Oficial de Segurança.'],
  'Contrator de Defesa': BASEICONS['Oficial de Segurança.'],
  Peacekeeper: BASEICONS['Oficial de Segurança.'],
  'Cadete de Segurança': BASEICONS['Oficial de Segurança.'],
  // Shaft Miner - digging
  'União Miner': BASEICONS['Shaft Miner'],
  Excavator: BASEICONS['Shaft Miner'],
  Spelunker: BASEICONS['Shaft Miner'],
  'Técnico de perfuração': BASEICONS['Shaft Miner'],
  Prospector: BASEICONS['Shaft Miner'],
  Dredger: BASEICONS['Shaft Miner'],
  'Contrato Miner': BASEICONS['Shaft Miner'],
  // Station Engineer - gears
  'Técnico de Controle de Danos de Emergência': BASEICONS['Engenheiro de Estação.'],
  Electrician: BASEICONS['Engenheiro de Estação.'],
  'Técnico de motores.': BASEICONS['Engenheiro de Estação.'],
  'Técnico EVA': BASEICONS['Engenheiro de Estação.'],
  Mechanic: BASEICONS['Engenheiro de Estação.'],
  'Engenheiro de Aprendizagem': BASEICONS['Engenheiro de Estação.'],
  'Treinador de Engenharia': BASEICONS['Engenheiro de Estação.'],
  // Telecomms Specialist - tower-cell
  'Engenheiro de Rede': BASEICONS['Especialista em Telecomms'],
  'Operadora sem fio.': BASEICONS['Especialista em Telecomms'],
  'Técnico de Tram': BASEICONS['Especialista em Telecomms'],
  Sysadmin: BASEICONS['Especialista em Telecomms'],
  // Warden - handcuffs
  'Sargento Brig.': BASEICONS.Warden,
  'Oficial da Central.': BASEICONS.Warden,
  'Brigadeiro Governador.': BASEICONS.Warden,
  Jailer: BASEICONS.Warden,
} as const;

// Combine the Base icons and ALt titles
export const JOB2ICON = { ...BASEICONS, ...ALTTITLES } as const;
// SKYRAT EDIT END
