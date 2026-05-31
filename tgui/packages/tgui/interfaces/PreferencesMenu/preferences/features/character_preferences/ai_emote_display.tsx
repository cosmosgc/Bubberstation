import {
  FeatureIconnedDropdownInput,
  type FeatureWithIcons,
} from '../dropdowns';

export const preferred_ai_emote_display: FeatureWithIcons<string> = {
  name: 'Exposição de emoções Al',
  description:
    'Se você é a IA, a imagem padrão exibida em todas as telas de IA na estação.',
  component: FeatureIconnedDropdownInput,
};
