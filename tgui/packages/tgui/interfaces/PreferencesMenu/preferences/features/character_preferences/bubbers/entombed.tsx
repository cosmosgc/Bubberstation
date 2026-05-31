// Sponsored by Zubberstation, ported from Nova Sector
import {
  CheckboxInput,
  type Feature,
  type FeatureChoiced,
  FeatureShortTextInput,
  type FeatureToggle,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const entombed_deploy_lock: FeatureToggle = {
  name: 'MODsuit Permanece Implantado',
  description:
    'Impede que alguém retraia seu traje, exceto seu capacete. Até você. ATENÇÃO: isso pode torná-lo extremamente difícil de reviver, e pode ser considerado um NR suave. Escolha sabiamente.',
  component: CheckboxInput,
};

export const entombed_skin: FeatureChoiced = {
  name: 'Pele de madrasta',
  component: FeatureDropdownInput,
};

export const entombed_mod_name: Feature<string> = {
  name: 'Nome da unidade de controle do MODsuit',
  component: FeatureShortTextInput,
};

export const entombed_mod_desc: Feature<string> = {
  name: 'Unidade de Controle do MODsuit Descrição',
  component: FeatureShortTextInput,
};

export const entombed_mod_prefix: Feature<string> = {
  name: 'MODsuit lançou Prefix',
  description:
    "Isto é anexado a qualquer peça de equipamento MODsuit, como o peito, capacete, etc. O padrão é 'fundido' - tente usar um adjetivo, se puder.",
  component: FeatureShortTextInput,
};
