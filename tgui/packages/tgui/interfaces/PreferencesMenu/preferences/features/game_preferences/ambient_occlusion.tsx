import { CheckboxInput, type FeatureToggle } from '../base';

export const ambientocclusion: FeatureToggle = {
  name: 'Ativar oclusão ambiente.',
  category: 'GAMEPLAY',
  description: 'Ativar oclusão ambiente, sombras de luz ao redor dos personagens.',
  component: CheckboxInput,
};
