import {
  CheckboxInput,
  type FeatureChoiced,
  type FeatureToggle,
} from '../base';
import {
  FeatureDropdownInput,
  FeatureIconnedDropdownInput,
} from '../dropdowns';

export const language: FeatureChoiced = {
  name: 'Language',
  component: FeatureIconnedDropdownInput,
};

export const language_speakable: FeatureToggle = {
  name: 'Linguagem Falavel',
  description: `If unchecked, you'll only be able to understand the language,
    but not speak it.`,
  component: CheckboxInput,
};

export const language_skill: FeatureChoiced = {
  name: 'Habilidade Linguagem',
  description: 'A porcentagem da linguagem que você pode entender.',
  component: FeatureDropdownInput,
};

export const csl_strength: FeatureChoiced = {
  name: 'Habilidade Linguagem',
  description: 'A porcentagem de Common você pode entender.',
  component: FeatureDropdownInput,
};
