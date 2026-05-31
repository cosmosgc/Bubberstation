export const ANTAG2COLOR = {
  Abductors: 'pink',
  'Ash Walkers.': 'olive',
  Biohazards: 'brown',
  'Caçadores de recompensas': 'yellow',
  CentCom: 'teal',
  'Anomalias digitais': 'teal',
  'Equipe de Resposta de Emergência': 'teal',
  'Fugitivos Escapados': 'orange',
  'Infestação Xenomorph': 'violet',
  'Aberrações no espaço-tempo': 'white',
  'Equipe Disiant': 'white',
  'Overgrowth invasivo': 'green',
} as const;

type Department = {
  color: string;
  trims: string[];
};

export const DEPARTMENT2COLOR: Record<string, Department> = {
  cargo: {
    color: 'brown',
    trims: ['Bitrunner', 'Técnico de Carga', 'Shaft Miner', 'Quartermaster', 'Blacksmith', 'Agente da Alfândega' ],
    // BUBBER EDIT ADDITION - Blacksmith, Customs Agent
  },
  command: {
    color: 'blue',
    trims: ['Captain', 'Chefe de Pessoal', 'Consultor Nanotrasen', 'Blueshield', 'Assistente da Ponte.'],
    // BUBBER EDIT ADDITION - Nanotrasen Consultant, Blueshield, Bridge Assistant
  },
  engineering: {
    color: 'orange',
    trims: ['Técnico Atmosférico', 'Engenheiro Chefe.', 'Engenheiro de Estação.', 'Especialista em Telecomms', 'Guarda de Engenharia.'],
    // BUBBER EDIT ADDITION - Telecomms Specialist, Engineering Guard
  },
  medical: {
    color: 'teal',
    trims: [
      'Chemist',
      'Oficial Médico Chefe.',
      'Coroner',
      'Médico',
      'Paramedic',
      'Orderly',  // BUBBER EDIT ADDITION
    ],
  },
  science: {
    color: 'pink',
    trims: ['Geneticist', 'Diretor de Pesquisa', 'Roboticist', 'Scientist', 'Guarda da Ciência'],
    // BUBBER EDIT ADDITION - Science Guard
  },
  security: {
    color: 'red',
    trims: ['Detective', 'Chefe de Segurança', 'Oficial de Segurança.', 'Warden', 'Médico de Segurança', 'Oficial de Correções.'],
    // BUBBER EDIT ADDITION - Security Medic, Corrections Officer
  },
  service: {
    color: 'green',
    trims: [
      'Bartender',
      'Botanist',
      'Chaplain',
      'Chef',
      'Clown',
      'Cook',
      'Curator',
      'Janitor',
      'Lawyer',
      'Mime',
      'Psychologist',
      'Barber',  // BUBBER EDIT ADDITION
      'Bouncer',  // BUBBER EDIT ADDITION
    ],
  },
};

export const THREAT = {
  Low: 1,
  Medium: 5,
  High: 8,
} as const;

export const HEALTH = {
  Good: 69, // nice
  Average: 19,
  Bad: 0,
  Crit: -30,
  Dead: -100,
  Ruined: -200,
} as const;

export const VIEWMODE = {
  Health: 'heart',
  Orbiters: 'ghost',
  Department: 'id-badge',
} as const;
