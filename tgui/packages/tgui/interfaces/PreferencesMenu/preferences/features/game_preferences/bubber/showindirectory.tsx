import { CheckboxInput, type FeatureToggle } from '../../base';

export const show_in_directory: FeatureToggle = {
  name: 'Mostrar no diretório',
  category: 'ADVERT',
  description: 'Quando habilitado, o caractere será mostrado no diretório',
  component: CheckboxInput,
};
