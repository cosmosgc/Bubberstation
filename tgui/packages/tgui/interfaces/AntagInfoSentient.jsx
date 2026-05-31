import { BlockQuote, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const AntagInfoSentient = (props) => {
  const { act, data } = useBackend();
  const { enslaved_to, holographic, p_them, p_their } = data;
  return (
    <Window width={400} height={400} theme="neutral">
      <Window.Content>
        <Section fill>
          <Stack vertical fill textAlign="center">
            <Stack.Item fontSize="20px">
              You are a sentient creature!
            </Stack.Item>
            <Stack.Item>
              <BlockQuote>
                All at once it makes sense: you know what you are and who you
                are! Self awareness is yours!
                {!!enslaved_to &&
                  'Você é grato por estar consciente e devendo' +
                    enslaved_to +
                    'Uma grande dívida. Sirva' +
                    enslaved_to +
                    ', e ajudar' +
                    p_them +
                    'completando' +
                    p_their +
                    'Gols a qualquer custo.'}
                {!!holographic &&
                  'Você também fica depressivamente consciente de que não é uma criatura real, mas sim uma holoforma. Sua existência está limitada aos parâmetros do holodeque.'}
              </BlockQuote>
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
