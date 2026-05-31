import {
  type Feature,
  type FeatureChoiced,
  FeatureColorInput,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const seamless_heel_type: FeatureChoiced = {
  name: 'Tipo salto',
  component: FeatureDropdownInput,
};

export const seamless_shoe_color: Feature<string> = {
  name: 'Cor dos sapatos',
  component: FeatureColorInput,
};
