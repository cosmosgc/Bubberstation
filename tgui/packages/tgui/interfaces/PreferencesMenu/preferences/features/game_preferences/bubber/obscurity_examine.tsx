import { CheckboxInput, type FeatureToggle } from '../../base';

export const obscurity_examine_pref: FeatureToggle = {
  name: 'Obscuro examinar painel',
  category: 'GAMEPLAY',
  description: 'Comuta se seu painel de exame está escondido quando desconhecido.',
  component: CheckboxInput,
};
