export const PHYSICALSTATUS2ICON = {
  Active: 'person-running',
  Debilitated: 'crutch',
  Unconscious: 'moon-o',
  Deceased: 'skull',
};

export const PHYSICALSTATUS2COLOR = {
  Active: 'green',
  Debilitated: 'purple',
  Unconscious: 'orange',
  Deceased: 'red',
} as const;

export const PHYSICALSTATUS2DESC = {
  Active: 'Ativo. O indivíduo é consciente e saudável.',
  Debilitated: 'Debilitado. O indivíduo está consciente, mas não saudável.',
  Unconscious: 'Inconsciente. O indivíduo pode precisar de cuidados médicos.',
  Deceased: 'Morto. O indivíduo morreu e começou a se deteriorar.',
} as const;

export const MENTALSTATUS2ICON = {
  Stable: 'face-smile-o',
  Watch: 'eye-o',
  Unstable: 'scale-unbalanced-flip',
  Insane: 'head-side-virus',
};

export const MENTALSTATUS2COLOR = {
  Stable: 'green',
  Watch: 'purple',
  Unstable: 'orange',
  Insane: 'red',
} as const;

export const MENTALSTATUS2DESC = {
  Stable: 'Estável. O indivíduo é são e livre de distúrbios psicológicos.',
  Watch:
    'Veja. O indivíduo tem sintomas de doença mental. Monitore-os de perto.',
  Unstable: 'Instável. O indivíduo tem uma ou mais doenças mentais.',
  Insane: 'Louco. Individual exibe comportamentos mentais graves e anormais.',
} as const;
