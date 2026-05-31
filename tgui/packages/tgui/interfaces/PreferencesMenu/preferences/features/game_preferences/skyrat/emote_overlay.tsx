// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const do_emote_overlay: FeatureToggle = {
  name: 'Mostrar / esconder meu efeito emotivo sobreposições',
  category: 'CHAT',
  description:
    'Isso mostra/esconde as sobreposições animadas exibidas em emotes para si mesmo.',
  component: CheckboxInput,
};
