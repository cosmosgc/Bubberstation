import { CheckboxInput, FeatureToggle } from '../../base';

export const resilient_traumas_permanent_traumas: FeatureToggle = {
  name: 'Traumas permanentes',
  description:
	'Traumas cerebrais que ganharão serão permanentes, em vez curáveis com lobotomia abençoada.',
  component: CheckboxInput,
};

export const resilient_traumas_hardcore: FeatureToggle = {
  name: 'Modo Hardcore',
  description:
	'Traumas básicos só serão curáveis por lobotomia e tudo mais será permanente/curável por lobotomia abençoada.',
  component: CheckboxInput,
};
