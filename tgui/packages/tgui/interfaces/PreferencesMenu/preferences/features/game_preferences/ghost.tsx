import { binaryInsertWith } from 'common/collections';
import type { ReactNode } from 'react';
import { useBackend } from 'tgui/backend';
import { Box, Dropdown, Flex } from 'tgui-core/components';
import { classes } from 'tgui-core/react';

import type { PreferencesMenuData } from '../../../types';
import {
  CheckboxInput,
  type FeatureChoiced,
  type FeatureChoicedServerData,
  type FeatureToggle,
  type FeatureValueProps,
} from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const ghost_accs: FeatureChoiced = {
  name: 'Acessórios fantasmas.',
  category: 'GHOST',
  description: 'Determina quais ajustes seu fantasma terá.',
  component: FeatureDropdownInput,
};

type GhostForm = {
  displayText: ReactNode;
  value: string;
};

function insertGhostForm(collection: GhostForm[], value: GhostForm) {
  return binaryInsertWith(collection, value, ({ value }) => value);
}

function GhostFormInput(
  props: FeatureValueProps<string, string, FeatureChoicedServerData>,
) {
  const { data } = useBackend<PreferencesMenuData>();

  const serverData = props.serverData;
  if (!serverData) {
    return;
  }

  const displayNames = serverData.display_names;
  if (!displayNames) {
    return <Box color="red">No display names for ghost_form!</Box>;
  }

  const displayTexts = {};
  let options: {
    displayText: ReactNode;
    value: string;
  }[] = [];

  for (const [name, displayName] of Object.entries(displayNames)) {
    const displayText = (
      <Flex key={name}>
        <Flex.Item>
          <Box
            className={classes([`preferences32x32`, serverData.icons![name]])}
          />
        </Flex.Item>

        <Flex.Item grow={1}>{displayName}</Flex.Item>
      </Flex>
    );

    displayTexts[name] = displayText;

    const optionEntry = {
      displayText,
      value: name,
    };

    // Put the default ghost on top
    if (name === 'ghost') {
      options.unshift(optionEntry);
    } else {
      options = insertGhostForm(options, optionEntry);
    }
  }

  return (
    <Dropdown
      autoScroll={false}
      disabled={!data.content_unlocked}
      selected={props.value}
      placeholder={displayTexts[props.value]}
      onSelected={props.handleSetValue}
      width="100%"
      options={options}
    />
  );
}

export const ghost_form: FeatureChoiced = {
  name: 'Fantasmas se formam.',
  category: 'GHOST',
  description: 'A aparência do seu fantasma. Requer a adesão de ByOND.',
  component: GhostFormInput,
};

export const ghost_hud: FeatureToggle = {
  name: 'HUD Fantasma',
  category: 'GHOST',
  description: 'Activar botões HUD para fantasmas.',
  component: CheckboxInput,
};

export const ghost_orbit: FeatureChoiced = {
  name: 'Órbita fantasma.',
  category: 'GHOST',
  description: `
    The shape in which your ghost will orbit.
    Requires BYOND membership.
  `,
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    const { data } = useBackend<PreferencesMenuData>();

    return (
      <FeatureDropdownInput {...props} disabled={!data.content_unlocked} />
    );
  },
};

export const ghost_others: FeatureChoiced = {
  name: 'Fantasmas dos outros',
  category: 'GHOST',
  description: `
    Do you want the ghosts of others to show up as their own setting, as
    their default sprites, or always as the default white ghost?
  `,
  component: FeatureDropdownInput,
};

export const inquisitive_ghost: FeatureToggle = {
  name: 'Inquisição fantasma',
  category: 'GHOST',
  description: 'Clicar em algo como um fantasma vai examiná-lo.',
  component: CheckboxInput,
};

export const ghost_roles: FeatureToggle = {
  name: 'Obter papéis fantasmas',
  category: 'GHOST',
  description: `
    If you de-select this, you will not get any ghost role pop-ups what-so-ever!
    Every single type of these pop-ups WILL be muted for you when you are
    ghosted. Very useful for those who find ghost roles or the
    pop-ups annoying, use at your own peril.
`,
  component: CheckboxInput,
};
