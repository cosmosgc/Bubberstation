import { CheckboxInput, type FeatureToggle } from '../base';

export const status_bar: FeatureToggle = {
  name: 'Habilitar barra de status',
  category: 'UI',
  description: `
      When toggled, a bar at the bottom left of the screen will display
      the name of what your mouse cursor is hovering over.
    `,
  component: CheckboxInput,
};
