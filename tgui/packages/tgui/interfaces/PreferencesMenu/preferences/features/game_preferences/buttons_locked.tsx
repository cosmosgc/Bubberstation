import { CheckboxInput, type FeatureToggle } from '../base';

export const buttons_locked: FeatureToggle = {
  name: 'Bloquear botões de ação',
  category: 'GAMEPLAY',
  description: 'Quando ativado, botões de ação serão bloqueados no lugar.',
  component: CheckboxInput,
};
