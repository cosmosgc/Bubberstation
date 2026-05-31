import { useState } from 'react';
import {
  Box,
  Button,
  Flex,
  Icon,
  LabeledList,
  Modal,
  NoticeBox,
  Section,
  Stack,
  Table,
  Tabs,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';
import { FakeTerminal } from './common/FakeTerminal';

const CONTRACT_STATUS_INACTIVE = 1;
const CONTRACT_STATUS_ACTIVE = 2;
const CONTRACT_STATUS_BOUNTY_CONSOLE_ACTIVE = 3;
const CONTRACT_STATUS_EXTRACTING = 4;
const CONTRACT_STATUS_COMPLETE = 5;
const CONTRACT_STATUS_ABORTED = 6;

export const SyndContractor = (props) => {
  return (
    <NtosWindow width={500} height={600} theme="syndicate">
      <NtosWindow.Content scrollable>
        <SyndContractorContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

export const SyndContractorContent = (props) => {
  const { data, act } = useBackend();

  const terminalMessages = [
    'Gravando dados biométricos...',
    'Analisando informações do sindicato...',
    'ESTATUTO CONFIRMADO',
    'Contatando o banco de dados do pecado...',
    'Esperando resposta...',
    'Esperando resposta...',
    'Esperando resposta...',
    'Esperando resposta...',
    'Esperando resposta...',
    'Esperando resposta...',
    'Resposta recebida, ack 4851234...',
    `CONFIRM ACC ${Math.round(Math.random() * 20000)}`,
    'Montando conta privadas...',
    'CONTA DE CONTRATOR CRIADA',
    'Procurando por contratos disponíveis...',
    'Procurando por contratos disponíveis...',
    'Procurando por contratos disponíveis...',
    'Procurando por contratos disponíveis...',
    'CONTRATOS CONTRADOS',
    'Bem-vindo, Agente.',
  ];

  const infoEntries = [
    'SyndTract v2.0',
    '',
    "Identificamos alvos potentes de alto valor que são",
    'Atualmente designado para sua área de missão. Eles são acreditados',
    'para manter informações valiosas que poderiam ser de imediato',
    'importância para nossa organização.',
    '',
    'Listados abaixo estão todos os contratos disponíveis para você. Você.',
    'Devem viajar o mundo específico para o designado',
    'Deixe-nos, e entre em contato através deste link. Nós enviaremos',
    'uma unidade de extração especializada para colocar o corpo.',
    '',
    'Queremos alvos vivos, mas às vezes pagamos pouco.',
    "Se não forem, você não receberá o programa.",
    'Bônus. Você pode redimir seu pagamento através desta ligação.',
    'a forma de telecristais crus, que podem ser colocados em seu',
    'Sindicato regular uplink para comprar o que você pode precisar.',
    'Nós fornecemos estes cristais no momento em que você enviar o',
    'alvo até nós, que pode ser coletado a qualquer momento através',
    'Este sistema.',
    '',
    'Alvos extraídos serão resgatados para a estação uma vez.',
    'Seu uso para nós é cumprido, com nós fornecendo-lhe um pequeno',
    'Corte percentual. Você pode querer estar atento a eles.',
    'Identificando você quando voltarem. Nós fornecemos-lhe',
    'um contrato padrão de carga, que vai ajudar a cobrir o seu',
    'identity.',
  ];

  const errorPane = !!data.error && (
    <Modal backgroundColor="red">
      <Flex align="center">
        <Flex.Item mr={2}>
          <Icon size={4} name="exclamation-triangle" />
        </Flex.Item>
        <Flex.Item mr={2} grow={1} textAlign="center">
          <Box width="260px" textAlign="left" minHeight="80px">
            {data.error}
          </Box>
          <Button content="Dismiss" onClick={() => act('PRG_clear_error')} />
        </Flex.Item>
      </Flex>
    </Modal>
  );

  if (!data.logged_in) {
    return (
      <Section minHeight="525px">
        <Box width="100%" textAlign="center">
          <Button
            content="REGISTO DO UTILIZADOR"
            color="transparent"
            onClick={() => act('PRG_login')}
          />
        </Box>
        {!!data.error && <NoticeBox>{data.error}</NoticeBox>}
      </Section>
    );
  }

  if (data.logged_in && data.first_load) {
    return (
      <Box backgroundColor="Rgba (0, 0, 0, 0,8)" minHeight="525px">
        <FakeTerminal
          allMessages={terminalMessages}
          finishedTimeout={3000}
          onFinished={() => act('PRG_set_first_load_finished')}
        />
      </Box>
    );
  }

  if (data.info_screen) {
    return (
      <>
        <Box backgroundColor="Rgba (0, 0, 0, 0,8)" minHeight="500px">
          <FakeTerminal allMessages={infoEntries} linesPerSecond={10} />
        </Box>
        <Button
          fluid
          content="CONTINUE"
          color="transparent"
          textAlign="center"
          onClick={() => act('PRG_toggle_info')}
        />
      </>
    );
  }

  return (
    <>
      {errorPane}
      <SyndPane />
    </>
  );
};

export const StatusPane = (props) => {
  const { act, data } = useBackend();

  return (
    <Section
      title={
        <>
          Contractor Status
          <Button
            content="Veja a informação novamente"
            color="transparent"
            mb={0}
            ml={1}
            onClick={() => act('PRG_toggle_info')}
          />
        </>
      }
      buttons={
        <Box bold mr={1}>
          {data.contract_rep} Rep
        </Box>
      }
    >
      <Stack>
        <Stack.Item grow>
          <LabeledList>
            <LabeledList.Item
              label="TC disponível"
              buttons={
                <Button
                  content="Claim"
                  disabled={data.redeemable_tc <= 0}
                  onClick={() => act('PRG_redeem_TC')}
                />
              }
            >
              {String(data.redeemable_tc)}
            </LabeledList.Item>
            <LabeledList.Item label="TC Ganhou">
              {String(data.earned_tc)}
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
        <Stack.Item grow>
          <LabeledList>
            <LabeledList.Item label="Contratos concluídos">
              {String(data.contracts_completed)}
            </LabeledList.Item>
            <LabeledList.Item label="Estado atual">ACTIVE</LabeledList.Item>
          </LabeledList>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

export const SyndPane = (props) => {
  const [tab, setTab] = useState(1);
  return (
    <>
      <StatusPane state={props.state} />
      <Tabs>
        <Tabs.Tab selected={tab === 1} onClick={() => setTab(1)}>
          Contracts
        </Tabs.Tab>
        <Tabs.Tab selected={tab === 2} onClick={() => setTab(2)}>
          Hub
        </Tabs.Tab>
      </Tabs>
      {tab === 1 && <ContractsTab />}
      {tab === 2 && <HubTab />}
    </>
  );
};

const ContractsTab = (props) => {
  const { act, data } = useBackend();
  const contracts = data.contracts || [];
  return (
    <>
      <Section
        title="Contratos Disponíveis"
        buttons={
          <Button
            content="Chamada Extração"
            disabled={!data.ongoing_contract || data.extraction_enroute}
            onClick={() => act('PRG_call_extraction')}
          />
        }
      >
        {contracts.map((contract) => {
          if (
            data.ongoing_contract &&
            contract.status !== CONTRACT_STATUS_ACTIVE
          ) {
            return CONTRACT_STATUS_INACTIVE;
          }
          const active = contract.status > CONTRACT_STATUS_INACTIVE;
          if (contract.status >= CONTRACT_STATUS_COMPLETE) {
            return CONTRACT_STATUS_COMPLETE;
          }
          return (
            <Section
              key={contract.target}
              title={
                contract.target
                  ? `${contract.target} (${contract.target_rank})`
                  : 'Alvo inválido'
              }
              level={active ? 1 : 2}
              buttons={
                <>
                  <Box inline bold mr={1}>
                    {`${contract.payout} (+${contract.payout_bonus}) TC`}
                  </Box>
                  <Button
                    content={active ? 'Abort' : 'Accept'}
                    disabled={contract.extraction_enroute}
                    color={active && 'bad'}
                    onClick={() =>
                      act(`PRG_contract${active ? '_abort' : '-accept'}`, {
                        contract_id: contract.id,
                      })
                    }
                  />
                </>
              }
            >
              <NoticeBox>
                <box>{contract.message}</box>
                <Box bold mb={1}>
                  Dropoff Location:
                </Box>
                <Box>{contract.dropoff}</Box>
              </NoticeBox>
            </Section>
          );
        })}
      </Section>
      <Section
        title="Localização de entrega"
        textAlign="center"
        opacity={data.ongoing_contract ? 100 : 0}
      >
        <Box bold>{data.dropoff_direction}</Box>
      </Section>
    </>
  );
};

const HubTab = (props) => {
  const { act, data } = useBackend();
  const contractor_hub_items = data.contractor_hub_items || [];
  return (
    <Section>
      {contractor_hub_items.map((item) => {
        const repInfo = item.cost ? `${item.cost} Rep` : 'FREE';
        const limited = item.limited !== -1;
        return (
          <Section
            key={item.name}
            title={`${item.name} - ${repInfo}`}
            level={2}
            buttons={
              <>
                {limited && (
                  <Box inline bold mr={1}>
                    {item.limited} remaining
                  </Box>
                )}
                <Button
                  content="Purchase"
                  disabled={
                    data.contract_rep < item.cost ||
                    (limited && item.limited <= 0)
                  }
                  onClick={() =>
                    act('buy_hub', {
                      item: item.name,
                      cost: item.cost,
                    })
                  }
                />
              </>
            }
          >
            <Table>
              <Table.Row>
                <Table.Cell>
                  <Icon fontSize="60px" name={item.item_icon} />
                </Table.Cell>
                <Table.Cell verticalAlign="top">{item.desc}</Table.Cell>
              </Table.Row>
            </Table>
          </Section>
        );
      })}
    </Section>
  );
};
