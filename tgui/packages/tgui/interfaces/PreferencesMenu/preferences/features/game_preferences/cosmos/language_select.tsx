import type { Feature } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const language_select: Feature<string> = {
  name: 'Language',
  category: 'GAMEPLAY',
  description: "Change your game's language.",
  component: FeatureDropdownInput,
};
