import { CheckboxInputInverse, type FeatureToggle } from '../base';

export const hotkeys: FeatureToggle = {
  name: 'Teclas de atalho clássicas',
  category: 'GAMEPLAY',
  description:
    'Quando habilitado, vai voltar para as teclas de atalho legado, usando a barra de entrada em vez de popups.',
  component: CheckboxInputInverse,
};
