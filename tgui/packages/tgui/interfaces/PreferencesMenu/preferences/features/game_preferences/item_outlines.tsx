import { CheckboxInput, type FeatureToggle } from '../base';

export const itemoutline_pref: FeatureToggle = {
  name: 'Esboços do item',
  category: 'GAMEPLAY',
  description: 'Quando habilitado, pairando sobre itens irá delineá-los.',
  component: CheckboxInput,
};
