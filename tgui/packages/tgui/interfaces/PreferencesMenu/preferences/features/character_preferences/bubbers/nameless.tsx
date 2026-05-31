import { type Feature, FeatureShortTextInput } from '../../base';

export const nameless_quirk_name: Feature<string> = {
  name: 'Nome Prefixo',
  description:
    'Exemplo: #1334. Deixe em branco para o título do trabalho. No mínimo 3 caracteres.',
  component: FeatureShortTextInput,
};
