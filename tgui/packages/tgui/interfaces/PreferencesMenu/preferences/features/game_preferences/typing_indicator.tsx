import { CheckboxInput, type FeatureToggle } from '../base';

export const typingIndicator: FeatureToggle = {
  name: 'Activar indicadores de digitação para si mesmo.',
  category: 'GAMEPLAY',
  description: "Habilite indicadores de digitação que mostrem que está digitando uma mensagem.",
  component: CheckboxInput,
};
