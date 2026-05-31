import { type Feature, FeatureColorInput } from '../base';

export const ooccolor: Feature<string> = {
  name: 'Cor OOC',
  category: 'CHAT',
  description: 'A cor das suas mensagens OOC.',
  component: FeatureColorInput,
};
