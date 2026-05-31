// THIS IS A SKYRAT UI FILE
import { Button, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const AntagInfoOpfor = (props) => {
  const { act } = useBackend();
  return (
    <Window width={620} height={250}>
      <Window.Content>
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item fontSize="20px" color={'good'}>
              {'Você é um candidato da OPFOR!'}
            </Stack.Item>
            {
              'Você é encorajado a OPFOR para executar uma ação antagônica de alguma forma.'
            }
            {
              'Se você não tem nenhuma idéia, verifique #jogador-submetido-opfors na Discórdia para inspiração.'
            }
            {
              'E se você não quiser OPFOR, simplesmente pressione o botão abaixo para remover seu status.'
            }
            <Stack.Item align="center">
              <Button
                color="red"
                content={'Remover status'}
                tooltip={'Retire seu status de candidato da OPFOR.'}
                onClick={() => act('pass_on')}
              />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
