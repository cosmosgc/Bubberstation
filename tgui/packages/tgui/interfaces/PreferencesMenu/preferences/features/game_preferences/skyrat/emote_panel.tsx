// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const emote_panel: FeatureToggle = {
  name: 'Painel emotivo',
  category: 'CHAT',
  description: 'Alterna o painel Emote (necessita reconectar se estiver no jogo para se aplicar)',
  component: CheckboxInput,
};
