import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const show_flavor_text_nsfw: FeatureChoiced = {
  name: 'NSFW Visibilidade do sabor',
  description:
    'Como você gostaria que seu texto de sabor NSFW fosse mostrado. Silícios sempre mostram texto de sabor NSFW, a menos que "nunca".',
  category: 'ERP',
  component: FeatureDropdownInput,
};
