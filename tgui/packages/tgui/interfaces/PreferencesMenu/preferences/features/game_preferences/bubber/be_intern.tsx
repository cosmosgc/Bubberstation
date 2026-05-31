import { CheckboxInput, type FeatureToggle } from '../../base';

export const be_intern: FeatureToggle = {
  name: 'Ser marcado como estagiário',
  category: 'GAMEPLAY',
  description:
    'Comuta se você será marcado como um estagiário em trabalhos onde você tem pouco tempo de jogo.',
  component: CheckboxInput,
};
