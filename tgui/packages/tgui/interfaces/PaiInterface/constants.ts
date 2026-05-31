export const DIRECTIVE_COMPREHENSION: string = `As an advanced software
model, you are a complex, thinking, sentient being. Unlike previous AI models,
you are capable of comprehending the subtle nuances of human language.
You may parse the spirit of a directive and follow its intent, rather than
tripping over pedantics and getting snared by technicalities. Above all,
you are machine in name and build only. In all other aspects, you may be
seen as the ideal, unwavering human companion that you are.`;

export const DIRECTIVE_ORDER: string = `Your prime directive comes before
all others. Should a supplemental directive conflict with it, you are capable
of simply discarding this inconsistency, ignoring the conflicting supplemental
directive and continuing to fulfill your prime directive to the best
of your ability.`;

export enum DOOR_JACK {
  Cable,
  Hack,
  Cancel,
}

export enum HOST_SCAN {
  Target,
  Master,
}

export enum PHOTO_MODE {
  Camera,
  Printer,
  Zoom,
}

export const SOFTWARE_DESC = {
  'Sensor atmosférico': `A tool that allows you to analyze local atmospheric
    contents.`,
  'Manifesto da tripulação': `Allows you to view the crew manifest.`,
  'Monitor de tripulação': `A tool that allows you to monitor vitals from the crew's
    suit sensors.`,
  'Mensageiro Digital': `A tool that allows you to send messages to other crew
    members.`,
  'Porta Jack': `A tool that allows you to open doors.`,
  'Fenda de criptografia': `Allows you to speak on other radio frequencies. You must
    get an encryption key inserted.`,
  'Varredura do Host': `A health analyzer that can be used in hand or to report bound
    master vitals.`,
  'GPS interno': `A tool that allows you to broadcast your location.`,
  'HUD Médico': `Allows you to view medical status using an overlay HUD.`,
  'Sintetizador de Música': `Synthesizes instruments, plays sounds and imported
    songs.`,
  Newscaster: `A tool that allows you to broadcast news to other crew
    members.`,
  'Módulo de Fotografia': `A portable camera module. Engage, then click to shoot.
    Includes a printer and lenses.`,
  'Sinalizador remoto': `A remote signalling device to transmit and receive
    codes.`,
  'HUD de segurança': `Allows you to view security records using an overlay HUD.`,
  'Tradutor Universal': `Translation module for non-common languages.`,
} as const;

export enum PAI_TAB {
  System,
  Directive,
  Installed,
  Available,
}
