import {
  CheckboxInput,
  type Feature,
  type FeatureChoiced,
  FeatureColorInput,
  type FeatureToggle,
} from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const screentip_color: Feature<string> = {
  name: 'Dicas: Cor das dicas',
  category: 'UI',
  description: `
    The color of screen tips, the text you see when hovering over something.
  `,
  component: FeatureColorInput,
};

export const screentip_images: FeatureToggle = {
  name: 'Proibir imagens',
  category: 'UI',
  description: `When enabled, screentip hints use images for
    the mouse button rather than LMB/RMB.`,
  component: CheckboxInput,
};

export const screentip_pref: FeatureChoiced = {
  name: 'Dicas de tela: habilitar dicas de tela',
  category: 'UI',
  description: `
    Enables screen tips, the text you see when hovering over something.
    When set to "Só com dicas.", will only show when there is more information
    than just the name, such as what right-clicking it does.
  `,
  component: FeatureDropdownInput,
};
