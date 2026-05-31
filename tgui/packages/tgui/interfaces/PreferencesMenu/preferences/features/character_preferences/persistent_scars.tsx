import { CheckboxInput, type FeatureToggle } from '../base';

export const persistent_scars: FeatureToggle = {
  name: 'Cicatrizes persistentes',
  description:
    'Se marcada, as cicatrizes persistirão se você sobreviver até o fim.',
  component: CheckboxInput,
};
