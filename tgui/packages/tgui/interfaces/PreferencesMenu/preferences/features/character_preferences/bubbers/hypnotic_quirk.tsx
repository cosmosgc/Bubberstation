import {
  type Feature,
  type FeatureChoiced,
  FeatureShortTextInput,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const hypnotic_quirk_text: Feature<string> = {
  name: 'Texto Hipnótico Examine',
  description:
    'O texto de exame retratado de seu personagem. Use a terceira pessoa.',
  component: FeatureShortTextInput,
};

export const flashy_text: FeatureChoiced = {
  name: 'Seleção de Cores de Texto',
  component: FeatureDropdownInput,
};
