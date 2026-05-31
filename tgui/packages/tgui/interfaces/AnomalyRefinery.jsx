import {
  Box,
  Button,
  Icon,
  LabeledList,
  Modal,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';
import { GasmixParser } from './common/GasmixParser';

export const AnomalyRefinery = (props) => {
  return (
    <Window title="Refinaria Anomalia" width={550} height={350}>
      <Window.Content>
        <AnomalyRefineryContent />
      </Window.Content>
    </Window>
  );
};

const AnomalyRefineryContent = (props) => {
  const { act, data } = useBackend();
  const [currentTab, changeTab] = useSharedState('exploderTab', 1);
  const { core, valvePresent, active } = data;

  return (
    <Stack vertical fill>
      {currentTab === 1 && <CoreCompressorContent />}
      {currentTab === 2 && <BombProcessorContent />}
      <Stack.Item>
        <Stack>
          <Stack.Item grow>
            <Button
              fluid
              textAlign="center"
              icon="eject"
              disabled={!core || active}
              onClick={() => act('eject_core')}
            >
              {'Ejetar o Núcleo'}
            </Button>
          </Stack.Item>
          <Stack.Item grow>
            <Button
              fluid
              textAlign="center"
              icon={currentTab === 1 ? 'server' : 'compress-arrows-alt'}
              onClick={() => changeTab(currentTab === 1 ? 2 : 1)}
            >
              {currentTab === 1 ? 'Executar Simulações' : 'Controle de Implosão'}
            </Button>
          </Stack.Item>
          <Stack.Item grow>
            <Button
              fluid
              textAlign="center"
              icon="eject"
              disabled={!valvePresent || active}
              onClick={() => act('eject_bomb')}
            >
              {'Ejetar bomba'}
            </Button>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

const CoreCompressorContent = (props) => {
  const { act, data } = useBackend();
  const { core, requiredRadius, gasList, valveReady, active, valvePresent } =
    data;
  return (
    <>
      <Stack.Item grow>
        <Section
          fill
          title="Núcleo Inserído"
          buttons={
            <Button
              icon="compress-arrows-alt"
              backgroundColor="red"
              onClick={() => act('start_implosion')}
              disabled={active || !valveReady || !core}
            >
              {'Implode Core'}
            </Button>
          }
        >
          {!core && <Modal textAlign="center">{'Sem núcleo inserido!'}</Modal>}
          <LabeledList>
            <LabeledList.Item label={'Name'}>
              {core ? core : '-'}
            </LabeledList.Item>
            <LabeledList.Item label={'Raio necessário.'}>
              {requiredRadius
                ? `${requiredRadius} tiles`
                : 'Implosão não é possível.'}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
      <Stack.Item grow>
        <Section
          fill
          title="Bomba Inserida"
          buttons={
            <Button
              disabled={!valveReady}
              icon="exchange-alt"
              onClick={() => act('swap')}
            >
              {'Trocar Ordem de Fusão'}
            </Button>
          }
        >
          {!valvePresent && (
            <Modal textAlign="center">{'Nenhuma bomba inserida!'}</Modal>
          )}
          <Stack align="center">
            <Stack.Item grow textAlign="center">
              <Box height={2} width="100%" bold>
                {'Tanque Giver (' +
                  (gasList[1].name ? gasList[1].name : 'Não Disponível') +
                  ')'}
              </Box>
              <Box height={2} width="100%">
                {(gasList[1].total_moles
                  ? String(gasList[0].total_moles.toFixed(2))
                  : '-') +
                  'Toupeiras em' +
                  (gasList[1].total_moles
                    ? String(gasList[1].temperature.toFixed(2))
                    : '-') +
                  ' Kelvin'}
              </Box>
              <Box height={2} width="100%">
                {`${
                  gasList[1].total_moles
                    ? String(gasList[1].pressure.toFixed(2))
                    : '-'
                } kPa`}
              </Box>
            </Stack.Item>
            <Stack.Item>
              <Icon size={2} name="arrow-right" />
            </Stack.Item>
            <Stack.Item grow textAlign="center">
              <Box height={2} width="100%" bold>
                {'Tanque Alvo (' +
                  (gasList[0].name ? gasList[0].name : 'Não Disponível') +
                  ')'}
              </Box>
              <Box height={2} width="100%">
                {(gasList[0].total_moles
                  ? String(gasList[0].total_moles.toFixed(2))
                  : '-') +
                  'Toupeiras em' +
                  (gasList[0].total_moles
                    ? String(gasList[0].temperature.toFixed(2))
                    : '-') +
                  ' Kelvin'}
              </Box>
              <Box height={2} width="100%">
                {`${
                  gasList[1].total_moles
                    ? String(gasList[0].pressure.toFixed(2))
                    : '-'
                } kPa`}
              </Box>
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
    </>
  );
};
const BombProcessorContent = (props) => {
  const { act, data } = useBackend();
  const { gasList, reactionIncrement } = data;
  return (
    <>
      <Stack.Item grow>
        <Section
          fill
          title={gasList[2].name}
          scrollable
          buttons={
            <Button
              tooltip={
                reactionIncrement === 0
                  ? 'Estado da válvula: fechado.'
                  : 'Posição da válvula aberta. Contagem de reação atual:' +
                    reactionIncrement
              }
              icon="vial"
              tooltipPosition="left"
              onClick={() => act('react')}
              textAlign="center"
              disabled={!gasList[0].total_moles || !gasList[1].total_moles}
              content={reactionIncrement === 0 ? 'Abra a válvula.' : 'React'}
            />
          }
        >
          {!gasList[2].total_moles && (
            <Modal textAlign="center">{'Sem gás presente'}</Modal>
          )}
          <GasmixParser gasmix={gasList[2]} />
        </Section>
      </Stack.Item>
      <Stack.Item grow>
        <Stack fill>
          {[gasList[0], gasList[1]].map((individualGasmix) => (
            <Stack.Item grow key={individualGasmix.ref}>
              <Section
                fill
                scrollable
                title={
                  individualGasmix.name
                    ? individualGasmix.name
                    : 'Não Disponível'
                }
              >
                {!individualGasmix.total_moles && (
                  <Modal textAlign="center">{'Sem gás presente'}</Modal>
                )}
                <GasmixParser gasmix={individualGasmix} />
              </Section>
            </Stack.Item>
          ))}
        </Stack>
      </Stack.Item>
    </>
  );
};
