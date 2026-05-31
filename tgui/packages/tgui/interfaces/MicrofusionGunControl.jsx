// THIS IS A SKYRAT UI FILE
import {
  Button,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const MicrofusionGunControl = (props) => {
  const { act, data } = useBackend();
  const { cell_data } = data;
  const { phase_emitter_data } = data;
  const {
    gun_name,
    gun_desc,
    gun_heat_dissipation,
    has_cell,
    has_emitter,
    has_attachments,
    attachments = [],
  } = data;
  return (
    <Window
      title={`Micron Control Systems Incorporated: ${gun_name}`}
      width={500}
      height={700}
    >
      <Window.Content>
        <Stack vertical grow>
          <Stack.Item>
            <Section title={'Informações sobre armas'}>
              <LabeledList>
                <LabeledList.Item label="Name">{gun_name}</LabeledList.Item>
                <LabeledList.Item label="Description">
                  {gun_desc}
                </LabeledList.Item>
                <LabeledList.Item label="Dissipação de calor ativa">
                  {`${gun_heat_dissipation} C/s`}
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section
              title="Célula de Energia"
              buttons={
                <Button
                  icon="eject"
                  content="Ejetar Célula"
                  disabled={!has_cell}
                  onClick={() => act('eject_cell')}
                />
              }
            >
              {has_cell ? (
                <LabeledList>
                  <LabeledList.Item label="Tipo de Célula">
                    {cell_data.type}
                  </LabeledList.Item>
                  <LabeledList.Item label="Status da célula">
                    {cell_data.status ? 'ERROR' : 'Nominal'}
                  </LabeledList.Item>
                  <LabeledList.Item label="Carga de Células">
                    <ProgressBar
                      value={cell_data.charge}
                      minValue={0}
                      maxValue={cell_data.max_charge}
                      ranges={{
                        good: [
                          cell_data.max_charge * 0.85,
                          cell_data.max_charge,
                        ],
                        average: [
                          cell_data.max_charge * 0.25,
                          cell_data.max_charge * 0.85,
                        ],
                        bad: [0, cell_data.max_charge * 0.25],
                      }}
                    >
                      {`${cell_data.charge}/${cell_data.max_charge}MF`}
                    </ProgressBar>
                  </LabeledList.Item>
                  {!!cell_data.charge <= 0 && (
                    <LabeledList.Item>
                      <Section>
                        <NoticeBox color="bad">Charge depleted!</NoticeBox>
                      </Section>
                    </LabeledList.Item>
                  )}
                </LabeledList>
              ) : (
                <NoticeBox color="bad">No cell installed!</NoticeBox>
              )}
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section
              title="Emissário de Fase"
              buttons={
                <Button
                  icon="eject"
                  content="Emissário Ejetar"
                  disabled={!has_emitter}
                  onClick={() => act('eject_emitter')}
                />
              }
            >
              {has_emitter ? (
                phase_emitter_data.damaged ? (
                  <NoticeBox color="bad">Phase emitter is damaged!</NoticeBox>
                ) : (
                  <LabeledList>
                    <LabeledList.Item label="Emissário Tipo">
                      {phase_emitter_data.type}
                    </LabeledList.Item>
                    <LabeledList.Item label="Temperature">
                      <ProgressBar
                        value={phase_emitter_data.current_heat}
                        minValue={0}
                        maxValue={phase_emitter_data.max_heat}
                        ranges={{
                          bad: [
                            phase_emitter_data.max_heat * 0.85,
                            phase_emitter_data.max_heat * 2,
                          ],
                          average: [
                            phase_emitter_data.max_heat * 0.25,
                            phase_emitter_data.max_heat * 0.85,
                          ],
                          good: [0, phase_emitter_data.max_heat * 0.25],
                        }}
                      >
                        {toFixed(phase_emitter_data.current_heat) +
                          ' C' +
                          ' (' +
                          phase_emitter_data.heat_percent +
                          '%)'}
                      </ProgressBar>
                    </LabeledList.Item>
                    <LabeledList.Item label="Temperatura máxima">
                      {`${phase_emitter_data.max_heat} C`}
                    </LabeledList.Item>
                    <LabeledList.Item label="Percentagem de temperatura">
                      {`${phase_emitter_data.throttle_percentage}% `}
                      <Button
                        icon="wrench"
                        content="Overclock"
                        color="bad"
                        disabled={!phase_emitter_data.hacked}
                        onClick={() => act('overclock_emitter')}
                      />
                    </LabeledList.Item>
                    <LabeledList.Item label="Dissipação de calor passivo">
                      {`${phase_emitter_data.heat_dissipation_per_tick} C/s`}
                    </LabeledList.Item>
                    <LabeledList.Item label="Sistema de Resfriamento">
                      <Button
                        icon="snowflake"
                        content={
                          phase_emitter_data.cooling_system
                            ? 'ONLINE'
                            : 'OFFLINE'
                        }
                        color={
                          phase_emitter_data.cooling_system ? 'blue' : 'bad'
                        }
                        disabled={!has_cell}
                        onClick={() => act('toggle_cooling_system')}
                      />
                      {'Taxa do sistema de refrigeração:' +
                        phase_emitter_data.cooling_system_rate +
                        ' C/s'}
                    </LabeledList.Item>
                    <LabeledList.Item label="Total dissipação de calor">
                      {phase_emitter_data.cooling_system
                        ? phase_emitter_data.heat_dissipation_per_tick +
                          gun_heat_dissipation +
                          phase_emitter_data.cooling_system_rate +
                          ' C/s'
                        : phase_emitter_data.heat_dissipation_per_tick +
                          gun_heat_dissipation +
                          ' C/s'}
                    </LabeledList.Item>
                    <LabeledList.Item label="Integrity">
                      <ProgressBar
                        value={phase_emitter_data.integrity}
                        minValue={0}
                        maxValue={100}
                        ranges={{
                          good: [85, 100],
                          average: [25, 85],
                          bad: [0, 25],
                        }}
                      >
                        {`${phase_emitter_data.integrity}%`}
                      </ProgressBar>
                    </LabeledList.Item>
                    <LabeledList.Item label="Processo de tempo por tiro">
                      <ProgressBar
                        value={phase_emitter_data.process_time}
                        minValue={0}
                        maxValue={5}
                        ranges={{
                          good: [0, 1],
                          average: [1, 3],
                          bad: [3, 5],
                        }}
                      >
                        {`${phase_emitter_data.process_time / 10}s`}
                      </ProgressBar>
                    </LabeledList.Item>
                    {phase_emitter_data.heat_percent >=
                      phase_emitter_data.throttle_percentage && (
                      <LabeledList.Item>
                        <NoticeBox color="orange">
                          Thermal throttle active!
                        </NoticeBox>
                      </LabeledList.Item>
                    )}
                    {phase_emitter_data.current_heat >=
                      phase_emitter_data.max_heat && (
                      <LabeledList.Item>
                        <NoticeBox color="bad">Overheating!</NoticeBox>
                      </LabeledList.Item>
                    )}
                  </LabeledList>
                )
              ) : (
                <NoticeBox color="bad">No phase emitter installed!</NoticeBox>
              )}
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section title={'Attachments'}>
              {has_attachments ? (
                attachments.map((attachment, index) => (
                  <Section
                    key={index}
                    title={attachment.name}
                    buttons={
                      <Button
                        icon="eject"
                        content="Ejetar o Anexo"
                        onClick={() =>
                          act('remove_attachment', {
                            attachment_ref: attachment.ref,
                          })
                        }
                      />
                    }
                  >
                    <LabeledList>
                      <LabeledList.Item label="Description">
                        {attachment.desc}
                      </LabeledList.Item>
                      <LabeledList.Item label="Slot">
                        {attachment.slot}
                      </LabeledList.Item>
                      {attachment.information && (
                        <LabeledList.Item label="Information">
                          {attachment.information}
                        </LabeledList.Item>
                      )}
                      {!!attachment.has_modifications &&
                        attachment.modify.map((mod, index) => (
                          <LabeledList.Item
                            key={index}
                            buttons={
                              <Button
                                key={index}
                                icon={mod.icon}
                                color={mod.color}
                                content={mod.title}
                                onClick={() =>
                                  act('modify_attachment', {
                                    attachment_ref: attachment.ref,
                                    modify_ref: mod.reference,
                                  })
                                }
                              />
                            }
                          />
                        ))}
                    </LabeledList>
                  </Section>
                ))
              ) : (
                <NoticeBox color="blue">No attachments installed!</NoticeBox>
              )}
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
