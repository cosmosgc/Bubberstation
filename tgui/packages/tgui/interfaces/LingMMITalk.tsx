import { useState } from 'react';
import { Button, ByondUi, Stack, TextArea } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  mmi_view: string;
};

export const LingMMITalk = (props) => {
  const { data, act } = useBackend<Data>();
  const [mmiMessage, setmmiMessage] = useState('');

  return (
    <Window title="Tradução e Sincronia:" height={360} width={360}>
      <Window.Content>
        <Stack vertical>
          <Stack.Item align="center">
            <ByondUi
              width="240px"
              height="240px"
              params={{
                id: data.mmi_view,
                type: 'map',
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <Stack width="100%">
              <Stack.Item width="85%">
                <TextArea
                  fluid
                  height="60px"
                  placeholder="Envie uma mensagem para nosso cérebro chamariz falar."
                  onChange={setmmiMessage}
                  value={mmiMessage}
                />
              </Stack.Item>
              <Stack.Item align="center">
                <Button
                  textAlign="center"
                  onClick={() => {
                    act('send_mmi_message', { message: mmiMessage });
                    setmmiMessage('');
                  }}
                >
                  Send
                </Button>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
