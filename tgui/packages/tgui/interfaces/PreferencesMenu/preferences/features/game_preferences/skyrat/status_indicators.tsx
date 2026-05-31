import { CheckboxInput, type FeatureToggle } from '../../base';

export const enable_status_indicators: FeatureToggle = {
  name: 'Exibir indicadores de status',
  category: 'GAMEPLAY',
  description: 'Isso muda se você verá ou não indicadores de status.',
  component: CheckboxInput,
};
