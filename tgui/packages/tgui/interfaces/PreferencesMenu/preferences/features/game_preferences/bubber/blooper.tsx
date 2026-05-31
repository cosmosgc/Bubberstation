import { CheckboxInput, type FeatureToggle } from '../../base';

export const blooper_send: FeatureToggle = {
  name: 'Activar envio de sons vocais',
  category: 'SOUND',
  description:
    'Quando habilitado, toca um efeito sonoro personalizável quando seu personagem fala.',
  component: CheckboxInput,
};

export const blooper_hear: FeatureToggle = {
  name: 'Ativar sons vocais',
  category: 'SOUND',
  description: `When enabled, allows you to hear other character's speech sounds.`,
  component: CheckboxInput,
};
