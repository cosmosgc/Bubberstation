import { useBackend } from 'tgui/backend';
import { Box, Button, LabeledList, Section, Stack } from 'tgui-core/components';

import type { PaiData } from './types';

export function SystemDisplay(props) {
  return (
    <Stack fill vertical>
      <Stack.Item grow={3}>
        <SystemWallpaper />
      </Stack.Item>
      <Stack.Item grow>
        <SystemInfo />
      </Stack.Item>
    </Stack>
  );
}

/** Renders some ASCII art. Changes to red on emag. */
function SystemWallpaper(props) {
  const { data } = useBackend<PaiData>();
  const { emagged } = data;

  const owner = !emagged ? 'NANOTRASEN' : ' SYNDICATE';
  const eyebrows = !emagged ? "/\\ ' /\\" : ' \\\\ // ';

  const paiAscii = [
    ' ________  ________  ___',
    ' |\\   __  \\|\\   __  \\|\\  \\',
    ' \\ \\  \\|\\  \\ \\  \\|\\  \\ \\  \\Interface',
    '  \\ \\   ____\\ \\   __  \\ \\  \\Versão 2.5',
    '   \\ \\  \\___|\\ \\  \\ \\  \\ \\  \\',
    '    \\ \\__\\    \\ \\__\\ \\__\\ \\__\\Propriedade de',
    `     \\|__|     \\|__|\\|__|\\|__|      ${owner}`,
    '',
  ].join('\n');

  const floofAscii = [
    '                              .--.       .-.',
    "        ,;;``;;-;,,..___.,,.-/   `;_//,.'   )",
    "      .' ;;  `;  :; `;;  ;;  `.       '/   .'",
    `     ,;  ';   ;   '  ';  ';   ,'    ${eyebrows}';`, // lol
    "    /'     `      \\`;',' (\\ b ),",
    "   /   /       .,;;)       ', (    .'     __\\",
    "  ;:.  \\     ,_   /         ', ' .'_      \\/;",
    " ,   ,;'      `;;/       /    ';,\\ `-..__._,'",
    " ;:.  /____  ..-'--.    /-'    ..---. ._._/ ---.",
    " |    ;' ;'|        \\--/;' ,' /      \\   ,      \\",
    "{\cH00FFFF\fs40\i0} {\cH00FFFF\i0} {\cH00FFFF\i0} {\cH00FFFF\i0} {\cH00FFFF\i0\i0} {\cH00FFFF\i0} {\cH00FFFFFF\i0\i0} {\cH00FFFF\i0} {\cH00FFFF\i\i0}} {\cH00FFFF\i\i0cH00FFFF\i\i0} {\cH00FFFFFF\i\i\i} {\cH00FFFFFF\i\i}}} {\i0} {\cH00FFFF\i\i\i\i\i\i\i\i\i\i0}} {\i0cH00FFFF\i\i\i\i\i0cH00FFFFFFFFFFFFFFFF\i\i\i\i\i\i\i\i\i\i\i\i\\.._)_)/",
  ].join('\n');

  return (
    <Section fill nowrap overflow="hidden">
      <pre>
        <Box color={!emagged ? 'blue' : 'crimson'}>{paiAscii}</Box>
        <Box color={!emagged ? 'gold' : 'limegreen'}>{floofAscii}</Box>
      </pre>
    </Section>
  );
}

/** Displays master info.
 * You can check their DNA and change your image here.
 */
function SystemInfo(props) {
  const { act, data } = useBackend<PaiData>();
  const { screen_image_interface_icon, master_dna, master_name } = data;

  return (
    <Section
      buttons={
        <>
          <Button
            disabled={!master_dna}
            icon="dna"
            onClick={() => act('Verifique o DNA.')}
            tooltip="Verifica o DNA do seu mestre. Deve ser carregado na mão."
          >
            Verify
          </Button>
          <Button
            icon={screen_image_interface_icon}
            onClick={() => act('mudar a imagem')}
            tooltip="Mude sua imagem de exibição."
          >
            Display
          </Button>
          {/** BUBBER EDIT: pAI self Wipe */}
          <Button
            icon="skull"
            color="bad"
            onClick={() => act('Limpar arquivos')}
          >
            WIPE
          </Button>
          {/** BUBBER EDIT END: pAI self wipe */}
        </>
      }
      fill
      title="Informação do Sistema"
    >
      <LabeledList>
        <LabeledList.Item label="Master">
          {master_name || 'None.'}
        </LabeledList.Item>
        <LabeledList.Item color={master_dna ? 'red' : ''} label="DNA">
          {master_dna || 'None.'}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
}
