import type { Feature } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const parallax: Feature<string> = {
  name: 'Parallax (espaço de fantasia)',
  category: 'GAMEPLAY',
  component: FeatureDropdownInput,
};
