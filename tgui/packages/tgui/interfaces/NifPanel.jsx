// THIS IS A SKYRAT UI FILE
import { useState } from 'react';
import {
  BlockQuote,
  Box,
  Button,
  Collapsible,
  Dropdown,
  Flex,
  Icon,
  Input,
  LabeledList,
  ProgressBar,
  Section,
  Table,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const NifPanel = (props) => {
  const { act, data } = useBackend();
  const {
    linked_mob_name,
    loaded_nifsofts,
    max_nifsofts,
    max_power,
    current_theme,
  } = data;
  const [settingsOpen, setSettingsOpen] = useState(0);

  return (
    <Window
      title={'Framework de Implantes Nanita'}
      width={500}
      height={400}
      resizable
      theme={current_theme}
    >
      <Window.Content>
        <Section
          title={`Welcome to your NIF, ${linked_mob_name}`}
          buttons={
            <Button
              icon="cogs"
              tooltip="Configurações NIF"
              tooltiptooltipPosition="bottom-end"
              selected={settingsOpen}
              onClick={() => setSettingsOpen(!settingsOpen)}
            />
          }
        >
          {(settingsOpen && <NifSettings />) || <NifStats />}
          {(!settingsOpen && (
            <Section
              title={`NIFSoft Programs (${
                max_nifsofts - loaded_nifsofts.length
              } Slots Remaining)`}
              right
            >
              {(loaded_nifsofts.length && (
                <Flex direction="column">
                  {loaded_nifsofts.map((nifsoft) => (
                    <Flex.Item key={nifsoft.name}>
                      <Collapsible
                        title={
                          <>
                            {<Icon name={nifsoft.ui_icon} />}
                            {`${nifsoft.name}  `}
                          </>
                        }
                        buttons={
                          <Button
                            icon="play"
                            color="green"
                            onClick={() =>
                              act('activate_nifsoft', {
                                activated_nifsoft: nifsoft.reference,
                              })
                            }
                          />
                        }
                      >
                        <Table>
                          <Table.Row>
                            <Table.Cell>
                              <Button
                                icon="bolt"
                                color="yellow"
                                tooltip="Que porcentagem da energia é usada para ativar o NIFSoft"
                              />
                              {nifsoft.activation_cost === 0
                                ? 'Sem custo de ativação.'
                                : ' ' +
                                  (nifsoft.activation_cost / max_power) * 100 +
                                  '% por ativação'}
                            </Table.Cell>
                            <Table.Cell>
                              <Button
                                icon="battery-half"
                                color="orange"
                                tooltip="O poder que o NIFSoft usa equanto ativo"
                                disabled={nifsoft.active_cost === 0}
                              />
                              {nifsoft.active_cost === 0
                                ? 'Nenum Dreno Ativo.'
                                : ' ' +
                                  (nifsoft.active_cost / max_power) * 100 +
                                  'Consumido enquanto ativo'}
                            </Table.Cell>
                            <Table.Cell>
                              <Button
                                icon="exclamation"
                                color={nifsoft.active ? 'green' : 'red'}
                                disabled={!nifsoft.active_mode}
                                tooltip="Mostra se um programa está ativo ou não."
                              />
                              {nifsoft.active
                                ? 'O NIFSoft está ativo!'
                                : 'O NIFSoft está inativo!'}
                            </Table.Cell>
                          </Table.Row>
                        </Table>
                        <br />
                        <BlockQuote preserveWhitespace>
                          {nifsoft.desc}
                        </BlockQuote>
                        {nifsoft.able_to_keep && (
                          <box>
                            <br />
                            <Button
                              icon="floppy-disk"
                              content={
                                nifsoft.keep_installed
                                  ? 'O NIFSoft ficará salvo.'
                                  : "O NIFSoft não ficará salvo."
                              }
                              color={nifsoft.keep_installed ? 'green' : 'red'}
                              fluid
                              tooltip="Se o NIFSoft ficar salva entre turnos"
                              onClick={() =>
                                act('toggle_keeping_nifsoft', {
                                  nifsoft_to_keep: nifsoft.reference,
                                })
                              }
                            />
                          </box>
                        )}
                        <box>
                          <br />
                          <Button.Confirm
                            icon="trash"
                            content="Uninstall"
                            color="red"
                            fluid
                            tooltip="Desinstale o NIFSoft selecionado."
                            confirmContent="Temcereza?"
                            confirmIcon="question"
                            onClick={() =>
                              act('uninstall_nifsoft', {
                                nifsoft_to_remove: nifsoft.reference,
                              })
                            }
                          />
                        </box>
                      </Collapsible>
                    </Flex.Item>
                  ))}
                </Flex>
              )) || (
                <Box>
                  {' '}
                  <center>
                    <b>There are no NIFSofts currently installed</b>
                  </center>{' '}
                </Box>
              )}
            </Section>
          )) || (
            <Section title={'Informação do Produto'}>
              <NifProductNotes />
            </Section>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};

const NifSettings = (props) => {
  const { act, data } = useBackend();
  const {
    nutrition_drain,
    ui_themes,
    current_theme,
    nutrition_level,
    blood_drain,
    minimum_blood_level,
    blood_level,
    stored_points,
    nif_examine_text,
  } = data;
  return (
    <LabeledList>
      <LabeledList.Item label="NIF Tema">
        <Dropdown
          width="100%"
          selected={current_theme}
          options={ui_themes}
          onSelected={(value) => act('change_theme', { target_theme: value })}
        />
      </LabeledList.Item>
      <LabeledList.Item label="NIF Sabor Text">
        <Input
          onBlur={(value) => act('change_examine_text', { new_text: value })}
          value={nif_examine_text}
          width="100%"
        />
      </LabeledList.Item>
      <LabeledList.Item label="Drenagem Nutricional">
        <Button
          fluid
          content={
            nutrition_drain === 0
              ? 'Dreno Nutritional Desabilitado'
              : 'Dreno Nutritional Ativado'
          }
          tooltip="Alterna a habilidade do NIF usar sua comida como fonte de energia. Permitir isso pode resultar em maior fome."
          onClick={() => act('toggle_nutrition_drain')}
          disabled={nutrition_level < 26}
        />
      </LabeledList.Item>
      <LabeledList.Item label="Dreno de Sangue">
        <Button
          fluid
          content={
            blood_drain === 0 ? 'Drenagem de Sangue Desativada' : 'Dreno de sangue ativado'
          }
          tooltip="Alterna a habilidade do NIF de drenar sangue de você. Isso vai desligar automaticamente quando chegar perto de um nível de sangue inseguro."
          onClick={() => act('toggle_blood_drain')}
          disabled={blood_level < minimum_blood_level}
        />
      </LabeledList.Item>
      <LabeledList.Item
        label="Pontos de recompensa"
        buttons={
          <Button
            icon="info"
            tooltip="Pontos de recompensa são uma moeda alternativa ganha com a compra de NIFSofts, pontos de recompensa levam entre turnos."
          />
        }
      >
        {stored_points}
      </LabeledList.Item>
    </LabeledList>
  );
};

const NifProductNotes = (props) => {
  const { act, data } = useBackend();
  const { product_notes } = data;
  return <BlockQuote>{product_notes}</BlockQuote>;
};

const NifStats = (props) => {
  const { act, data } = useBackend();
  const {
    max_power,
    power_level,
    durability,
    power_usage,
    nutrition_drain,
    blood_drain,
    max_durability,
  } = data;

  return (
    <Box>
      <LabeledList>
        <LabeledList.Item label="Condição NIF">
          <ProgressBar
            value={durability}
            minValue={0}
            maxValue={max_durability}
            ranges={{
              good: [max_durability * 0.66, max_durability],
              average: [max_durability * 0.33, max_durability * 0.66],
              bad: [0, max_durability * 0.33],
            }}
            alertAfter={max_durability * 0.25}
          />
        </LabeledList.Item>
        <LabeledList.Item label="NIF Power">
          <ProgressBar
            value={power_level}
            minValue={0}
            maxValue={max_power}
            ranges={{
              good: [max_power * 0.66, max_power],
              average: [max_power * 0.33, max_power * 0.66],
              bad: [0, max_power * 0.33],
            }}
            alertAfter={max_power * 0.1}
          >
            {(power_level / max_power) * 100 +
              '%' +
              ' (' +
              (power_usage / max_power) * 100 +
              'Uso em %)'}
          </ProgressBar>
        </LabeledList.Item>
        {nutrition_drain === 1 && (
          <LabeledList.Item label="Nutrição do Usuário">
            <NifNutritionBar />
          </LabeledList.Item>
        )}
        {blood_drain === 1 && (
          <LabeledList.Item label="Nível de sangue do usuário">
            <NifBloodBar />
          </LabeledList.Item>
        )}
      </LabeledList>
    </Box>
  );
};

const NifNutritionBar = (props) => {
  const { act, data } = useBackend();
  const { nutrition_level } = data;
  return (
    <ProgressBar
      value={nutrition_level}
      minValue={0}
      maxValue={550}
      ranges={{
        good: [250, Infinity],
        average: [150, 250],
        bad: [0, 150],
      }}
    />
  );
};

const NifBloodBar = (props) => {
  const { act, data } = useBackend();
  const { blood_level, minimum_blood_level, max_blood_level } = data;
  return (
    <ProgressBar
      value={blood_level}
      minValue={0}
      maxValue={max_blood_level}
      ranges={{
        good: [minimum_blood_level, Infinity],
        average: [336, minimum_blood_level],
        bad: [0, 336],
      }}
    />
  );
};
