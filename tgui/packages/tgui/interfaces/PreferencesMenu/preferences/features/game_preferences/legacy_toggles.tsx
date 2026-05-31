import {
  CheckboxInput,
  CheckboxInputInverse,
  type FeatureToggle,
} from '../base';

export const admin_ignore_cult_ghost: FeatureToggle = {
  name: 'Evitar ser convocado como um fantasma de culto',
  category: 'ADMIN',
  description: `
    When enabled and observing, prevents Spirit Realm from forcing you
    into a cult ghost.
  `,
  component: CheckboxInput,
};

export const announce_login: FeatureToggle = {
  name: 'Anunciar login',
  category: 'ADMIN',
  description: 'Os administradores serão notificados quando você fizer login.',
  component: CheckboxInput,
};

export const combohud_lighting: FeatureToggle = {
  name: 'Activar total Bright Combo HUD',
  category: 'ADMIN',
  component: CheckboxInput,
};

export const deadmin_always: FeatureToggle = {
  name: 'Auto Deadmin - Sempre',
  category: 'ADMIN',
  description: 'Quando habilitado, você automaticamente deadmin.',
  component: CheckboxInput,
};

export const deadmin_antagonist: FeatureToggle = {
  name: 'Auto Deadmin - Antagonista',
  category: 'ADMIN',
  description: 'Quando habilitado, você automaticamente será um antagonista.',
  component: CheckboxInput,
};

export const deadmin_position_head: FeatureToggle = {
  name: 'Auto Deadmin - Chefe de Gabinete',
  category: 'ADMIN',
  description:
    'Quando habilitado, você automaticamente será o chefe da equipe.',
  component: CheckboxInput,
};

export const deadmin_position_security: FeatureToggle = {
  name: 'Auto Deadmin - Segurança',
  category: 'ADMIN',
  description:
    'Quando habilitado, você automaticamente será um membro da segurança.',
  component: CheckboxInput,
};

export const deadmin_position_silicon: FeatureToggle = {
  name: 'Auto Deadmin - Silício',
  category: 'ADMIN',
  description: 'Quando ativado, você automaticamente será morto como um silício.',
  component: CheckboxInput,
};

export const disable_arrivalrattle: FeatureToggle = {
  name: 'Avise os recém-chegados.',
  category: 'GHOST',
  description: 'Quando habilitado, você será notificado como um fantasma para nova tripulação.',
  component: CheckboxInputInverse,
};

export const disable_deathrattle: FeatureToggle = {
  name: 'Avise as mortes.',
  category: 'GHOST',
  description:
    'Quando habilitado, você será notificado como um fantasma sempre que alguém morrer.',
  component: CheckboxInputInverse,
};

export const member_public: FeatureToggle = {
  name: 'Publicar a associação BYOND',
  category: 'CHAT',
  description:
    'Quando habilitado, um logotipo da BYOND será mostrado ao lado do seu nome na OOC.',
  component: CheckboxInput,
};

export const sound_adminhelp: FeatureToggle = {
  name: 'Activar sons de ajuda administrativa',
  category: 'ADMIN',
  component: CheckboxInput,
};

export const sound_prayers: FeatureToggle = {
  name: 'Activar som de oração',
  category: 'ADMIN',
  component: CheckboxInput,
};

export const split_admin_tabs: FeatureToggle = {
  name: 'Dividir as abas de administração',
  category: 'ADMIN',
  description: "Quando habilitado, dividirá o painel 'Admin' em várias abas.",
  component: CheckboxInput,
};
