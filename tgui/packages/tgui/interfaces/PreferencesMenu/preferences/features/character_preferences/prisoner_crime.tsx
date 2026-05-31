import type { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const prisoner_crime: FeatureChoiced = {
  name: 'Crime de prisioneiro.',
  description:
    'Quando um prisioneiro, isso será adicionado aos seus registros como a razão de sua prisão.',
  component: FeatureDropdownInput,
};
