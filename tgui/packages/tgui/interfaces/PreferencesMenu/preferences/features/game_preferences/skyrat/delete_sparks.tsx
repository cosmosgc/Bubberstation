// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const delete_sparks_pref: FeatureToggle = {
  name: 'Exclusão de faíscas',
  category: 'ADMIN',
  description:
    'Alterna se quiser tocar uma animação ao deletar coisas como administrador.',
  component: CheckboxInput,
};
