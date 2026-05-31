import {
  BlockQuote,
  Box,
  Button,
  Collapsible,
  Dropdown,
  Input,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Table,
  Tabs,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { NtosWindow } from '../layouts';

export const NtosScipaper = (props) => {
  return (
    <NtosWindow width={600} height={600}>
      <NtosWindow.Content scrollable>
        <NtosScipaperContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const PaperPublishing = (props) => {
  const { act, data } = useBackend();
  const {
    title,
    author,
    etAlia,
    abstract,
    fileList = [],
    expList = [],
    allowedTiers = [],
    allowedPartners = [],
    gains,
    selectedFile,
    selectedExperiment,
    tier,
    selectedPartner,
    coopIndex,
    fundingIndex,
  } = data;
  return (
    <>
      <Section title="Formulário de submissão">
        {fileList.length === 0 && (
          <NoticeBox>
            Use data disk to download files from compressor or doppler array.
          </NoticeBox>
        )}
        <LabeledList>
          <LabeledList.Item
            label="Arquivo (obrigatório)"
            buttons={
              <Button
                tooltip="O arquivo selecionado contendo dados experimentais para nosso trabalho. Deve estar no sistema de arquivos local ou um disco de dados para ser acessível."
                icon="info-circle"
              />
            }
          >
            <Box position="relative" top="8px">
              <Dropdown
                width="100%"
                options={Object.keys(fileList)}
                selected={selectedFile}
                onSelected={(ordfile_name) =>
                  act('select_file', {
                    selected_uid: fileList[ordfile_name],
                  })
                }
              />
            </Box>
          </LabeledList.Item>
          <LabeledList.Item
            label="Experiência (obrigatória)"
            buttons={
              <Button
                tooltip="O tópico que queremos publicar nosso trabalho. Diferentes tópicos desbloqueiam diferentes tecnologias e possíveis parceiros."
                icon="info-circle"
              />
            }
          >
            <Box position="relative" top="8px">
              <Dropdown
                width="100%"
                options={Object.keys(expList)}
                selected={selectedExperiment}
                onSelected={(experiment_name) =>
                  act('select_experiment', {
                    selected_expath: expList[experiment_name],
                  })
                }
              />
            </Box>
          </LabeledList.Item>
          <LabeledList.Item
            label="Tier (obrigatório)"
            buttons={
              <Button
                tooltip="O nível que queremos publicar. Níveis mais altos podem conferir melhores recompensas, mas significa que nossos dados serão julgados com mais severidade."
                icon="info-circle"
              />
            }
          >
            <Box position="relative" top="8px">
              <Dropdown
                width="100%"
                options={allowedTiers.map((number) => String(number))}
                selected={String(tier)}
                onSelected={(new_tier) =>
                  act('select_tier', {
                    selected_tier: Number(new_tier),
                  })
                }
              />
            </Box>
          </LabeledList.Item>
          <LabeledList.Item
            label="Parceiro (obrigatório)"
            buttons={
              <Button
                tooltip="Qual organização para fazer parceria. Podemos obter impulsos de pesquisa em técnicos relacionados aos interesses do parceiro."
                icon="info-circle"
              />
            }
          >
            <Box position="relative" top="8px">
              <Dropdown
                width="100%"
                options={Object.keys(allowedPartners)}
                selected={selectedPartner}
                onSelected={(new_partner) =>
                  act('select_partner', {
                    selected_partner: allowedPartners[new_partner],
                  })
                }
              />
            </Box>
          </LabeledList.Item>
          <LabeledList.Item
            label="Diretor Autor"
            buttons={
              <Button
                tooltip="Multiple"
                selected={etAlia}
                icon="users"
                onClick={() => act('et_alia')}
              />
            }
          >
            <Input
              mt={2}
              fluid
              value={author}
              onBlur={(value) =>
                act('rewrite', {
                  author: value,
                })
              }
            />
          </LabeledList.Item>
          <LabeledList.Item label="Title">
            <Input
              fluid
              value={title}
              onBlur={(value) =>
                act('rewrite', {
                  title: value,
                })
              }
            />
          </LabeledList.Item>
          <LabeledList.Item label="Abstract">
            <Input
              fluid
              value={abstract}
              onBlur={(value) =>
                act('rewrite', {
                  abstract: value,
                })
              }
            />
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section title="Resultados esperados" key="rewards">
        <Stack fill>
          <Stack.Item grow>
            <Button
              tooltip="Quanto nossa relação melhorará com o parceiro em particular. A cooperação será usada para desbloquear impulsos."
              icon="info-circle"
            />
            {' Cooperation: '}
            <BlockQuote>{gains[coopIndex]}</BlockQuote>
          </Stack.Item>
          <Stack.Item grow>
            <Button
              tooltip="Quanta bolsa teremos com a publicação deste artigo."
              icon="info-circle"
            />
            {' Funding: '}
            <BlockQuote>{gains[fundingIndex]}</BlockQuote>
          </Stack.Item>
        </Stack>
        <br />
        <Button
          lineHeight={3}
          icon="upload"
          textAlign="center"
          fluid
          onClick={() => act('publish')}
        >
          Publish Paper
        </Button>
      </Section>
    </>
  );
};

const PaperBrowser = (props) => {
  const { act, data } = useBackend();
  const { publishedPapers, coopIndex, fundingIndex } = data;
  if (publishedPapers.length === 0) {
    return <NoticeBox> No Published Papers! </NoticeBox>;
  } else {
    return publishedPapers.map((paper) => (
      <Collapsible
        key={String(paper.experimentName + paper.tier)}
        title={paper.title}
      >
        <Section>
          <LabeledList>
            <LabeledList.Item label="Topic">
              {`${paper.experimentName} - ${paper.tier}`}
            </LabeledList.Item>
            <LabeledList.Item label="Author">
              {paper.author + (paper.etAlia ? 'et al.' : '')}
            </LabeledList.Item>
            <LabeledList.Item label="Partner">{paper.partner}</LabeledList.Item>
            <LabeledList.Item label="Yield">
              <LabeledList>
                <LabeledList.Item label="Cooperation">
                  {paper.gains[coopIndex]}
                </LabeledList.Item>
                <LabeledList.Item label="Funding">
                  {paper.gains[fundingIndex]}
                </LabeledList.Item>
              </LabeledList>
            </LabeledList.Item>
            <LabeledList.Item label="Abstract">
              {paper.abstract}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Collapsible>
    ));
  }
};
const ExperimentBrowser = (props) => {
  const { act, data } = useBackend();
  const { experimentInformation = [] } = data;
  return experimentInformation.map((experiment) => (
    <Section title={experiment.name} key={experiment.name}>
      {experiment.description}
      <br />
      <LabeledList>
        {Object.keys(experiment.target).map((tier) => (
          <LabeledList.Item
            key={tier}
            label={
              'Optimal ' +
              experiment.prefix +
              'Quantidade - Nível' +
              String(Number(tier) + 1)
            }
          >
            {`${experiment.target[tier]} ${experiment.suffix}`}
          </LabeledList.Item>
        ))}
      </LabeledList>
    </Section>
  ));
};

const PartnersBrowser = (props) => {
  const { act, data } = useBackend();
  const {
    partnersInformation,
    coopIndex,
    fundingIndex,
    purchaseableBoosts = [],
    relations = [],
    visibleNodes = [],
  } = data;
  return partnersInformation.map((partner) => (
    <Section title={partner.name} key={partner.path}>
      <Collapsible title={`Relations: ${relations[partner.path]}`}>
        <LabeledList>
          <LabeledList.Item label="Description">
            {partner.flufftext}
          </LabeledList.Item>
          <LabeledList.Item label="Relations">
            {relations[partner.path]}
          </LabeledList.Item>
          <LabeledList.Item label="Bônus de Cooperação">
            {`${partner.multipliers[coopIndex]}x`}
          </LabeledList.Item>
          <LabeledList.Item label="Bônus de Financiamento">
            {`${partner.multipliers[fundingIndex]}x`}
          </LabeledList.Item>
          <LabeledList.Item label="Experiências aceitas">
            {partner.acceptedExperiments.map((experiment_name) => (
              <Box key={experiment_name}>{experiment_name}</Box>
            ))}
          </LabeledList.Item>
          <LabeledList.Item label="Compartilhamento de Tecnologia">
            <Table>
              {partner.boostedNodes.map((node) => (
                <Table.Row key={node.id}>
                  <Table.Cell>
                    {visibleNodes.includes(node.id)
                      ? node.name
                      : 'Tecnologia desconhecida'}
                  </Table.Cell>
                  <Table.Cell>
                    <Button
                      fluid
                      tooltipPosition="left"
                      textAlign="center"
                      disabled={
                        !purchaseableBoosts[partner.path].includes(node.id)
                      }
                      content="Purchase"
                      tooltip={`Discount: ${node.discount}`}
                      onClick={() =>
                        act('purchase_boost', {
                          purchased_boost: node.id,
                          boost_seller: partner.path,
                        })
                      }
                    />
                  </Table.Cell>
                </Table.Row>
              ))}
            </Table>
          </LabeledList.Item>
        </LabeledList>
      </Collapsible>
    </Section>
  ));
};

export const NtosScipaperContent = (props) => {
  const { act, data } = useBackend();
  const { currentTab, has_techweb } = data;
  return (
    <>
      {!has_techweb && (
        <Section title="Sem techweb detectado!" key="rewards">
          Please sync this application to a valid techweb to upload progress!
        </Section>
      )}
      <Tabs key="navigation" fluid align="center">
        <Tabs.Tab
          selected={currentTab === 1}
          onClick={() =>
            act('change_tab', {
              new_tab: 1,
            })
          }
        >
          {'Publicar documentos'}
        </Tabs.Tab>
        <Tabs.Tab
          selected={currentTab === 2}
          onClick={() =>
            act('change_tab', {
              new_tab: 2,
            })
          }
        >
          {'Publications'}
        </Tabs.Tab>
        <Tabs.Tab
          selected={currentTab === 3}
          onClick={() =>
            act('change_tab', {
              new_tab: 3,
            })
          }
        >
          {'Experiments'}
        </Tabs.Tab>
        <Tabs.Tab
          selected={currentTab === 4}
          onClick={() =>
            act('change_tab', {
              new_tab: 4,
            })
          }
        >
          {'Parceiros Científicos'}
        </Tabs.Tab>
      </Tabs>
      {currentTab === 1 && <PaperPublishing />}
      {currentTab === 2 && <PaperBrowser />}
      {currentTab === 3 && <ExperimentBrowser />}
      {currentTab === 4 && <PartnersBrowser />}
    </>
  );
};
