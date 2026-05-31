import { Button, Flex, NoticeBox, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const GhostPoolProtection = (props) => {
  const { act, data } = useBackend();
  const {
    events_or_midrounds,
    spawners,
    station_sentience,
    silicons,
    minigames,
  } = data;
  return (
    <Window
      title="Proteção da piscina fantasma"
      width={400}
      height={270}
      theme="admin"
    >
      <Window.Content>
        <Flex grow={1} height="100%">
          <Section
            title="Options"
            buttons={
              <>
                <Button
                  color="good"
                  icon="plus-circle"
                  content="Activar tudo."
                  onClick={() => act('all_roles')}
                />
                <Button
                  color="bad"
                  icon="minus-circle"
                  content="Desabilitar tudo"
                  onClick={() => act('no_roles')}
                />
              </>
            }
          >
            <NoticeBox danger>
              For people creating a sneaky event: If you toggle Station Created
              Sentience, people may catch on that admins have disabled roles for
              your event...
            </NoticeBox>
            <Flex.Item>
              <Button
                fluid
                textAlign="center"
                color={events_or_midrounds ? 'good' : 'bad'}
                icon="meteor"
                content="Eventos e Regimentos Midround"
                onClick={() => act('toggle_events_or_midrounds')}
              />
            </Flex.Item>
            <Flex.Item>
              <Button
                fluid
                textAlign="center"
                color={spawners ? 'good' : 'bad'}
                icon="pastafarianism"
                content="Papel fantasma Spawners"
                onClick={() => act('toggle_spawners')}
              />
            </Flex.Item>
            <Flex.Item>
              <Button
                fluid
                textAlign="center"
                color={station_sentience ? 'good' : 'bad'}
                icon="user-astronaut"
                content="Estação Criada Sentiência"
                onClick={() => act('toggle_station_sentience')}
              />
            </Flex.Item>
            <Flex.Item>
              <Button
                fluid
                textAlign="center"
                color={silicons ? 'good' : 'bad'}
                icon="robot"
                content="Silicons"
                onClick={() => act('toggle_silicons')}
              />
            </Flex.Item>
            <Flex.Item>
              <Button
                fluid
                textAlign="center"
                color={minigames ? 'good' : 'bad'}
                icon="gamepad"
                content="Minigames"
                onClick={() => act('toggle_minigames')}
              />
            </Flex.Item>
            <Flex.Item>
              <Button
                fluid
                textAlign="center"
                color="orange"
                icon="check"
                content="Aplicar mudanças"
                onClick={() => act('apply_settings')}
              />
            </Flex.Item>
          </Section>
        </Flex>
      </Window.Content>
    </Window>
  );
};
