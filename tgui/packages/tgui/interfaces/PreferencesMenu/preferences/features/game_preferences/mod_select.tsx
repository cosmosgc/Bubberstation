import type { Feature } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const mod_select: Feature<string> = {
  name: 'MOD chave do módulo ativo',
  category: 'GAMEPLAY',
  description: 'A chave que você precisa para usar um módulo de MODsuit ativo.',
  component: FeatureDropdownInput,
};
