import { LabeledList, Section } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  sensorStatus: BooleanLike;
  operatingStatus: number;
  inboundPlatform: number;
  outboundPlatform: number;
};

export const CrossingSignal = (props) => {
  const { data } = useBackend<Data>();

  const { sensorStatus, operatingStatus, inboundPlatform, outboundPlatform } =
    data;

  return (
    <Window title="Sinal de cruzamento" width={400} height={175} theme="dark">
      <Window.Content>
        <Section title="Estado do Sistema">
          <LabeledList>
            <LabeledList.Item
              label="Estado Operacional"
              color={operatingStatus ? 'bad' : 'good'}
            >
              {operatingStatus ? 'Degraded' : 'Normal'}
            </LabeledList.Item>
            <LabeledList.Item
              label="Estado do sensor"
              color={sensorStatus ? 'good' : 'bad'}
            >
              {sensorStatus ? 'Connected' : 'Error'}
            </LabeledList.Item>
            <LabeledList.Item label="Plataforma de entrada">
              {inboundPlatform}
            </LabeledList.Item>
            <LabeledList.Item label="Plataforma de saída">
              {outboundPlatform}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
