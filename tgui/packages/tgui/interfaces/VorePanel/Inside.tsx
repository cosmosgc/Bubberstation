import { useBackend } from 'tgui/backend';
import { Box, Collapsible, Section } from 'tgui-core/components';

import { BellyContents } from './BellyUI';
import * as types from './types';

export const Inside = (props) => {
  const { data } = useBackend<types.Data>();
  const { inside } = data;

  if (!inside) {
    return <Section title="Para dentro!">You are not inside anyone!</Section>;
  }

  const preyMode = types.digestModeToPreyMode[inside.digest_mode];

  return (
    <Section title="Para dentro!">
      <Box>
        <Box color="yellow" inline>
          You are currently inside
        </Box>{' '}
        <Box inline color="blue">
          {inside.owner_name || 'someone'}
          &apos;s
        </Box>{' '}
        <Box inline color="red">
          {inside.name}
        </Box>{' '}
        <Box inline color="yellow">
          and you are
        </Box>{' '}
        <Box inline color={preyMode.color}>
          {preyMode.text}
        </Box>
      </Box>
      <Box mb={1} color="label" preserveWhitespace>
        {inside.desc}
      </Box>
      {inside.contents.length ? (
        <Collapsible title="Conteúdo da barriga">
          <BellyContents contents={inside.contents} />
        </Collapsible>
      ) : (
        'Não há mais nada ao seu redor.'
      )}
    </Section>
  );
};
