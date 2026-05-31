import {
  Button,
  LabeledList,
  NumberInput,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const GulagTeleporterConsole = (props) => {
  const { act, data } = useBackend();
  const {
    teleporter,
    teleporter_lock,
    teleporter_state_open,
    teleporter_location,
    beacon,
    beacon_location,
    id,
    id_name,
    can_teleport,
    goal = 0,
    prisoner = {},
  } = data;
  return (
    <Window width={350} height={295}>
      <Window.Content>
        <Section
          title="Teletransportador Console"
          buttons={
            <>
              <Button
                content={teleporter_state_open ? 'Open' : 'Closed'}
                disabled={teleporter_lock}
                selected={teleporter_state_open}
                onClick={() => act('toggle_open')}
              />
              <Button
                icon={teleporter_lock ? 'lock' : 'unlock'}
                content={teleporter_lock ? 'Locked' : 'Unlocked'}
                selected={teleporter_lock}
                disabled={teleporter_state_open}
                onClick={() => act('teleporter_lock')}
              />
            </>
          }
        >
          <LabeledList>
            <LabeledList.Item
              label="Unidade de Teletransporte."
              color={teleporter ? 'good' : 'bad'}
              buttons={
                !teleporter && (
                  <Button
                    content="Reconnect"
                    onClick={() => act('scan_teleporter')}
                  />
                )
              }
            >
              {teleporter ? teleporter_location : 'Não Conectado'}
            </LabeledList.Item>
            <LabeledList.Item
              label="Beacon Receptor"
              color={beacon ? 'good' : 'bad'}
              buttons={
                !beacon && (
                  <Button
                    content="Reconnect"
                    onClick={() => act('scan_beacon')}
                  />
                )
              }
            >
              {beacon ? beacon_location : 'Não Conectado'}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Detalhes do prisioneiro">
          <LabeledList>
            <LabeledList.Item label="ID do prisioneiro">
              <Button
                fluid
                content={id ? id_name : 'Sem identificação.'}
                onClick={() => act('handle_id')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Ponto Gol">
              <NumberInput
                value={goal}
                step={1}
                width="48px"
                minValue={1}
                maxValue={1000}
                onChange={(value) => act('set_goal', { value })}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Occupant">
              {prisoner.name || 'Nenhum Ocupante'}
            </LabeledList.Item>
            <LabeledList.Item label="Status Criminal">
              {prisoner.crimstat || 'Sem status'}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Button
          fluid
          content="Processo Prisioneiro"
          disabled={!can_teleport}
          textAlign="center"
          color="bad"
          onClick={() => act('teleport')}
        />
      </Window.Content>
    </Window>
  );
};
