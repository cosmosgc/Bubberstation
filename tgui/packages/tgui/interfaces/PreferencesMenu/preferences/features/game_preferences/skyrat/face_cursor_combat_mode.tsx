// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const face_cursor_combat_mode: FeatureToggle = {
  name: 'Cursor de rosto com modo de combate',
  category: 'GAMEPLAY',
  description: `
    When toggled, you will now face towards the cursor
    with combat mode enabled.
  `,
  component: CheckboxInput,
};
