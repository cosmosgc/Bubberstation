import { Button, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const OutfitManager = (props) => {
  const { act, data } = useBackend();
  const { outfits } = data;
  return (
    <Window title="Gerente de roupas." width={300} height={300} theme="admin">
      <Window.Content>
        <Section
          fill
          scrollable
          title="Gerente de roupas personalizadas"
          buttons={
            <>
              <Button
                icon="file-upload"
                tooltip="Carregue uma roupa de um arquivo."
                tooltipPosition="left"
                onClick={() => act('load')}
              />
              <Button
                icon="copy"
                tooltip="Copie uma roupa já existente."
                tooltipPosition="left"
                onClick={() => act('copy')}
              />
              <Button
                icon="plus"
                tooltip="Crie uma nova roupa."
                tooltipPosition="left"
                onClick={() => act('new')}
              />
            </>
          }
        >
          <Stack vertical>
            {outfits?.map((outfit) => (
              <Stack.Item key={outfit.ref}>
                <Stack>
                  <Stack.Item
                    grow={1}
                    shrink={1}
                    style={{
                      overflow: 'hidden',
                      whiteSpace: 'nowrap',
                      textOverflow: 'ellipsis',
                    }}
                  >
                    <Button
                      fluid
                      style={{
                        overflow: 'hidden',
                        whiteSpace: 'nowrap',
                        textOverflow: 'ellipsis',
                      }}
                      content={outfit.name}
                      onClick={() => act('edit', { outfit: outfit.ref })}
                    />
                  </Stack.Item>
                  <Stack.Item ml={0.5}>
                    <Button
                      icon="save"
                      tooltip="Guarde esta roupa para um arquivo."
                      tooltipPosition="left"
                      onClick={() => act('save', { outfit: outfit.ref })}
                    />
                  </Stack.Item>
                  <Stack.Item ml={0.5}>
                    <Button
                      color="bad"
                      icon="trash-alt"
                      tooltip="Apague essa roupa."
                      tooltipPosition="left"
                      onClick={() => act('delete', { outfit: outfit.ref })}
                    />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            ))}
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
