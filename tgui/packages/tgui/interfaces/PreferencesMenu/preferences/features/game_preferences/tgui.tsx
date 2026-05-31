import { CheckboxInput, type FeatureToggle } from '../base';

export const tgui_input: FeatureToggle = {
  name: 'Entrada: habilitar TGUI',
  category: 'UI',
  description: 'Rende caixas de entrada na TGUI.',
  component: CheckboxInput,
};

export const tgui_input_large: FeatureToggle = {
  name: 'Entrada: botões maiores',
  category: 'UI',
  description: 'Torna os botões TGUI menos tradicionais, mais funcionais.',
  component: CheckboxInput,
};

export const tgui_input_swapped: FeatureToggle = {
  name: 'Entrada: Trocar os botões Enviar/Cancel',
  category: 'UI',
  description: 'Torna os botões TGUI menos tradicionais, mais funcionais.',
  component: CheckboxInput,
};

export const tgui_lock: FeatureToggle = {
  name: 'Bloquear TGUI para monitor principal.',
  category: 'UI',
  description: 'Fecha janelas TGUI para seu monitor principal.',
  component: CheckboxInput,
};

export const ui_scale: FeatureToggle = {
  name: 'Alternar escala de UI',
  category: 'UI',
  description: 'Se a UI aumentar para igualar a escala do monitor.',
  component: CheckboxInput,
};

export const tgui_say_light_mode: FeatureToggle = {
  name: 'Diga: modo de luz',
  category: 'UI',
  description: 'Set TGUI Diga para usar um modo leve.',
  component: CheckboxInput,
};
