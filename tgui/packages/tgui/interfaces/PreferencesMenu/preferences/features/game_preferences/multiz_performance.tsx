import { createDropdownInput, type Feature } from '../base';

export const multiz_performance: Feature<number> = {
  name: 'Multi-Z Profundidade',
  category: 'GAMEPLAY',
  description:
    'Quantos níveis multi-Z são renderizados antes de começarem a ser eliminados. Diminua isso para melhorar o desempenho em caso de atraso em mapas multi-z.',
  component: createDropdownInput({
    [-1]: 'Sem Culling.',
    2: 'High',
    1: 'Medium',
    0: 'Low',
  }),
};
