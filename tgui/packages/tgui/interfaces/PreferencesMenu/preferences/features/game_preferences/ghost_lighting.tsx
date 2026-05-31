import type { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const ghost_lighting: FeatureChoiced = {
  name: 'Iluminação Fantasma',
  component: FeatureDropdownInput,
  category: 'GHOST',
  description: 'Efeitos o brilho das luzes para fantasmas',
};
