import { createDropdownInput, type Feature } from '../base';

export const pixel_size: Feature<number> = {
  name: 'Escala de Pixel',
  category: 'UI',
  component: createDropdownInput({
    0: 'Estique para caber',
    1: 'Pixel Perfect 1x',
    1.5: 'Pixel Perfeito 1,5x',
    2: 'Pixel Perfect 2x',
    3: 'Pixel Perfeito 3x',
    4: 'Pixel Perfect 4x',
    4.5: 'Pixel Perfeito 4,5x',
    5: 'Pixel Perfeito 5x',
    6: 'Pixel Perfeito 6x',
    7: 'Pixel Perfect 7x',
    8: 'Pixel Perfeito 8x',
    9: 'Pixel Perfeito 9x',
  }),
};
