import { CheckboxInput, type FeatureToggle } from '../base';

export const chat_bankcard: FeatureToggle = {
  name: 'Ativar atualizações de renda',
  category: 'CHAT',
  description: 'Receba notificações para sua conta bancária.',
  component: CheckboxInput,
};

export const chat_dead: FeatureToggle = {
  name: 'Activar o bate-papo',
  category: 'ADMIN',
  component: CheckboxInput,
};

export const chat_ghostears: FeatureToggle = {
  name: 'Ouça todas as mensagens.',
  category: 'GHOST',
  description: `
    When enabled, you will be able to hear all speech as a ghost.
    When disabled, you will only be able to hear nearby speech.
  `,
  component: CheckboxInput,
};

export const chat_ghostlaws: FeatureToggle = {
  name: 'Ativar mudanças de lei',
  category: 'GHOST',
  description: 'Quando habilitado, ser notificado de qualquer nova lei muda como um fantasma.',
  component: CheckboxInput,
};

export const chat_ghostpda: FeatureToggle = {
  name: 'Activar notificações PDA',
  category: 'GHOST',
  description: 'Quando habilitado, ser notificado de qualquer mensagem PDA como um fantasma.',
  component: CheckboxInput,
};

export const chat_ghostradio: FeatureToggle = {
  name: 'Activar rádio',
  category: 'GHOST',
  description: 'Quando habilitado, ser notificado de qualquer mensagem de rádio como um fantasma.',
  component: CheckboxInput,
};

export const chat_ghostsight: FeatureToggle = {
  name: 'Veja todos os emotes.',
  category: 'GHOST',
  description: 'Quando habilitado, veja todos os emotes como um fantasma.',
  component: CheckboxInput,
};

export const chat_ghostwhisper: FeatureToggle = {
  name: 'Veja todos os sussurros',
  category: 'GHOST',
  description: `
    When enabled, you will be able to hear all whispers as a ghost.
    When disabled, you will only be able to hear nearby whispers.
  `,
  component: CheckboxInput,
};

export const chat_login_logout: FeatureToggle = {
  name: 'Veja mensagens de login/logout',
  category: 'GHOST',
  description: 'Quando habilitado, ser notificado quando um jogador entra ou sai.',
  component: CheckboxInput,
};

export const chat_ooc: FeatureToggle = {
  name: 'Activar COO',
  category: 'CHAT',
  component: CheckboxInput,
};

export const chat_prayer: FeatureToggle = {
  name: 'Ouça as orações.',
  category: 'ADMIN',
  component: CheckboxInput,
};

export const chat_pullr: FeatureToggle = {
  name: 'Activar as notificações de pedidos',
  category: 'CHAT',
  description: 'Ser notificado quando um pedido for feito, fechado ou fundido.',
  component: CheckboxInput,
};
