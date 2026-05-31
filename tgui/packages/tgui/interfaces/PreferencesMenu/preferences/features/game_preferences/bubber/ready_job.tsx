import { CheckboxInput, type FeatureToggle } from '../../base';

export const ready_job: FeatureToggle = {
  name: 'Comutando o trabalho pronto',
  category: 'UI',
  description:
    'Comuta se seu trabalho mais alto aparece no painel de estimativa de empregos pré-jogo.',
  component: CheckboxInput,
};
