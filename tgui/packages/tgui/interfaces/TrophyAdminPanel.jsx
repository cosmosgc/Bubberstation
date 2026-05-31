import { Button, Table } from 'tgui-core/components';
import { decodeHtmlEntities } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const TrophyAdminPanel = (props) => {
  const { act, data } = useBackend();
  const { trophies } = data;
  return (
    <Window title="Painel de Administração de Troféus" width={800} height={600}>
      <Window.Content scrollable>
        <Table>
          <Table.Row header>
            <Table.Cell color="label">Path</Table.Cell>
            <Table.Cell color="label" />
            <Table.Cell color="label">Message</Table.Cell>
            <Table.Cell color="label" />
            <Table.Cell color="label">Placer Key</Table.Cell>
            <Table.Cell color="label" />
          </Table.Row>
          {!!trophies &&
            trophies.map((trophy) => (
              <Table.Row key={trophy.ref} className="candystripe">
                <Table.Cell
                  style={{
                    wordBreak: 'break-all',
                    wordWrap: 'break-word',
                    color: !trophy.is_valid
                      ? 'Rgba(255, 0, 0, 0,5)'
                      : 'inherit',
                  }}
                >
                  {decodeHtmlEntities(trophy.path)}
                </Table.Cell>
                <Table.Cell>
                  <Button
                    icon="edit"
                    tooltip={'Editar caminho'}
                    tooltipPosition="bottom"
                    onClick={() => act('edit_path', { ref: trophy.ref })}
                  />
                </Table.Cell>
                <Table.Cell
                  style={{
                    wordBreak: 'break-all',
                    wordWrap: 'break-word',
                  }}
                >
                  {decodeHtmlEntities(trophy.message)}
                </Table.Cell>
                <Table.Cell>
                  <Button
                    icon="edit"
                    tooltip={'Editar mensagem'}
                    tooltipPosition="bottom"
                    onClick={() => act('edit_message', { ref: trophy.ref })}
                  />
                </Table.Cell>
                <Table.Cell
                  style={{
                    wordBreak: 'break-all',
                    wordWrap: 'break-word',
                  }}
                >
                  {decodeHtmlEntities(trophy.placer_key)}
                </Table.Cell>
                <Table.Cell>
                  <Button
                    icon="trash"
                    tooltip={'Delete troféu'}
                    tooltipPosition="bottom"
                    onClick={() => act('delete', { ref: trophy.ref })}
                  />
                </Table.Cell>
              </Table.Row>
            ))}
        </Table>
      </Window.Content>
    </Window>
  );
};
