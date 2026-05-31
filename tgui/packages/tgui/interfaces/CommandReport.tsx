import { useState } from 'react';
import {
  Button,
  Dropdown,
  Input,
  Section,
  Stack,
  TextArea,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  announce_contents: string;
  announcement_color: string;
  announcement_colors: string[];
  announcer_sounds: string[];
  command_name_presets: string[];
  command_name: string;
  command_report_content: string;
  custom_name: string;
  played_sound: string;
  print_report: string;
  subheader: string;
};

export function CommandReport() {
  return (
    <Window
      title="Criar relatório de comando"
      width={325}
      height={685}
      theme="admin"
    >
      <Window.Content>
        <Stack fill vertical>
          <Stack.Item>
            <CentComName />
            <AnnouncementColor />
            <AnnouncementSound />
          </Stack.Item>
          <Stack.Item>
            <SubHeader />
          </Stack.Item>
          <Stack.Item grow>
            <ReportText />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
}

/** Allows the user to set the "sender" of the message via dropdown */
function CentComName(props) {
  const { act, data } = useBackend<Data>();
  const { command_name, command_name_presets = [], custom_name } = data;

  const [name, setName] = useState(command_name);

  function sendName(value) {
    setName(value);
    act('update_command_name', {
      updated_name: value,
    });
  }

  return (
    <Section title="Defina o nome do Comando Central." textAlign="center">
      <Dropdown
        width="100%"
        selected={name}
        options={command_name_presets}
        onSelected={sendName}
      />
      {!!custom_name && (
        <Input fluid mt={1} value={name} onChange={setName} onBlur={sendName} />
      )}
    </Section>
  );
}

/** Allows the user to set the "sender" of the message via dropdown */
function SubHeader(props) {
  const { act, data } = useBackend<Data>();
  const { subheader } = data;

  return (
    <Section title="Preparar relatório de subcabeçamento" textAlign="center">
      <Input
        fluid
        mt={1}
        value={subheader}
        placeholder="Mantenha em branco para não incluir um subheader"
        onBlur={(value) =>
          act('set_subheader', {
            new_subheader: value,
          })
        }
      />
    </Section>
  );
}

/** Features a section with dropdown for the announcement colour. */
function AnnouncementColor(props) {
  const { act, data } = useBackend<Data>();
  const { announcement_colors = [], announcement_color } = data;

  return (
    <Section title="Definir a cor do anúncio" textAlign="center">
      <Dropdown
        width="100%"
        selected={announcement_color}
        options={announcement_colors}
        onSelected={(value) =>
          act('update_announcement_color', {
            updated_announcement_color: value,
          })
        }
      />
    </Section>
  );
}

/** Features a section with dropdown for sounds. */
function AnnouncementSound(props) {
  const { act, data } = useBackend<Data>();
  const { announcer_sounds = [], played_sound } = data;

  return (
    <Section title="Definir som de anúncio" textAlign="center">
      <Dropdown
        width="100%"
        selected={played_sound}
        options={announcer_sounds}
        onSelected={(value) =>
          act('set_report_sound', {
            picked_sound: value,
          })
        }
      />
    </Section>
  );
}

/** Creates the report textarea with a submit button. */
function ReportText(props) {
  const { act, data } = useBackend<Data>();
  const { announce_contents, print_report, command_report_content } = data;
  const [commandReport, setCommandReport] = useState(command_report_content);

  return (
    <Section fill title="Definir o texto do relatório" textAlign="center">
      <Stack fill vertical>
        <Stack.Item grow>
          <TextArea
            height="100%"
            fluid
            onBlur={setCommandReport}
            value={commandReport}
            placeholder="Digite o texto do relatório aqui..."
          />
        </Stack.Item>
        <Stack.Item>
          <Button.Checkbox
            fluid
            checked={!!announce_contents}
            onClick={() => act('toggle_announce')}
          >
            Announce Contents
          </Button.Checkbox>
        </Stack.Item>
        <Stack.Item>
          <Button.Checkbox
            fluid
            checked={!!print_report || !announce_contents}
            disabled={!announce_contents}
            onClick={() => act('toggle_printing')}
            tooltip={
              !announce_contents &&
              "Imprimindo o relatório é necessário, já que não anunciamos seu conteúdo."
            }
            tooltipPosition="top"
          >
            Print Report
          </Button.Checkbox>
        </Stack.Item>
        <Stack.Item>
          <Button.Confirm
            fluid
            icon="check"
            textAlign="center"
            onClick={() => act('submit_report', { report: commandReport })}
          >
            Submit Report
          </Button.Confirm>
        </Stack.Item>
      </Stack>
    </Section>
  );
}
