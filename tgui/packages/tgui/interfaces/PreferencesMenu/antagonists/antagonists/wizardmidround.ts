import { type Antagonist, Category } from '../base';
import { WIZARD_MECHANICAL_DESCRIPTION } from './wizard';

const WizardMidround: Antagonist = {
  key: 'wizardmidround',
  name: 'Feiticeiro.',
  description: [
    'Uma forma de mago que é oferecida a fantasmas no meio do turno.',
    WIZARD_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Midround,
};

export default WizardMidround;
