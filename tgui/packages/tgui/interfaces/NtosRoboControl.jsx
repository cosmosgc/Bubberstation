import {
  Box,
  Button,
  LabeledList,
  ProgressBar,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { NtosWindow } from '../layouts';

const getMuleByRef = (mules, ref) => {
  return mules?.find((mule) => mule.mule_ref === ref);
};

export const NtosRoboControl = (props) => {
  const { act, data } = useBackend();
  const [tab_main, setTab_main] = useSharedState('tab_main', 1);
  const { bots, drones, id_owner, droneaccess, dronepingtypes } = data;

  return (
    <NtosWindow width={550} height={550}>
      <NtosWindow.Content scrollable>
        <Section title="Consola de controle de robôs">
          <LabeledList>
            <LabeledList.Item label="Cartão de Identidade">{id_owner}</LabeledList.Item>
            <LabeledList.Item label="Bots ao alcance">
              {data.botcount}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Stack.Item>
          <Tabs>
            <Tabs.Tab
              icon="robot"
              lineHeight="23px"
              selected={tab_main === 1}
              onClick={() => setTab_main(1)}
            >
              Bots
            </Tabs.Tab>
            <Tabs.Tab
              icon="hammer"
              lineHeight="23px"
              selected={tab_main === 2}
              onClick={() => setTab_main(2)}
            >
              Drones
            </Tabs.Tab>
          </Tabs>
        </Stack.Item>
        {tab_main === 1 && (
          <Stack.Item>
            <Section>
              <LabeledList>
                <LabeledList.Item label="Bots ao alcance">
                  {data.botcount}
                </LabeledList.Item>
              </LabeledList>
            </Section>
            {bots?.map((robot) => (
              <RobotInfo key={robot.bot_ref} robot={robot} />
            ))}
          </Stack.Item>
        )}
        {tab_main === 2 && (
          <Stack.Item grow>
            <Section>
              <Button
                icon="address-card"
                tooltip="Conceda/Remova o acesso dos drones para interagir com máquinas e fios que de outra forma seriam considerados perigosos."
                color={droneaccess ? 'good' : 'bad'}
                onClick={() => act('changedroneaccess')}
              >
                {droneaccess ? 'Grant Drone Access' : 'Revogar o acesso de drones'}
              </Button>
              <Box my={1}>Drone Pings</Box>
              {dronepingtypes.map((ping_type) => (
                <Button
                  key={ping_type}
                  icon="bullhorn"
                  tooltip="Emita um sinal de drone."
                  onClick={() => act('ping_drones', { ping_type })}
                >
                  {ping_type}
                </Button>
              ))}
            </Section>
            {drones?.map((drone) => (
              <DroneInfo key={drone.drone_ref} drone={drone} />
            ))}
          </Stack.Item>
        )}
      </NtosWindow.Content>
    </NtosWindow>
  );
};

export const RobotInfo = (props) => {
  const { robot } = props;
  const { act, data } = useBackend();
  const mules = data.mules || [];
  // Get a mule object
  const mule = !!robot.mule_check && getMuleByRef(mules, robot.bot_ref);
  // Color based on type of a robot
  const color =
    robot.mule_check === 1 ? 'Rgba (110, 75, 14, 1)' : '(74, 59, 140, 1)';
  return (
    <Section
      title={robot.name}
      style={{
        border: `4px solid ${color}`,
      }}
      buttons={
        mule && (
          <>
            <Button
              icon="play"
              tooltip="Vá para o destino."
              onClick={() =>
                act('go', {
                  robot: mule.mule_ref,
                })
              }
            />
            <Button
              icon="pause"
              tooltip="Pare de se mexer."
              onClick={() =>
                act('stop', {
                  robot: mule.mule_ref,
                })
              }
            />
            <Button
              icon="home"
              tooltip="Viagem para casa."
              tooltipPosition="bottom-start"
              onClick={() =>
                act('home', {
                  robot: mule.mule_ref,
                })
              }
            />
          </>
        )
      }
    >
      <Stack>
        <Stack.Item grow={1} basis={0}>
          <LabeledList>
            <LabeledList.Item label="Model">{robot.model}</LabeledList.Item>
            <LabeledList.Item label="Location">{robot.locat}</LabeledList.Item>
            <LabeledList.Item label="Status">{robot.mode}</LabeledList.Item>
            {mule && (
              <>
                <LabeledList.Item label="Bot ID">{mule.id}</LabeledList.Item>
                <LabeledList.Item label="Carga carregada">
                  {mule.load || 'N/A'}
                </LabeledList.Item>
                <LabeledList.Item label="Home">{mule.home}</LabeledList.Item>
                <LabeledList.Item label="Destination">
                  {mule.dest || 'N/A'}
                </LabeledList.Item>
                <LabeledList.Item label="Power">
                  <ProgressBar
                    value={mule.power}
                    minValue={0}
                    maxValue={100}
                    ranges={{
                      good: [60, Infinity],
                      average: [20, 60],
                      bad: [-Infinity, 20],
                    }}
                  />
                </LabeledList.Item>
              </>
            )}
          </LabeledList>
        </Stack.Item>
        <Stack.Item width="150px">
          {mule && (
            <>
              <Button
                fluid
                content="Definir destino"
                onClick={() =>
                  act('destination', {
                    robot: mule.mule_ref,
                  })
                }
              />
              <Button
                fluid
                content="Definir identificação"
                onClick={() =>
                  act('setid', {
                    robot: mule.mule_ref,
                  })
                }
              />
              <Button
                fluid
                content="Set Home"
                onClick={() =>
                  act('sethome', {
                    robot: mule.mule_ref,
                  })
                }
              />
              <Button
                fluid
                content="Descarregar carga"
                onClick={() =>
                  act('unload', {
                    robot: mule.mule_ref,
                  })
                }
              />
              <Button.Checkbox
                fluid
                content="Retorno Automático"
                checked={mule.autoReturn}
                onClick={() =>
                  act('autoret', {
                    robot: mule.mule_ref,
                  })
                }
              />
              <Button.Checkbox
                fluid
                content="Recolha automática"
                checked={mule.autoPickup}
                onClick={() =>
                  act('autopick', {
                    robot: mule.mule_ref,
                  })
                }
              />
              <Button.Checkbox
                fluid
                content="Relatório de entrega"
                checked={mule.reportDelivery}
                onClick={() =>
                  act('report', {
                    robot: mule.mule_ref,
                  })
                }
              />
            </>
          )}
          {!mule && (
            <>
              <Button
                fluid
                content="Pare com isso."
                onClick={() =>
                  act('patroloff', {
                    robot: robot.bot_ref,
                  })
                }
              />
              <Button
                fluid
                content="Comece uma patrulha."
                onClick={() =>
                  act('patrolon', {
                    robot: robot.bot_ref,
                  })
                }
              />
              <Button
                fluid
                content="Summon"
                onClick={() =>
                  act('summon', {
                    robot: robot.bot_ref,
                  })
                }
              />
              <Button
                fluid
                content="Ejetar PAI"
                onClick={() =>
                  act('ejectpai', {
                    robot: robot.bot_ref,
                  })
                }
              />
            </>
          )}
        </Stack.Item>
      </Stack>
    </Section>
  );
};

export const DroneInfo = (props) => {
  const { drone } = props;
  const { act, data } = useBackend();
  const color = '(74, 59, 140, 1)';

  return (
    <Section
      title={drone.name}
      style={{
        border: `4px solid ${color}`,
      }}
    >
      <Stack>
        <Stack.Item grow={1} basis={0}>
          <LabeledList>
            <LabeledList.Item label="Status">
              <Box color={drone.status ? 'bad' : 'good'}>
                {drone.status ? 'Não Respondendo' : 'Nominal'}
              </Box>
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
