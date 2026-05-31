import { CheckboxInput, type FeatureToggle } from '../../base';

export const autopunctuation: FeatureToggle = {
  name: 'Autopunctuation',
  category: 'CHAT',
  description: 'Quando habilitado, mensagens sem pontuação serão adicionadas.',
  component: CheckboxInput,
};
