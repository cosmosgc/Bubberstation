import { FeatureColorInput, FeatureTextInput, type Feature } from '../../base';

export const dirty_quirk_color: Feature<string> = {
  name: 'Cor da sujeira',
  component: FeatureColorInput,
};

export const dirty_quirk_text: Feature<string> = {
  name: 'Texto de sabor',
  description:
    'Mostrado quando você está sujo.',
  component: FeatureTextInput,
};
