// THIS IS A SKYRAT UI FILE
import {
  CheckboxInput,
  type Feature,
  FeatureColorInput,
  type FeatureToggle,
} from '../../base';

export const echolocation_outline: Feature<string> = {
  name: 'Cor do contorno do eco',
  component: FeatureColorInput,
};

export const echolocation_use_echo: FeatureToggle = {
  name: 'Mostrar sobreposição de eco',
  component: CheckboxInput,
};
