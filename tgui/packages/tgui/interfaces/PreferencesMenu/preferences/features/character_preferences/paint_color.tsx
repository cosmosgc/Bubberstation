import { type Feature, FeatureColorInput } from '../base';

export const paint_color: Feature<string> = {
  name: 'Cor da tinta spray',
  component: FeatureColorInput,
};
