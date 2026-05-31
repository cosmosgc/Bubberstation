// THIS IS A SKYRAT UI FILE
import {
  Button,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const EventPanel = (props) => {
  const { act, data } = useBackend();
  const {
    event_list = [],
    end_time,
    vote_in_progress,
    previous_events,
    admin_mode,
    show_votes,
    next_vote_time,
    next_low_chaos_time,
  } = data;
  return (
    <Window title={'Painel de Eventos'} width={500} height={900} theme={'admin'}>
      <Window.Content>
        <Stack vertical fill>
          {!!admin_mode && (
            <Stack.Item>
              <Section title={'Controle de eventos'}>
                <NoticeBox color="blue">
                  {`Next vote in ${toFixed(next_vote_time, 0)} seconds.`}
                </NoticeBox>
                <NoticeBox color="blue">
                  {`Low chaos event in ${toFixed(next_low_chaos_time, 0)} seconds.`}
                </NoticeBox>
                <Button
                  icon="plus"
                  content="Comece o voto de administrador."
                  tooltip="Comece a votar no próximo evento."
                  disabled={vote_in_progress}
                  onClick={() => act('start_vote_admin')}
                />
                <Button
                  icon="plus"
                  content="Iniciar Chaos de Administração Voto"
                  tooltip="Iniciar um voto de caos para o próximo evento."
                  disabled={vote_in_progress}
                  onClick={() => act('start_vote_admin_chaos')}
                />
                <Button
                  icon="user-plus"
                  content="Comece o Voto do Jogador."
                  tooltip="Isso vai começar uma votação que será publicamente visível."
                  color="average"
                  disabled={vote_in_progress}
                  onClick={() => act('start_player_vote')}
                />
                <Button
                  icon="user-plus"
                  content="Começar o Chaos Público Voto"
                  tooltip="Isso vai começar uma votação que será publicamente visível."
                  color="average"
                  disabled={vote_in_progress}
                  onClick={() => act('start_player_vote_chaos')}
                />
                <Button
                  icon="stopwatch"
                  content="Fim do Voto"
                  tooltip="Termine a votação atual e execute o evento vencedor."
                  disabled={!vote_in_progress}
                  onClick={() => act('end_vote')}
                />
                <Button
                  icon="ban"
                  content="Cancelar votação"
                  tooltip="Cancele a votação atual e reinicie o sistema de votação."
                  disabled={!vote_in_progress}
                  onClick={() => act('cancel_vote')}
                />
                <Button
                  icon="clock"
                  content="Próximo voto."
                  tooltip="Recedule a próxima votação."
                  onClick={() => act('reschedule')}
                />
                <Button
                  icon="clock"
                  content="Próximo Evento do Baixo Caos"
                  tooltip="Recedule o próximo evento do Low Chaos."
                  onClick={() => act('reschedule_low_chaos')}
                />
              </Section>
            </Stack.Item>
          )}
          <Stack.Item grow>
            <Section
              scrollable
              fill
              grow
              title={
                vote_in_progress
                  ? `Available Events (${toFixed(end_time)} seconds) `
                  : 'Eventos disponíveis'
              }
            >
              {vote_in_progress ? (
                <LabeledList>
                  {event_list.map((event) => (
                    <LabeledList.Item
                      label={event.name}
                      key={event.name}
                      buttons={
                        <Button
                          color={event.self_vote ? 'good' : 'blue'}
                          icon="vote-yea"
                          content="Vote"
                          onClick={() =>
                            act('register_vote', {
                              event_ref: event.ref,
                            })
                          }
                        />
                      }
                    >
                      {!!show_votes || (!!admin_mode && event.votes)}
                    </LabeledList.Item>
                  ))}
                </LabeledList>
              ) : (
                <NoticeBox>No vote in progress.</NoticeBox>
              )}
            </Section>
          </Stack.Item>
          {!!admin_mode && (
            <Stack.Item>
              <Section
                scrollable
                grow
                fill
                height="150px"
                title="Eventos anteriores"
              >
                {previous_events.length > 0 ? (
                  <LabeledList>
                    {previous_events.map((event) => (
                      <LabeledList.Item label="Event" key={event}>
                        {event}
                      </LabeledList.Item>
                    ))}
                  </LabeledList>
                ) : (
                  <NoticeBox>No previous events.</NoticeBox>
                )}
              </Section>
            </Stack.Item>
          )}
        </Stack>
      </Window.Content>
    </Window>
  );
};
