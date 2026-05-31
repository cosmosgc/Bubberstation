// THIS IS A SKYRAT UI FILE
import { Icon, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Rules } from './AntagInfoRules';

type Info = {
  antag_name: string;
};

export const AntagInfoClock = (props) => {
  const { data } = useBackend<Info>();
  const { antag_name } = data;
  return (
    <Window width={620} height={350} theme="clockwork">
      <Window.Content>
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item fontSize="20px" color={'good'}>
              <Icon name={'cog'} rotation={0} spin />
              {` You are the ${antag_name}! `}
              <Icon name={'cog'} rotation={35} spin />
            </Stack.Item>
            <Stack.Item>
              <Rules />
            </Stack.Item>
            <Stack.Item>
              <ObjectivePrintout />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};

const ObjectivePrintout = (props) => {
  const { data } = useBackend<Info>();
  return (
    <Stack vertical>
      <Stack.Item bold>Your goals:</Stack.Item>
      <Stack.Item>
        {
          'Ainda mais os objetivos de qualquer outra organização que você é uma parte de usar o poder concedido a você.'
        }
      </Stack.Item>
      <Stack.Item>
        {
          'Mais a graça, conhecimento e glória de nosso grande senhor do Motor, Ratvar.'
        }
      </Stack.Item>
    </Stack>
  );
};
