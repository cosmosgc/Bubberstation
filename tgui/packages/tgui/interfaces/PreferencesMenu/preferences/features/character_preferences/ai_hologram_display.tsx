import {
  FeatureIconnedDropdownInput,
  type FeatureWithIcons,
} from '../dropdowns';

export const preferred_ai_hologram_display: FeatureWithIcons<string> = {
  name: 'AI holograma display',
  description: 'A forma holográfica que tomará quando usar uma holopade.',
  component: FeatureIconnedDropdownInput,
};
