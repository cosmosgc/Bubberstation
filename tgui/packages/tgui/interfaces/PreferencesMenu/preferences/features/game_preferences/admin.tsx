import {
  CheckboxInput,
  type Feature,
  FeatureColorInput,
  type FeatureToggle,
} from '../base';
import { FeatureDropdownInput } from '../dropdowns';

// BUBBER EDIT ADDITION START
export const use_tgui_player_panel: FeatureToggle = {
  name: 'Use o painel do jogador moderno.',
  category: 'ADMIN',
  description: 'Use o novo painel de jogadores do TGUI ou o antigo HTML.',
  component: CheckboxInput,
};
// BUBBER EDIT ADDITION END

export const asaycolor: Feature<string> = {
  name: 'Cor do chat administrativo',
  category: 'ADMIN',
  description: 'A cor de suas mensagens em Adminsay.',
  component: FeatureColorInput,
};

export const brief_outfit: Feature<string> = {
  name: 'Roupa curta.',
  category: 'ADMIN',
  description: 'A roupa a ganhar quando desovar como oficial de instrução.',
  component: FeatureDropdownInput,
};

export const bypass_deadmin_in_centcom: FeatureToggle = {
  name: 'Passar por opções de deadmin quando em CentCom',
  category: 'ADMIN',
  description:
    'Se deve ou não permanecer como administrador quando criado na CentCom.',
  component: CheckboxInput,
};

export const fast_mc_refresh: FeatureToggle = {
  name: 'Activar rápida actualização do painel de estatísticas MC',
  category: 'ADMIN',
  description:
    'Se a guia MC do Painel Stat se atualiza rápido. Isso é caro, então certifique-se de precisar.',
  component: CheckboxInput,
};

export const ghost_roles_as_admin: FeatureToggle = {
  name: 'Obter papéis fantasmas enquanto administrado',
  category: 'ADMIN',
  description: `
    If you de-select this, you will not get any ghost role pop-ups while
    adminned! Every single pop-up WILL never show up for you in an adminned
    state. However, this does not suppress notifications when you are
    a regular player (deadminned).
`,
  component: CheckboxInput,
};

export const comms_notification: FeatureToggle = {
  name: 'Activar o som do console das comunicações',
  category: 'ADMIN',
  component: CheckboxInput,
};

export const auto_deadmin_on_ready_or_latejoin: FeatureToggle = {
  name: 'Auto Deadmin - Pronto ou Latejoin',
  category: 'ADMIN',
  description: `
    When enabled, you will automatically deadmin when you click to ready up or latejoin a round.
`,
  component: CheckboxInput,
};
