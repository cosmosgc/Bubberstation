import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const bgstate: FeatureChoiced = {
  name: 'Antevisão de Caracteres',
  description:
    'Qual seria o fundo para a pré-visualização do personagem?',
  component: FeatureDropdownInput,
};
