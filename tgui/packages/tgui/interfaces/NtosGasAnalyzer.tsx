import { Button } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import { GasAnalyzerContent, type GasAnalyzerData } from './GasAnalyzer';

type NtosGasAnalyzerData = GasAnalyzerData & {
  atmozphereMode: 'click' | 'env';
  clickAtmozphereCompatible: BooleanLike;
};

export const NtosGasAnalyzer = (props) => {
  const { act, data } = useBackend<NtosGasAnalyzerData>();
  const { atmozphereMode, clickAtmozphereCompatible } = data;
  return (
    <NtosWindow width={500} height={450}>
      <NtosWindow.Content scrollable>
        {!!clickAtmozphereCompatible && (
          <Button
            icon={'sync'}
            onClick={() => act('scantoggle')}
            fluid
            textAlign="center"
            tooltip={
              atmozphereMode === 'click'
                ? 'Clique com o botão direito nos objetos enquanto segura o tablet para digitalizá-los. Clique com o botão direito do tablet para verificar a localização atual.'
                : 'O aplicativo atualizará sua leitura automática da mistura de gás.'
            }
            tooltipPosition="bottom"
          >
            {atmozphereMode === 'click'
              ? 'Escaneando objetos grampeados. Clique para trocar.'
              : 'Escaneando a localização atual. Clique para trocar.'}
          </Button>
        )}
        <GasAnalyzerContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};
