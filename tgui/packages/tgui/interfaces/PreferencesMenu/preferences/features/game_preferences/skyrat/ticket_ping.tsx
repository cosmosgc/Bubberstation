// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const ticket_ping_pref: FeatureToggle = {
  name: 'Passagem ping',
  category: 'ADMIN',
  description:
    'Quando habilitado, você receberá pings regulares de bilhetes não manipulados.',
  component: CheckboxInput,
};
