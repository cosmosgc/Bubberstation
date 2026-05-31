import { type Antagonist, Category } from '../base';
import { TRAITOR_MECHANICAL_DESCRIPTION } from './traitor';

const SyndicateInfiltrator: Antagonist = {
  key: 'syndicateinfiltrator',
  name: 'Syndicate Infiltrator',
  description: [
    'Uma forma de traidor que pode se ativar quando se junta a uma mudança contínua.',
    TRAITOR_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Latejoin,
  priority: -1,
};

export default SyndicateInfiltrator;
