import { Box, Icon, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  help_text: string;
};

const DEFAULT_HELP = `No information available! Ask for assistance if needed.`;

const boxHelp = [
  {
    color: 'purple',
    text: 'Estude a área e faça o que precisa ser feito para recuperar a caixa. Preste atenção nas informações de domínio e pistas de contexto.',
    icon: 'search-location',
    title: 'Search',
  },
  {
    color: 'green',
    text: 'Traga a caixa para o local de envio designado no esconderijo. A área pode parecer fora do lugar. Examine o esconderijo para encontrá-lo.',
    icon: 'boxes',
    title: 'Recover',
  },
  {
    color: 'blue',
    text: 'A escada representa a maneira mais segura de desconectar antes do esconderijo ser recuperado. Se sua conexão se romper, a netpod oferece potencial de ressuscitação limitado.',
    icon: 'plug',
    title: 'Disconnect',
  },
  {
    color: 'yellow',
    text: 'Enquanto estão conectados, estão a salvo de perigos ambientais e intrusões, mas não completamente. Preste atenção aos alertas.',
    icon: 'id-badge',
    title: 'Security',
  },
  {
    color: 'gold',
    text: 'Gerar avatares custa uma tremenda largura de banda. Não os desperdice.',
    icon: 'coins',
    title: 'Tentativas Limitadas',
  },
  {
    color: 'red',
    text: 'Lembre-se que você está fisicamente ligado a esta presença. Você é um corpo estranho em um ambiente hostil. Vai tentar ejetar você com força.',
    icon: 'skull-crossbones',
    title: 'Perigo percebido',
  },
] as const;

export const AvatarHelp = (props) => {
  const { data } = useBackend<Data>();
  const { help_text = DEFAULT_HELP } = data;

  return (
    <Window title="Informação de Domínio" width={600} height={600}>
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item grow>
            <Section
              color="good"
              fill
              scrollable
              title="Bem-vindo ao Domínio Virtual."
            >
              {help_text}
            </Section>
          </Stack.Item>
          <Stack.Item grow={4}>
            <Stack fill vertical>
              <Stack.Item grow>
                <Stack fill>
                  {[0, 1].map((i) => (
                    <BoxHelp index={i} key={i} />
                  ))}
                </Stack>
              </Stack.Item>
              <Stack.Item grow>
                <Stack fill>
                  {[2, 3].map((i) => (
                    <BoxHelp index={i} key={i} />
                  ))}
                </Stack>
              </Stack.Item>
              <Stack.Item grow>
                <Stack fill>
                  {[4, 5].map((i) => (
                    <BoxHelp index={i} key={i} />
                  ))}
                </Stack>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

// I wish I had media queries
const BoxHelp = (props: { index: number }) => {
  const { index } = props;

  return (
    <Stack.Item grow>
      <Section
        color="label"
        fill
        minHeight={10}
        title={
          <Stack align="center">
            <Icon
              color={boxHelp[index].color}
              mr={1}
              name={boxHelp[index].icon}
            />
            <Box>{boxHelp[index].title}</Box>
          </Stack>
        }
      >
        {boxHelp[index].text}
      </Section>
    </Stack.Item>
  );
};
