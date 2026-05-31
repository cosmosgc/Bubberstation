// THIS IS A SKYRAT UI FILE
import {
  BlockQuote,
  Box,
  Button,
  Collapsible,
  Divider,
  Flex,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const Soulcatcher = (props) => {
  const { act, data } = useBackend();
  const {
    require_approval,
    current_rooms = [],
    ghost_joinable,
    current_mob_count,
    max_mobs,
    removable,
    communicate_as_parent,
    theme,
    carrier_targeted,
  } = data;

  return (
    <Window width={520} height={400} theme={theme} resizable>
      <Window.Content scrollable>
        {current_rooms.map((room) => (
          <Section
            key={room.key}
            title={<span style={{ color: room.color }}>{room.name}</span>}
            buttons={
              <>
                <Button
                  icon="palette"
                  tooltip="Mude a cor do quarto"
                  onClick={() =>
                    act('change_room_color', { room_ref: room.reference })
                  }
                >
                  Recolor
                </Button>
                <Button
                  icon="pen"
                  tooltip="Mude o nome da sala."
                  onClick={() =>
                    act('rename_room', { room_ref: room.reference })
                  }
                >
                  Rename
                </Button>
                <Button
                  icon="trash"
                  tooltip="Apague o quarto."
                  color="red"
                  onClick={() =>
                    act('delete_room', { room_ref: room.reference })
                  }
                >
                  Delete
                </Button>
              </>
            }
          >
            <BlockQuote preserveWhitespace> {room.description}</BlockQuote>
            <Box>
              <Button
                icon="scroll"
                tooltip="Realiza um emote, sem enviar um nome."
                onClick={() =>
                  act('send_message', {
                    room_ref: room.reference,
                    emote: true,
                    narration: true,
                  })
                }
              >
                Narrate
              </Button>

              <Button
                icon="comment"
                tooltip="Fale dentro da sala."
                onClick={() =>
                  act('send_message', {
                    room_ref: room.reference,
                    emote: false,
                  })
                }
              >
                Say
              </Button>

              <Button
                icon="face-smile"
                tooltip="Faça um emote dentro da sala."
                onClick={() =>
                  act('send_message', {
                    room_ref: room.reference,
                    emote: true,
                  })
                }
              >
                Emote
              </Button>

              <Button
                icon="user-gear"
                tooltip="Edita o nome que é enviado quando emociona e diz."
                onClick={() =>
                  act('modify_name', {
                    room_ref: room.reference,
                  })
                }
              >
                Edit Name
              </Button>
              <Button
                icon="book"
                tooltip="Muda a descrição da sala."
                onClick={() =>
                  act('redescribe_room', { room_ref: room.reference })
                }
              >
                Redecorate
              </Button>
              <Button
                icon="image"
                tooltip="Muda a sobreposição atual da sala"
                onClick={() =>
                  act('change_overlay', { room_ref: room.reference })
                }
              >
                {room.overlay_name ? room.overlay_name : 'Mude de Overlay'}
              </Button>
              {room.overlay_name && (
                <>
                  <Button
                    icon="eye"
                    tooltip="Visualiza a sobreposição da sala atual."
                    onClick={() =>
                      act('preview_overlay', { room_ref: room.reference })
                    }
                  >
                    Preview Room
                  </Button>
                  {room.overlay_recolorable && (
                    <Button
                      icon="eye-dropper"
                      tooltip="Muda a cor da sobreposição da sala atual."
                      onClick={() =>
                        act('change_overlay_color', {
                          room_ref: room.reference,
                        })
                      }
                    >
                      Modify Color
                    </Button>
                  )}
                </>
              )}

              <Button
                color={room.joinable ? 'green' : 'red'}
                icon={room.joinable ? 'door-open' : 'door-closed'}
                onClick={() =>
                  act('toggle_joinable_room', { room_ref: room.reference })
                }
              >
                {room.joinable ? 'Quarto junta-se' : 'Quarto inigualável'}
              </Button>
              <Button
                icon={room.currently_targeted ? 'check' : 'xmark'}
                tooltip="Escolha onde as mensagens que usam os verbos são enviadas."
                color={room.currently_targeted ? 'green' : 'red'}
                onClick={() =>
                  act('change_targeted_room', { room_ref: room.reference })
                }
              >
                {room.currently_targeted ? 'Targeted' : 'Untargeted'}
              </Button>
            </Box>
            {room.souls && (
              <>
                <br />
                <Box textAlign="center" fontSize="15px" opacity={0.8}>
                  <b>Current Souls</b>
                </Box>
                <Divider />
                <Flex direction="column">
                  {room.souls.map((mob) => (
                    <Flex.Item key={mob.key}>
                      <Collapsible
                        title={mob.name}
                        buttons={
                          <>
                            {!mob.scan_needed && (
                              <>
                                <Button
                                  color="green"
                                  icon="pen"
                                  tooltip="Mude o nome da máfia."
                                  onClick={() =>
                                    act('change_name', {
                                      target_mob: mob.reference,
                                      room_ref: room.reference,
                                    })
                                  }
                                />
                                <Button
                                  color="red"
                                  icon="arrow-rotate-left"
                                  tooltip="Reinicie o nome da máfia."
                                  onClick={() =>
                                    act('reset_name', {
                                      target_mob: mob.reference,
                                      room_ref: room.reference,
                                    })
                                  }
                                />
                              </>
                            )}
                            <Button
                              icon="paper-plane"
                              tooltip="Transfira uma multidão para outro quarto."
                              onClick={() =>
                                act('transfer_mob', {
                                  room_ref: room.reference,
                                  target_mob: mob.reference,
                                })
                              }
                            />
                          </>
                        }
                      >
                        <Box textAlign="center" fontSize="13px" opacity={0.8}>
                          <b>Flavor Text</b>
                        </Box>
                        <Divider />
                        <BlockQuote preserveWhitespace>
                          {mob.description}
                        </BlockQuote>
                        <br />
                        <Box textAlign="center" fontSize="13px" opacity={0.8}>
                          <b>OOC Notes</b>
                        </Box>
                        <Divider />
                        <BlockQuote preserveWhitespace>
                          {mob.ooc_notes}
                        </BlockQuote>
                        <br />
                        <LabeledList>
                          <LabeledList.Item label="Lá fora Audição">
                            <Button
                              color={mob.outside_hearing ? 'green' : 'red'}
                              fluid
                              tooltip="A multidão é capaz de ouvir o mundo exterior?"
                              onClick={() =>
                                act('toggle_soul_sense', {
                                  target_mob: mob.reference,
                                  sense_to_change: 'external_hearing',
                                  room_ref: room.reference,
                                })
                              }
                            >
                              {mob.outside_hearing ? 'Enabled' : 'Disabled'}
                            </Button>
                          </LabeledList.Item>
                          <LabeledList.Item label="Visão Fora">
                            <Button
                              color={mob.outside_sight ? 'green' : 'red'}
                              fluid
                              tooltip="A máfia é capaz de ver o mundo exterior?"
                              onClick={() =>
                                act('toggle_soul_sense', {
                                  target_mob: mob.reference,
                                  sense_to_change: 'external_sight',
                                  room_ref: room.reference,
                                })
                              }
                            >
                              {mob.outside_sight ? 'Enabled' : 'Disabled'}
                            </Button>
                          </LabeledList.Item>
                          <LabeledList.Item label="Hearing">
                            <Button
                              color={mob.internal_hearing ? 'green' : 'red'}
                              fluid
                              tooltip="A multidão pode ouvir dentro da sala?"
                              onClick={() =>
                                act('toggle_soul_sense', {
                                  target_mob: mob.reference,
                                  sense_to_change: 'hearing',
                                  room_ref: room.reference,
                                })
                              }
                            >
                              {mob.internal_hearing ? 'Enabled' : 'Disabled'}
                            </Button>
                          </LabeledList.Item>
                          <LabeledList.Item label="Sight">
                            <Button
                              color={mob.internal_sight ? 'green' : 'red'}
                              fluid
                              tooltip="A máfia consegue ver dentro do quarto?"
                              onClick={() =>
                                act('toggle_soul_sense', {
                                  target_mob: mob.reference,
                                  sense_to_change: 'sight',
                                  room_ref: room.reference,
                                })
                              }
                            >
                              {mob.internal_sight ? 'Enabled' : 'Disabled'}
                            </Button>
                          </LabeledList.Item>
                          <LabeledList.Item label="Speech">
                            <Button
                              color={mob.able_to_speak ? 'green' : 'red'}
                              fluid
                              tooltip="A máfia é capaz de falar?"
                              onClick={() =>
                                act('toggle_soul_sense', {
                                  target_mob: mob.reference,
                                  sense_to_change: 'able_to_speak',
                                  room_ref: room.reference,
                                })
                              }
                            >
                              {mob.able_to_speak ? 'Enabled' : 'Disabled'}
                            </Button>
                          </LabeledList.Item>
                          <LabeledList.Item label="Emote">
                            <Button
                              color={mob.able_to_emote ? 'green' : 'red'}
                              fluid
                              tooltip="A máfia é capaz de emocionar?"
                              onClick={() =>
                                act('toggle_soul_sense', {
                                  target_mob: mob.reference,
                                  sense_to_change: 'able_to_emote',
                                  room_ref: room.reference,
                                })
                              }
                            >
                              {mob.able_to_emote ? 'Enabled' : 'Disabled'}
                            </Button>
                          </LabeledList.Item>
                          {communicate_as_parent && (
                            <>
                              <LabeledList.Item label="Discurso Externo">
                                <Button
                                  color={
                                    mob.able_to_speak_as_container
                                      ? 'green'
                                      : 'red'
                                  }
                                  fluid
                                  tooltip="A multidão é capaz de falar o contêiner?"
                                  onClick={() =>
                                    act('toggle_soul_sense', {
                                      target_mob: mob.reference,
                                      sense_to_change:
                                        'able_to_speak_as_container',
                                      room_ref: room.reference,
                                    })
                                  }
                                >
                                  {mob.able_to_speak_as_container
                                    ? 'Enabled'
                                    : 'Disabled'}
                                </Button>
                              </LabeledList.Item>
                              <LabeledList.Item label="Emote Externo">
                                <Button
                                  color={
                                    mob.able_to_emote_as_container
                                      ? 'green'
                                      : 'red'
                                  }
                                  fluid
                                  tooltip="A máfia é capaz de emocionar como o contêiner?"
                                  onClick={() =>
                                    act('toggle_soul_sense', {
                                      target_mob: mob.reference,
                                      sense_to_change:
                                        'able_to_emote_as_container',
                                      room_ref: room.reference,
                                    })
                                  }
                                >
                                  {mob.able_to_emote_as_container
                                    ? 'Enabled'
                                    : 'Disabled'}
                                </Button>
                              </LabeledList.Item>
                            </>
                          )}
                          <LabeledList.Item label="Rename">
                            <Button
                              color={mob.able_to_rename ? 'green' : 'red'}
                              fluid
                              tooltip="A máfia é capaz de se renomear?"
                              onClick={() =>
                                act('toggle_soul_sense', {
                                  target_mob: mob.reference,
                                  sense_to_change: 'able_to_rename',
                                  room_ref: room.reference,
                                })
                              }
                            >
                              {mob.able_to_rename ? 'Enabled' : 'Disabled'}
                            </Button>
                          </LabeledList.Item>
                        </LabeledList>
                        <br />
                        <Button
                          fluid
                          icon="eject"
                          color="red"
                          onClick={() =>
                            act('remove_mob', {
                              target_mob: mob.reference,
                              room_ref: room.reference,
                            })
                          }
                        >
                          Remove Soul
                        </Button>
                      </Collapsible>
                    </Flex.Item>
                  ))}
                </Flex>
              </>
            )}
          </Section>
        ))}
        {max_mobs && (
          <Section>
            <ProgressBar
              textAlign="left"
              minValue={0}
              color="blue"
              maxValue={max_mobs}
              value={max_mobs - current_mob_count}
            >
              Remaining mob capacity: {max_mobs - current_mob_count}
            </ProgressBar>
          </Section>
        )}
        <Button
          fluid
          color="green"
          icon="plus"
          onClick={() => act('create_room', {})}
        >
          Create new room
        </Button>
        <Button
          fluid
          color={ghost_joinable ? 'green' : 'red'}
          icon={ghost_joinable ? 'door-open' : 'door-closed'}
          onClick={() => act('toggle_joinable', {})}
        >
          {ghost_joinable ? 'Opened' : 'Closed'} to ghosts
        </Button>
        <Button
          fluid
          color={require_approval ? 'green' : 'red'}
          icon={require_approval ? 'lock' : 'lock-open'}
          onClick={() => act('toggle_approval', {})}
        >
          Approval is {require_approval ? '' : 'not'} required to join
        </Button>
        <Button
          fluid
          color={carrier_targeted ? 'green' : 'red'}
          icon={carrier_targeted ? 'check' : 'xmark'}
          onClick={() => act('change_targeted_carrier', {})}
        >
          Verb messages are {require_approval ? '' : 'not'} sent to this carrier
        </Button>
        {removable && (
          <Button
            require_approval
            fluid
            color="red"
            icon="eject"
            onClick={() => act('delete_self', {})}
          >
            Remove soulcatcher from parent object
          </Button>
        )}
      </Window.Content>
    </Window>
  );
};
