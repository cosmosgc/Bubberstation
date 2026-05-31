import { CheckboxInput, type FeatureToggle } from '../base';

// BUBBER EDIT START - Replaced with choiced dropdown in bubber/screen.tsx
/*
export const widescreenpref: FeatureToggle = {
  name: 'Activar widescreen',
  category: 'UI',
  component: CheckboxInput,
};
*/
// BUBBER EDIT END

export const fullscreen_mode: FeatureToggle = {
  name: 'Alternar tela cheia',
  category: 'UI',
  description: 'Alterna tela cheia para o jogo, também pode ser alternado com F11.',
  component: CheckboxInput,
};
