import {
  type Feature,
  type FeatureChoiced,
  FeatureColorInput,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const input_blood_color: Feature<string> = {
  name: 'Cor personalizada',
  description:
    'Isso combina com a cor do PX mais brilhante.',
  component: FeatureColorInput,
};

export const select_blood_color: FeatureChoiced = {
  name: 'Cor predefinida',
  description: 'Use a opção Personalizada para cores personalizadas.',
  component: FeatureDropdownInput,
};
