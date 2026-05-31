// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const looc_admin_pref: FeatureToggle = {
  name: 'Veja LOOC remoto',
  category: 'ADMIN',
  description:
    'Comuta se você quer ver LOOC em algum lugar como administrador ou não.',
  component: CheckboxInput,
};

export const enable_looc_runechat: FeatureToggle = {
  name: 'Activar runechat LOOC',
  category: 'RUNECHAT',
  description:
    "Se True, LoOC aparecerá acima da cabeça do alto-falante, bem como na conversa.",
  component: CheckboxInput,
};
