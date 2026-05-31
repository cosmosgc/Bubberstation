// THIS IS A NOVA SECTOR UI FILE
import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type ReactorInfo = {
  venting: BooleanLike;
  vent_dir: BooleanLike;
  active: BooleanLike;
  safety: BooleanLike;
  overclocked: BooleanLike;
  criticality: number;
  health_percent: number;
  max_power_generation: number;
  safeties_max_power_generation: number;
  raw_last_power_output: number;
  raw_last_power_output_bonus: number;
  last_power_output: string;
  last_power_output_bonus: string;
  last_tritium_consumption: number;
  fuel_time_left: number;
  fuel_time_left_text: string;
  rod: BooleanLike;
  rod_mix_pressure: number;
  rod_pressure_limit: number;
  rod_mix_temperature: number;
  rod_trit_moles: number;
  temperature_limit: number;
  magic_number: number;
  auto_vent_upgrade: BooleanLike;
  auto_vent: BooleanLike;
  jammed: BooleanLike;
  meltdown: BooleanLike;
  overclocked_upgrade: BooleanLike;
};

export const RBMK2 = (props) => {
  const { act, data } = useBackend<ReactorInfo>();
  return (
    <Window width={360} height={710}>
      <Window.Content>
        <Section textAlign="center" title="Status">
          <LabeledList>
            <LabeledList.Item
              label="Activity"
              tooltip="Se o reator for considerado ativo ou não."
            >
              <NoticeBox
                danger
                textAlign="center"
                backgroundColor={data.active ? 'good' : 'bad'}
              >
                {data.active ? 'ONLINE' : 'OFFLINE'}
              </NoticeBox>
            </LabeledList.Item>
            <LabeledList.Item
              label="Stability"
              tooltip="Se o reator for considerado estável ou não."
            >
              <NoticeBox
                danger
                textAlign="center"
                backgroundColor={data.meltdown ? 'danger' : 'good'}
              >
                {data.meltdown ? 'MELTDOWN' : 'STABLE'}
              </NoticeBox>
            </LabeledList.Item>
            <LabeledList.Item
              label="Connection"
              tooltip="A conexão física do reator. Conexões bloqueadas podem causar problemas."
            >
              <NoticeBox
                danger
                textAlign="center"
                backgroundColor={data.jammed ? 'danger' : 'good'}
              >
                {data.jammed ? 'JAMMED' : 'SAFE'}
              </NoticeBox>
            </LabeledList.Item>
            <LabeledList.Item
              label="Geração de Energia"
              tooltip="A geração de energia é influenciada pela temperatura da haste e qualidade das peças. É possível gerar poder de bônus ao ultrapassar o limite de segurança, mas isso não é recomendado."
            >
              <ProgressBar
                value={data.raw_last_power_output}
                minValue={0}
                maxValue={data.safeties_max_power_generation}
                ranges={{
                  danger: [
                    data.max_power_generation,
                    Infinity
                    ],
                  bad: [
                    data.safeties_max_power_generation*0.9,
                    data.max_power_generation
                  ],
                  average: [
                    data.safeties_max_power_generation*0.75,
                    data.safeties_max_power_generation*0.9
                  ],
                  good: [
                    data.safeties_max_power_generation*0.5,
                    data.safeties_max_power_generation*0.75
                  ],
                  cyan: [
                    -Infinity,
                    data.safeties_max_power_generation*0.5               
                  ],
                }}
              >
                {data.raw_last_power_output_bonus > 0 ? `${data.last_power_output} + ${data.last_power_output_bonus}` : data.last_power_output}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item
              label="Pressão da Vara"
              tooltip="Pressões acima de 4500 kPa começam a diminuir a reação, com a velocidade mais lenta em 18.000 kPa. Sistemas de segurança irão desencadear pressões superiores a 9000 kPa."
            >
              <ProgressBar
                value={data.rod_mix_pressure}
                minValue={0}
                maxValue={data.rod_pressure_limit}
                ranges={{
                  bad: [
                    data.rod_pressure_limit,
                    Infinity,
                  ],
                  orange: [
                    data.rod_pressure_limit * 0.9,
                    data.rod_pressure_limit
                  ],
                  average: [
                    data.rod_pressure_limit * 0.6,
                    data.rod_pressure_limit * 0.9
                  ],
                  good: [
                    -Infinity,
                    data.rod_pressure_limit * 0.6
                  ],
                }}
              >
                {data.rod_mix_pressure} kPa
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item
              label="Temperatura do núcleo"
              tooltip="A estimativa geral da temperatura do núcleo, baseada na reatividade do núcleo. Em geral, você nunca deveria deixar isso passar de 9000 Kelvin."
            >
              <ProgressBar
                value={data.magic_number}
                minValue={0}
                maxValue={9000}
                ranges={{
                  bad: [
                    9000,
                    Infinity
                  ],
                  orange: [
                    8000,
                    9000
                  ],
                  average: [
                    7500,
                    8000
                  ],
                  good: [
                    2500,
                    7500
                  ],
                  cyan: [
                   -Infinity,
                   2500
                  ],
                }}
              >
                {data.magic_number} Kelvin
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item
              label="Temperatura da Vara"
              tooltip="À medida que a temperatura da mistura aumenta, o consumo de combustível aumenta, levando a uma maior geração de energia."
            >
              <ProgressBar
                value={data.rod_mix_temperature}
                minValue={0}
                maxValue={data.temperature_limit}
                ranges={{
                  bad: [
                    data.temperature_limit*0.9,
                    Infinity
                  ],
                  orange: [
                    data.temperature_limit*0.75,
                    data.temperature_limit*0.9
                  ],
                  average: [
                    data.temperature_limit*0.5,
                    data.temperature_limit*0.75
                  ],
                  good: [
                    -Infinity,
                    data.temperature_limit*0.5
                  ],
                }}
              >
                {data.rod_mix_temperature} Kelvin
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item
              label="Combustível restante"
              tooltip="Quantidade de trítio restante na haste atual."
            >
              <ProgressBar // Changes color based on rate of consumption while giving you a total reading.
                value={data.fuel_time_left}
                minValue={0}
                maxValue={60*60*3} //3 hours.
                ranges={{
                  bad: [-Infinity, 60*5], //5 minutes
                  orange: [60*5, 60*30], //30 minutes
                  average: [60*30, 60*60], //1 hour
                  good: [60*60, Infinity],
                }}
              >
                {data.rod_trit_moles} Moles ({data.fuel_time_left_text})
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Uso de Trítio">
              {data.last_tritium_consumption}μmol/s
            </LabeledList.Item>
            <LabeledList.Item
              label="Criticality"
              tooltip="Durante os colapsos, os níveis de criticidade aumentam significativamente. À medida que a criticidade aumenta, o risco de falha de integridade explosiva se intensifica (assim como o raio de explosão). Exceder 100% de criticidade representa um grave risco de explosão espontânea do reator. Por favor, não deixe isso acontecer, não queremos outro incidente."
            >
              <ProgressBar
                value={data.criticality}
                minValue={0}
                maxValue={100}
                ranges={{
                  bad: [100, Infinity],
                  orange: [50, 100],
                  average: [5, 50],
                  good: [-Infinity, 5],
                }}
              >
                {data.criticality}%
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item
              label="Integrity"
              tooltip="Integridade estrutural estimada do reator. Não deixe isso cair abaixo de 0%."
            >
              <ProgressBar
                value={data.health_percent}
                minValue={0}
                maxValue={100}
                ranges={{
                  good: [90, Infinity],
                  average: [50, 90],
                  orange: [25, 50],
                  bad: [-Infinity, 25],
                }}
              >
                {data.health_percent}%
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Controls" textAlign="center">
          <LabeledList>
            <Button.Confirm
              tooltip="Botão de ativação/desativação do reator"
              textAlign="center"
              width="100%"
              icon="fa-power-off"
              confirmContent="Tem certeza?"
              color={data.active ? 'average' : 'good'}
              onClick={() => act('activate')}
            >
              {data.active ? 'Deactivate' : 'Activate'}
            </Button.Confirm>
            {data.rod ? (
              <Button.Confirm
                tooltip="Ejeções atualmente inseridas. Não conseguimos recriar isso consistentemente nos testes, mas este botão pode (raramente) desapertar a haste. É melhor usar um pé de cabra."
                textAlign="center"
                width="100%"
                icon="fa-eject"
                color="orange"
                onClick={() => act('eject')}
              >
                Eject Fuel Rod
              </Button.Confirm>
            ) : (
              <NoticeBox danger textAlign="center">
                No control rod to eject
              </NoticeBox>
            )}
          </LabeledList>
          <Section title="Controles de ventilação" textAlign="center">
            NOTICE: The vents must be off to change directions.
            <br />
            <i>(This is a cost saving measure - do not print this part.)</i>
          </Section>
          <LabeledList>
            <LabeledList.Item
              label="Potência de ventilação"
              buttons={
                <>
                  <Box inline mx={2} color={data.venting ? 'good' : 'orange'}>
                    {data.venting ? 'ONLINE' : 'OFFLINE'}
                  </Box>
                  <Button.Confirm
                    tooltip="Activar/desligar a ventilação."
                    textAlign="center"
                    icon="fa-fan"
                    color={data.venting ? 'orange' : 'good'}
                    onClick={() => act('venttoggle')}
                  >
                    TOGGLE
                  </Button.Confirm>
                </>
              }
            />
            <LabeledList.Item
              label="Direção de Vent"
              buttons={
                <>
                  <Box inline mx={5.68} color={data.vent_dir ? 'orange' : 'good'}>
                    {data.vent_dir ? 'PULLING' : 'PUSHING'}
                  </Box>
                  <Button
                    tooltip="Ajuste as aberturas para tirar ar do ambiente circundante para a câmara interna da RBMK2."
                    icon="fa-clock-rotate-left"
                    disabled={data.venting}
                    color={data.vent_dir ? 'caution' : 'blue'}
                    onClick={() => act('ventpull')}
                  />
                  <Button
                    tooltip="Ajuste as aberturas para liberar o conteúdo da câmara interna do RBMK2 no ambiente circundante."
                    icon="Fa-clock-rotate-esquerda fa-flip-horizontal"
                    disabled={data.venting}
                    color={data.vent_dir ? 'blue' : 'good'}
                    onClick={() => act('ventpush')}
                  />
                  <Button
                    tooltip="Ajuste as saídas para abrir automaticamente quando muito quente, e feche quando muito frio. Requer um disco de atualização automática."
                    icon="fa-balance-scale"
					disabled={!data.auto_vent_upgrade}
                    color={data.auto_vent ? 'good' : 'blue'}
                    onClick={() => act('autovent')}
                  />
                </>
              }
            />
          </LabeledList>
          <Section title="Controles." textAlign="center">
            WARNING: Settings within this section may explosively void your
            warranty.
          </Section>
          <LabeledList>
            <LabeledList.Item
              label="Overclock"
              buttons={
                <>
                  <Box inline mx={2} color={data.overclocked ? 'good' : 'orange'}>
                    {data.overclocked ? 'ONLINE' : 'OFFLINE'}
                  </Box>
                  <Button.Confirm
                    tooltip="Aumenta a potência ao custo de mais trítio consumido e mais calor gerado. Requer overlock do disco de atualização."
                    icon="exclamation-triangle"
                    color={data.overclocked ? 'average' : 'good'}
					disabled={!data.overclocked_upgrade}
                    onClick={() => act('overclocktoggle')}
                  >
                    TOGGLE
                  </Button.Confirm>
                </>
              }
            />
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
