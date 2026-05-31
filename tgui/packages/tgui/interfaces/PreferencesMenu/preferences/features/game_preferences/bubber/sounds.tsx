import { type Feature, FeatureSliderInput } from '../../base';

export const sound_emote: Feature<number> = {
  name: 'Volume de som emotivo',
  category: 'SOUND',
  description: 'Volume de emoções audíveis.',
  component: FeatureSliderInput,
};
