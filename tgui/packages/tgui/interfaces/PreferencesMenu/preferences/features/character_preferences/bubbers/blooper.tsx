import { useBackend } from 'tgui/backend';
import { Button, Stack } from 'tgui-core/components';
import {
  type FeatureChoiced,
  type FeatureChoicedServerData,
  type FeatureNumeric,
  FeatureSliderInput,
  type FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

const FeatureBlooperDropdownInput = (
  props: FeatureValueProps<string, string, FeatureChoicedServerData>,
) => {
  const { act } = useBackend();

  return (
    <Stack>
      <Stack.Item grow>
        <FeatureDropdownInput {...props} />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => {
            act('play_blooper');
          }}
          icon="play"
          width="100%"
          height="100%"
        />
      </Stack.Item>
    </Stack>
  );
};

export const blooper_choice: FeatureChoiced = {
  name: 'Voz do Caracter',
  component: FeatureBlooperDropdownInput,
};

export const blooper_speed: FeatureNumeric = {
  name: 'Velocidade de Voz do Caracter',
  description: 'Número menor, voz mais lenta. Número maior, voz mais rápida.',
  component: FeatureSliderInput,
};

export const blooper_pitch: FeatureNumeric = {
  name: 'Personagem Voz Pitch',
  description: 'Menos número, mais fundo. Mais alto, mais alto.',
  component: FeatureSliderInput,
};

export const blooper_pitch_range: FeatureNumeric = {
  name: 'Faixa de Voz de Caracteres %',
  description:
    'Menos número, menos alcance de arremesso. Maior número, mais alcance de lançamento.',
  component: FeatureSliderInput,
};
