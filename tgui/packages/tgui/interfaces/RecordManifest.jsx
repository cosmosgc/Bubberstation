// THIS IS A SKYRAT UI FILE
import { Button, Icon, Section, Table, Tooltip } from 'tgui-core/components';
import { classes } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const commandJobs = [
  'Chefe de Pessoal',
  'Chefe de Segurança',
  'Engenheiro Chefe.',
  'Diretor de Pesquisa',
  'Oficial Médico Chefe.',
  'Quartermaster',
  'Consultor Nanotrasen',
];

export const RecordManifest = (props) => {
  const {
    data: { manifest, positions },
  } = useBackend();
  const { act } = useBackend();

  return (
    <Window title="Toda a tripulação com informações" width={450} height={500}>
      <Window.Content scrollable>
        {Object.entries(manifest).map(([dept, crew]) => (
          <Section className={`CrewManifest--${dept}`} key={dept} title={dept}>
            <Table>
              {Object.entries(crew).map(([crewIndex, crewMember]) => (
                <Table.Row key={crewIndex}>
                  <Table.Cell className={'CrewManifest__Cell'}>
                    {crewMember.name}
                  </Table.Cell>
                  <Table.Cell>
                    <Button
                      content="Mostre exploráveis."
                      onClick={() =>
                        act('show_exploitables', {
                          exploitable_id: crewMember.name,
                        })
                      }
                    />
                  </Table.Cell>
                  <Table.Cell
                    className={classes([
                      'CrewManifest__Cell',
                      'CrewManifest__Icons',
                    ])}
                    collapsing
                  >
                    {positions[dept].exceptions.includes(crewMember.rank) && (
                      <Tooltip content="Sem limite de posição." position="bottom">
                        <Icon className="CrewManifest__Icon" name="infinity" />
                      </Tooltip>
                    )}
                    {crewMember.rank === 'Captain' && (
                      <Tooltip content="Captain" position="bottom">
                        <Icon
                          className={classes([
                            'CrewManifest__Icon',
                            'CrewManifest__Icon--Command',
                          ])}
                          name="star"
                        />
                      </Tooltip>
                    )}
                    {commandJobs.includes(crewMember.rank) && (
                      <Tooltip content="Membro do comando." position="bottom">
                        <Icon
                          className={classes([
                            'CrewManifest__Icon',
                            'CrewManifest__Icon--Command',
                            'CrewManifest__Icon--Chevron',
                          ])}
                          name="chevron-up"
                        />
                      </Tooltip>
                    )}
                  </Table.Cell>
                  <Table.Cell
                    className={classes([
                      'CrewManifest__Cell',
                      'CrewManifest__Cell--Rank',
                    ])}
                    collapsing
                  >
                    {crewMember.rank}
                  </Table.Cell>
                </Table.Row>
              ))}
            </Table>
          </Section>
        ))}
      </Window.Content>
    </Window>
  );
};
