import {
  CheckboxInput,
  FeatureNumberInput,
  type FeatureNumeric,
  type FeatureToggle,
} from '../base';

export const chat_on_map: FeatureToggle = {
  name: 'Activar o Runechat',
  category: 'RUNECHAT',
  description: 'Mensagens de bate-papo vão aparecer acima das cabeças.',
  component: CheckboxInput,
};

export const see_chat_non_mob: FeatureToggle = {
  name: 'Activar o Runechat em objectos',
  category: 'RUNECHAT',
  description: 'Mensagens de bate-papo mostrarão objetos acima quando falarem.',
  component: CheckboxInput,
};

export const chat_on_ghosts: FeatureToggle = {
  name: 'Active Runechat em fantasmas.',
  category: 'RUNECHAT',
  description: 'Mensagens de bate-papo mostrarão acima dos fantasmas quando falarem.',
  component: CheckboxInput,
};

export const see_rc_emotes: FeatureToggle = {
  name: 'Activar emoções de Runechat',
  category: 'RUNECHAT',
  description: 'Emotos aparecerão acima das cabeças.',
  component: CheckboxInput,
};

export const max_chat_length: FeatureNumeric = {
  name: 'Max bate-papo',
  category: 'RUNECHAT',
  description: 'O comprimento máximo que uma mensagem Runechat mostrará.',
  component: FeatureNumberInput,
};
