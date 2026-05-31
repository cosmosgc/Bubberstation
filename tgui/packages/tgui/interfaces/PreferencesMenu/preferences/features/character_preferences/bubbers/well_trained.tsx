// THIS IS A BUBBER UI FILE #BUBBERGANG😝
import { CheckboxInput, type Feature } from '../../base';

export const well_trained__prefers_males: Feature<boolean> = {
  name: 'Subs Para Ele',
  component: CheckboxInput,
};

export const well_trained__prefers_females: Feature<boolean> = {
  name: 'Substitua-a',
  component: CheckboxInput,
};

export const well_trained__prefers_plurals: Feature<boolean> = {
  name: 'Subs Para Eles/Eles',
  component: CheckboxInput,
};

export const well_trained__prefers_neuters: Feature<boolean> = {
  name: 'Subs para ele / Its',
  component: CheckboxInput,
};

export const well_trained__prefers_other: Feature<boolean> = {
  name: 'Subs A qualquer outro gênero',
  component: CheckboxInput,
};

export const well_trained__snap: Feature<boolean> = {
  name: 'Ser comandado com *snap',
  component: CheckboxInput,
};

export const well_trained__snap2: Feature<boolean> = {
  name: 'Seja comandado com *snap2',
  component: CheckboxInput,
};

export const well_trained__snap3: Feature<boolean> = {
  name: 'Seja comandado com *snap3',
  component: CheckboxInput,
};

export const well_trained__clicker: Feature<boolean> = {
  name: 'Seja comandado com Clicker',
  component: CheckboxInput,
};

export const well_trained__sub_inspect_dom: Feature<boolean> = {
  name: 'Seja embalado ao examinar Dom',
  component: CheckboxInput,
  description:
    'Se descontrolado, você não vai corar e virar quando inspecionar um Dom compatível.',
};

export const well_trained__sub_sense_dom: Feature<boolean> = {
  name: 'Dom Senso',
  component: CheckboxInput,
  description:
    'Se descontrolado, você não será alertado para a presença de doms compatíveis automaticamente, e não irá receber um moodlet positivo por estar perto deles.',
};
