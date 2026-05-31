// THIS IS A BUBBER UI FILE #BUBBERGANG😝
import { CheckboxInput, type Feature } from '../../base';

export const dom_aura__prefers_males: Feature<boolean> = {
  name: 'É Dom para ele',
  component: CheckboxInput,
};

export const dom_aura__prefers_females: Feature<boolean> = {
  name: 'É Dom para ela',
  component: CheckboxInput,
};

export const dom_aura__prefers_plurals: Feature<boolean> = {
  name: 'É Dom para eles/eles',
  component: CheckboxInput,
};

export const dom_aura__prefers_neuters: Feature<boolean> = {
  name: 'É Dom para ele / É',
  component: CheckboxInput,
};

export const dom_aura__prefers_other: Feature<boolean> = {
  name: 'É Dom para qualquer outro gênero',
  component: CheckboxInput,
};

export const dom_aura__snap: Feature<boolean> = {
  name: 'Subalternos de comando com *snap',
  component: CheckboxInput,
};

export const dom_aura__snap2: Feature<boolean> = {
  name: 'Subalternos de comando com *snap2',
  component: CheckboxInput,
};

export const dom_aura__snap3: Feature<boolean> = {
  name: 'Subalternos de comando com *snap3',
  component: CheckboxInput,
};

export const dom_aura__clicker: Feature<boolean> = {
  name: 'Subs de Comando com Clicker',
  component: CheckboxInput,
};

export const dom_aura__sub_inspect_dom: Feature<boolean> = {
  name: 'Embalass Subs Se eles examinam você',
  component: CheckboxInput,
  description:
    'Se não forem verificados, submarinos compatíveis não corarão e virarão quando inspecionarem você.',
};

export const dom_aura__sub_sense_dom: Feature<boolean> = {
  name: 'Aura',
  component: CheckboxInput,
  description:
    'Se não forem checados, submarinos compatíveis não serão alertados para sua presença automaticamente, e não receberão uma permissão positiva para estar perto de você.',
};
