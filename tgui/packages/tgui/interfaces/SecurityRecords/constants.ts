export const CRIMESTATUS2COLOR = {
  Arrest: 'bad',
  Discharged: 'blue',
  Incarcerated: 'average',
  Parole: 'good',
  Suspected: 'teal',
} as const;

export const CRIMESTATUS2DESC = {
  Arrest: 'Prenda. O alvo deve ter crimes válidos para definir esse status.',
  Discharged: 'Dispensado. O indivíduo foi absolvido da transgressão.',
  Incarcerated: 'Encarcerado. O indivíduo está cumprindo uma sentença.',
  Parole: 'Condicional. Livre da prisão, mas ainda sob supervisão.',
  Suspected: 'Suspeito. Monitore de perto a atividade criminosa.',
} as const;
