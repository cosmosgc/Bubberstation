import {
  Box,
  Button,
  Dimmer,
  Icon,
  Image,
  Section,
  Stack,
} from 'tgui-core/components';
import { decodeHtmlEntities } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const Trophycase = (props) => {
  const { act, data } = useBackend();
  return (
    <Window width={300} height={380}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <ShowpieceName />
          </Stack.Item>
          <Stack.Item>
            <ShowpieceImage />
          </Stack.Item>
          <Stack.Item grow>
            <ShowpieceDescription />
          </Stack.Item>
          <Stack.Divider />
          <Stack.Item>
            <HistorianPanel />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const HistorianPanel = (props) => {
  const { act, data } = useBackend();
  const {
    has_showpiece,
    historian_mode,
    holographic_showpiece,
    showpiece_description,
  } = data;

  return (
    <Section align="left">
      {!historian_mode && (
        <Button
          icon="key"
          content="Inserir Chave para o modo histórico"
          onClick={() => act('insert_key')}
        />
      )}
      {!!historian_mode && (
        <div>
          <Button
            icon="times"
            content="Bloquear o modo histórico"
            onClick={() => act('lock')}
          />
          <Button
            icon="pencil"
            content="Editar descrição"
            disabled={!has_showpiece || holographic_showpiece}
            onClick={() => act('change_message')}
          />
        </div>
      )}
      {!!historian_mode && !!holographic_showpiece && (
        <Box>
          A holographic trophy is already present. Replace it with a new trophy
          to create a new recording.
        </Box>
      )}
      {!!historian_mode && !has_showpiece && <Box>No trophies located.</Box>}
      {!!historian_mode &&
        !!has_showpiece &&
        !holographic_showpiece &&
        !!showpiece_description && (
          <Box>
            Recording has begun. Trophy data will be saved overnight, as long as
            the trophy stays within an intact case.
          </Box>
        )}
      {!!historian_mode &&
        !!has_showpiece &&
        !holographic_showpiece &&
        !showpiece_description && (
          <Box>
            New trophy detected. Please record a description to begin archival.
          </Box>
        )}
    </Section>
  );
};

const ShowpieceDescription = (props) => {
  const { act, data } = useBackend();
  const {
    has_showpiece,
    holographic_showpiece,
    historian_mode,
    max_length,
    showpiece_description,
  } = data;
  return (
    <Section fill align="center">
      {!has_showpiece && (
        <Box fill className="Trophycase-description">
          <b>This exhibit is empty. History awaits your contribution!</b>
        </Box>
      )}
      {!!holographic_showpiece && <b>{showpiece_description}</b>}
      {!holographic_showpiece && !!has_showpiece && (
        <Box fill className="Trophycase-description">
          {showpiece_description
            ? decodeHtmlEntities(showpiece_description)
            : "Esta exposição está em construção. Consiga a chave do curador para finalizar sua contribuição!"}
        </Box>
      )}
    </Section>
  );
};

const ShowpieceImage = (props) => {
  const { data } = useBackend();
  const { showpiece_icon } = data;
  return showpiece_icon ? (
    <Section align="center">
      <Image
        m={1}
        src={`data:image/jpeg;base64,${showpiece_icon}`}
        height="96px"
        width="96px"
      />
    </Section>
  ) : (
    <Section align="center">
      <Box height="96px" width="96px">
        <Dimmer fontSize="32px">
          <Icon name="landmark" />
        </Dimmer>
      </Box>
    </Section>
  );
};

const ShowpieceName = (props) => {
  const { data } = useBackend();
  const { showpiece_name } = data;
  return (
    <Section align="center">
      <b>
        {showpiece_name
          ? decodeHtmlEntities(showpiece_name)
          : 'Em construção.'}
      </b>
    </Section>
  );
};
