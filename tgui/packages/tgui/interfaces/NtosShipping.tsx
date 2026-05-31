import { Box, Button, LabeledList, Section } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

type Data = {
  current_user: string;
  card_owner: string;
  paperamt: number;
  barcode_split: number;
  has_id_slot: BooleanLike;
};

export const NtosShipping = (props) => {
  return (
    <NtosWindow width={450} height={350}>
      <NtosWindow.Content scrollable>
        <ShippingHub />
        <ShippingOptions />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

/** Returns information about the current user, available paper, etc */
const ShippingHub = (props) => {
  const { act, data } = useBackend<Data>();
  const { current_user, card_owner, paperamt, barcode_split } = data;

  return (
    <Section
      title="Centro de Transporte da NTOS."
      buttons={
        <Button
          icon="eject"
          content="Ejetar Id"
          onClick={() => act('ejectid')}
        />
      }
    >
      <LabeledList>
        <LabeledList.Item label="Usuário atual">
          {current_user || 'N/A'}
        </LabeledList.Item>
        <LabeledList.Item label="Cartão Inserído">
          {card_owner || 'N/A'}
        </LabeledList.Item>
        <LabeledList.Item label="Papel disponível">{paperamt}</LabeledList.Item>
        <LabeledList.Item label="Lucro à venda">
          {barcode_split}%
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

/** Returns shipping options */
const ShippingOptions = (props) => {
  const { act, data } = useBackend<Data>();
  const { has_id_slot, current_user } = data;

  return (
    <Section title="Opções de envio">
      <Box>
        <Button
          icon="id-card"
          tooltip="O cartão de identificação atual será o usuário atual."
          tooltipPosition="right"
          disabled={!has_id_slot}
          onClick={() => act('selectid')}
          content="Definir ID atual"
        />
      </Box>
      <Box>
        <Button
          icon="print"
          tooltip="Imprima um código de barras para usar em um pacote embrulhado."
          tooltipPosition="right"
          disabled={!current_user}
          onClick={() => act('print')}
          content="Imprimir código de barras"
        />
      </Box>
      <Box>
        <Button
          icon="tags"
          tooltip="Defina quanto lucro você gostaria em seu pacote."
          tooltipPosition="right"
          onClick={() => act('setsplit')}
          content="Marcar Margem de Lucros"
        />
      </Box>
      <Box>
        <Button
          icon="sync-alt"
          content="Reiniciar ID"
          onClick={() => act('resetid')}
        />
      </Box>
    </Section>
  );
};
