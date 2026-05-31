import {
  CheckboxInput,
  type Feature,
  FeatureNumberInput,
  type FeatureToggle,
} from '../base';

export const enable_tips: FeatureToggle = {
  name: 'Activar dicas',
  category: 'TOOLTIPS',
  description: `
    Do you want to see tooltips when hovering over items?
  `,
  component: CheckboxInput,
};

export const tip_delay: Feature<number> = {
  name: 'Atraso na dica (em milissegundos)',
  category: 'TOOLTIPS',
  description: `
    How long should it take to see a tooltip when hovering over items?
  `,
  component: FeatureNumberInput,
};
