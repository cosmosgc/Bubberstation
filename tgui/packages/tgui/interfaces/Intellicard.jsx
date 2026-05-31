import {
  BlockQuote,
  Button,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const Intellicard = (props) => {
  const { act, data } = useBackend();
  const {
    name,
    isDead,
    isBraindead,
    health,
    wireless,
    radio,
    wiping,
    laws = [],
  } = data;
  const offline = isDead || isBraindead;
  return (
    <Window width={500} height={500}>
      <Window.Content scrollable>
        <Section
          title={name || 'Cartão Vazio'}
          buttons={
            !!name && (
              <Button
                icon="trash"
                content={wiping ? 'Pare de limpar.' : 'Wipe'}
                disabled={isDead}
                onClick={() => act('wipe')}
              />
            )
          }
        >
          {!!name && (
            <LabeledList>
              <LabeledList.Item label="Status" color={offline ? 'bad' : 'good'}>
                {offline ? 'Offline' : 'Operation'}
              </LabeledList.Item>
              <LabeledList.Item label="Integridade de Software">
                <ProgressBar
                  value={health}
                  minValue={0}
                  maxValue={100}
                  ranges={{
                    good: [70, Infinity],
                    average: [50, 70],
                    bad: [-Infinity, 50],
                  }}
                />
              </LabeledList.Item>
              <LabeledList.Item label="Settings">
                <Button
                  icon="signal"
                  content="Atividade sem fio"
                  selected={wireless}
                  onClick={() => act('wireless')}
                />
                <Button
                  icon="microphone"
                  content="Rádio subespacial"
                  selected={radio}
                  onClick={() => act('radio')}
                />
              </LabeledList.Item>
              <LabeledList.Item label="Laws">
                {laws.map((law) => (
                  <BlockQuote key={law}>{law}</BlockQuote>
                ))}
              </LabeledList.Item>
            </LabeledList>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
