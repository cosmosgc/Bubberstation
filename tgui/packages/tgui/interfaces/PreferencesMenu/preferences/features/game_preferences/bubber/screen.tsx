import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const viewport_size: FeatureChoiced = {
  name: 'Proporção de Aspectos (Viewport)',
  category: 'UI',
  description: 'Selecione seu tamanho preferido do viewport.',
  component: FeatureDropdownInput,
};
