import type { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const junkie: FeatureChoiced = {
  name: 'Addiction',
  component: FeatureDropdownInput,
};

export const smoker: FeatureChoiced = {
  name: 'Marca favorita',
  component: FeatureDropdownInput,
};

export const alcoholic: FeatureChoiced = {
  name: 'Bebida Favorita',
  component: FeatureDropdownInput,
};
