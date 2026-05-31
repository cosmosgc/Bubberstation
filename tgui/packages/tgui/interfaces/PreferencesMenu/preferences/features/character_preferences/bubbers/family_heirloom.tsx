import { CheckboxInput, type FeatureToggle } from '../../base';

export const random_heirloom_toggle: FeatureToggle = {
  name: 'Activar heranças aleatórias',
  description:
    'Se habilitado, você vai receber relíquias aleatórias em vez de ser para marcar a sua própria.',
  component: CheckboxInput,
};
