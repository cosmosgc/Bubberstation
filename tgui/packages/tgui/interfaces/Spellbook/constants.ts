import { EnscribedName } from './EnscribedName';
import { Loadouts } from './Loadouts';
import { Randomize } from './Randomize';
import { TableOfContents } from './TableOfContents';
import type { TabType } from './types';

export const TAB2NAME: TabType[] = [
  {
    title: 'Nome escrito',
    blurb:
      "Este livro só responde ao seu dono, e claro, deve ter um. A permanência do pacto entre um livro de feitiços e seu dono garante que um artefato tão poderoso não pode cair em mãos inimigas, ou ser usado de maneiras que quebram as regras da Federação, como a troca de feitiços.",
    component: EnscribedName,
  },
  {
    title: 'Sumário',
    component: TableOfContents,
  },
  {
    title: 'Offensive',
    blurb: 'Feitiços e itens voltados para debilitar e destruir.',
    scrollable: true,
  },
  {
    title: 'Defensive',
    blurb:
      "Feitiços e itens direcionados para melhorar sua sobrevivência ou reduzir a habilidade de inimigos para atacar.",
    scrollable: true,
  },
  {
    title: 'Mobility',
    blurb:
      'Feitiços e itens voltados para melhorar sua habilidade de se mover. É uma boa ideia tomar pelo menos uma.',
    scrollable: true,
  },
  {
    title: 'Assistance',
    blurb:
      'Feitiços e itens voltados para trazer forças externas para ajudá-lo ou melhorar seus outros itens e habilidades.',
    scrollable: true,
  },
  {
    title: 'Challenges',
    blurb:
      'A Federação Mágica está procurando por mostras de poder. Armar a estação contra você aumentará o perigo, mas lhe concederá mais acusações pelo seu livro de feitiços.',
    locked: true,
    scrollable: true,
  },
  {
    title: 'Rituals',
    blurb:
      'Esses feitiços poderosos mudam o próprio tecido da realidade. Nem sempre a seu favor.',
    scrollable: true,
  },
  {
    title: 'Loadouts',
    blurb:
      'A Federação Mágica aceita que, às vezes, escolher é difícil. Pode escolher entre alguns feiticeiros aprovados.',
    component: Loadouts,
  },
  {
    title: 'Randomize',
    blurb:
      "Se você não gostou da carga oferecida, você pode abraçar o caos. Não recomendado para bruxos mais novos.",
    component: Randomize,
  },
  {
    title: 'Perks',
    blurb:
      'As vantagens são úteis (e não tão úteis) melhorias na alma e no corpo coletados de todos os cantos do universo.',
    scrollable: true,
  },
  {
    title: 'Sumário',
    component: TableOfContents,
  },
];

export const BUYWORD2ICON = {
  Learn: 'plus',
  Summon: 'hat-wizard',
  Cast: 'meteor',
};
