import { CheckboxInput, type FeatureToggle } from '../../base';

export const be_antag_pref: FeatureToggle = {
  name: 'Seja antagonista.',
  category: 'GAMEPLAY',
  description: 'Se você quiser ser um antagonista ou não.',
  component: CheckboxInput,
};
