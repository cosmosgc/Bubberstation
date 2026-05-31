import {
  AnimatedNumber,
  Box,
  Button,
  LabeledList,
  Section,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  points: number;
  pad: string;
  sending: BooleanLike;
  status_report: string;
};

export const CargoHoldTerminal = (props) => {
  const { act, data } = useBackend<Data>();
  const { points, pad, sending, status_report } = data;

  return (
    <Window width={600} height={230}>
      <Window.Content scrollable>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Valor atual da carga">
              <Box inline bold>
                <AnimatedNumber value={Math.round(points)} /> credits
              </Box>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section
          title="Cargo Pad"
          buttons={
            <>
              <Button
                icon={'sync'}
                content={'Recalcular o Valor'}
                disabled={!pad}
                onClick={() => act('recalc')}
              />
              <Button
                icon={sending ? 'times' : 'arrow-up'}
                content={sending ? 'Pare de enviar' : 'Enviar mercadorias'}
                selected={sending}
                disabled={!pad}
                onClick={() => act(sending ? 'stop' : 'send')}
              />
            </>
          }
        >
          <LabeledList>
            <LabeledList.Item label="Status" color={pad ? 'good' : 'bad'}>
              {pad ? 'Online' : 'Não Encontrado'}
            </LabeledList.Item>
            <LabeledList.Item label="Relatório de Carga">
              {status_report}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
