import { Button, NoticeBox, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { RequestPriority, type RequestsData } from './types';

export const RequestsConsoleHeader = (props) => {
  const { act, data } = useBackend<RequestsData>();
  const { has_mail_send_error, new_message_priority } = data;
  return (
    <Stack.Item mb={1}>
      {!!has_mail_send_error && <ErrorNoticeBox />}
      {!!new_message_priority && <MessageNoticeBox />}
      <EmergencyBox />
    </Stack.Item>
  );
};

const EmergencyBox = (props) => {
  const { act, data } = useBackend<RequestsData>();
  const { emergency } = data;
  return (
    <>
      {!!emergency && (
        <NoticeBox danger>
          {emergency} called! RETA may open doors in area to them.
        </NoticeBox>
      )}
      {!emergency && (
        <Stack fill>
          <Stack.Item grow>
            <Button
              fluid
              color="red"
              icon="shield"
              content="Chame a segurança."
              onClick={() =>
                act('set_emergency', {
                  emergency: 'Security',
                })
              }
            />
          </Stack.Item>
          <Stack.Item grow>
            <Button
              fluid
              color="red"
              icon="screwdriver-wrench"
              content="Chame a Engenharia."
              onClick={() =>
                act('set_emergency', {
                  emergency: 'Engineering',
                })
              }
            />
          </Stack.Item>
          <Stack.Item grow>
            <Button
              fluid
              color="red"
              icon="suitcase-medical"
              content="Chame o médico."
              onClick={() =>
                act('set_emergency', {
                  emergency: 'Medical',
                })
              }
            />
          </Stack.Item>
        </Stack>
      )}
    </>
  );
};

const ErrorNoticeBox = (props) => {
  return (
    <NoticeBox danger>{'Ocorreu um erro ao enviar uma mensagem!'}</NoticeBox>
  );
};

const MessageNoticeBox = (props) => {
  const { data } = useBackend<RequestsData>();
  const { new_message_priority } = data;
  return (
    <NoticeBox>
      {'Você tem novo não lido'}
      {new_message_priority === RequestPriority.HIGH && 'PRIORITY '}
      {new_message_priority === RequestPriority.EXTREME && 'PRIORIDADE EXTREMA'}
      {'messages'}
    </NoticeBox>
  );
};
