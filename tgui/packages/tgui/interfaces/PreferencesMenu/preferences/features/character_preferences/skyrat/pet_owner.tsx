// THIS IS A SKYRAT UI FILE
import {
  type Feature,
  type FeatureChoiced,
  FeatureShortTextInput,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const pet_owner: FeatureChoiced = {
  name: 'Tipo de animal de estimação',
  component: FeatureDropdownInput,
};

export const pet_name: Feature<string> = {
  name: 'Nome do animal de estimação',
  description:
    "Se estiver em branco, usará o nome padrão da máfia. Por exemplo, 'axolotl' ou 'chinchilla'.",
  component: FeatureShortTextInput,
};

export const pet_desc: Feature<string> = {
  name: 'Descrição do animal de estimação',
  description: "Se em branco, usará a descrição padrão da máfia.",
  component: FeatureShortTextInput,
};
