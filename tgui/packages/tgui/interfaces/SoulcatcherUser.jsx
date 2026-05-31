// THIS IS A SKYRAT UI FILE
import {
  BlockQuote,
  Box,
  Button,
  Collapsible,
  Divider,
  Flex,
  LabeledList,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const SoulcatcherUser = (props) => {
  const { act, data } = useBackend();
  const {
    current_room,
    user_data,
    communicate_as_parent,
    targeted,
    souls = [],
  } = data;

  return (
    <Window width={520} height={400} resizable>
      <Window.Content scrollable>
        <Section
          key={current_room.key}
          title={
            <span style={{ color: current_room.color }}>
              {current_room.name}
            </span>
          }
        >
          <BlockQuote preserveWhitespace>
            {' '}
            {current_room.description}
          </BlockQuote>
          <br />
          <Box textAlign="center" fontSize="15px" opacity={0.8}>
            <b>{user_data.name} </b>
            <Button
              color={targeted ? 'green' : 'red'}
              icon={targeted ? 'check' : 'xmark'}
              tooltip="Alternar se o portador disser e os verbos emotivos do portador enviarem para este caça-almas."
              onClick={() => act('toggle_target', {})}
            />
            {!user_data.scan_needed && user_data.able_to_rename && (
              <>
                <Button
                  color="green"
                  icon="pen"
                  tooltip="Mude seu nome."
                  onClick={() => act('change_name', {})}
                />
                <Button
                  color="red"
                  icon="arrow-rotate-left"
                  tooltip="Reinicie seu nome."
                  onClick={() => act('reset_name', {})}
                />
              </>
            )}
            {communicate_as_parent && (
              <Button
                color={user_data.communicating_externally ? 'green' : 'red'}
                icon={
                  user_data.communicating_externally ? 'bullhorn' : 'microphone'
                }
                tooltip="Alterna enviar mensagens como parte do caça-almas."
                onClick={() => act('toggle_external_communication', {})}
              />
            )}
          </Box>
          <Divider />
          <Collapsible title="Texto Sabor">
            <BlockQuote preserveWhitespace>{user_data.description}</BlockQuote>
          </Collapsible>
          <Collapsible title="Nota como COC">
            <BlockQuote preserveWhitespace>{user_data.ooc_notes}</BlockQuote>
          </Collapsible>
          <Collapsible title="Soul Info">
            <LabeledList textAlign>
              <LabeledList.Item label="Capacidade de ver lá fora">
                {user_data.outside_sight ? 'Enabled' : 'Disabled'}
              </LabeledList.Item>
              <LabeledList.Item label="Capacidade de ouvir lá fora">
                {user_data.outside_hearing ? 'Enabled' : 'Disabled'}
              </LabeledList.Item>
              <LabeledList.Item label="Capacidade de ver dentro">
                {user_data.internal_sight ? 'Enabled' : 'Disabled'}
              </LabeledList.Item>
              <LabeledList.Item label="Capacidade de ouvir por dentro">
                {user_data.internal_hearing ? 'Enabled' : 'Disabled'}
              </LabeledList.Item>
              <LabeledList.Item label="Capacidade de Falar">
                {user_data.able_to_speak ? 'Enabled' : 'Disabled'}
              </LabeledList.Item>
              <LabeledList.Item label="Capacidade de emocionar">
                {user_data.able_to_emote ? 'Enabled' : 'Disabled'}
              </LabeledList.Item>
              {communicate_as_parent && (
                <>
                  <LabeledList.Item label="Capacidade de falar como contêiner">
                    {user_data.able_to_speak_as_container
                      ? 'Enabled'
                      : 'Disabled'}
                  </LabeledList.Item>
                  <LabeledList.Item label="Capacidade de emocionar como destinatário">
                    {user_data.able_to_emote_as_container
                      ? 'Enabled'
                      : 'Disabled'}
                  </LabeledList.Item>
                </>
              )}
              <LabeledList.Item label="Capacidade de lamar de nome">
                {user_data.able_to_rename && !user_data.scan_needed
                  ? 'Enabled'
                  : 'Disabled'}
              </LabeledList.Item>
              <LabeledList.Item label="Scan de corpo necessário">
                {user_data.scan_needed ? 'True' : 'False'}
              </LabeledList.Item>
            </LabeledList>
          </Collapsible>

          {souls && user_data.internal_sight && (
            <>
              <br />
              <Box textAlign="center" fontSize="15px" opacity={0.8}>
                <b>Souls</b>
              </Box>
              <Divider />
              <Flex direction="column">
                {souls.map((soul) => (
                  <Flex.Item key={soul.key}>
                    <Collapsible title={soul.name}>
                      <Box textAlign="center" fontSize="13px" opacity={0.8}>
                        <b>Flavor Text</b>
                      </Box>
                      <Divider />
                      <BlockQuote preserveWhitespace>
                        {soul.description}
                      </BlockQuote>
                      <br />
                      <Box textAlign="center" fontSize="13px" opacity={0.8}>
                        <b>OOC Notes</b>
                      </Box>
                      <Divider />
                      <BlockQuote preserveWhitespace>
                        {soul.ooc_notes}
                      </BlockQuote>
                    </Collapsible>
                  </Flex.Item>
                ))}
              </Flex>
            </>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
