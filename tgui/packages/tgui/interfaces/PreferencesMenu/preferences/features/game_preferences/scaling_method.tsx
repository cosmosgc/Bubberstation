import { createDropdownInput, type Feature } from '../base';

export const scaling_method: Feature<string> = {
  name: 'Método de escala',
  category: 'UI',
  component: createDropdownInput({
    blur: 'Bilinear',
    distort: 'Vizinho mais próximo',
    normal: 'Amostragem de pontos',
  }),
};
