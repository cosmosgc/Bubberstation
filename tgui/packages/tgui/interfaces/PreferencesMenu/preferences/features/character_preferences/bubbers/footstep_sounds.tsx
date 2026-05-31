import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const footstep_sound: FeatureChoiced = {
  name: 'Som de passo',
  description: 'O tipo de som que fará quando andar descalço.',
  component: FeatureDropdownInput,
};
