import { useState } from 'react';
import {
  Button,
  Flex,
  LabeledControls,
  NoticeBox,
  RoundGauge,
  Section,
  Stack,
} from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const TAB2NAME = [
  {
    title: 'Debugging',
    blurb: 'Onde merda inútil vai morrer',
    gauge: 5,
    component: () => DebuggingTab,
  },
  {
    title: 'Helpful',
    blurb: 'Onde os idiotas colocam a madeira',
    gauge: 25,
    component: () => HelpfulTab,
  },
  {
    title: 'Fun',
    blurb: 'Como eu corri um "" evento""',
    gauge: 75,
    component: () => FunTab,
  },
  {
    title: 'Só diversão para você',
    blurb: 'Como passei meu último dia administrando',
    gauge: 95,
    component: () => FunForYouTab,
  },
];

const lineHeightNormal = 2.79;
const buttonWidthNormal = 12.9;
const lineHeightDebug = 6.09;

const DebuggingTab = (props) => {
  const { act } = useBackend();
  return (
    <Stack fill vertical>
      <Stack.Item>
        <Button
          color="average"
          lineHeight={lineHeightDebug}
          icon="question"
          fluid
          content="Mude todas as portas de manutenção para acesso engie/brig apenas"
          onClick={() => act('maint_access_engiebrig')}
        />
      </Stack.Item>
      <Stack.Item>
        <Button
          color="average"
          lineHeight={lineHeightDebug}
          icon="question"
          fluid
          content="Mude todas as portas de manutenção para o acesso à cela."
          onClick={() => act('maint_access_brig')}
        />
      </Stack.Item>
      <Stack.Item>
        <Button
          color="average"
          lineHeight={lineHeightDebug}
          icon="question"
          fluid
          content="Retirem o boné dos oficiais de segurança."
          onClick={() => act('infinite_sec')}
        />
      </Stack.Item>
    </Stack>
  );
};

const HelpfulTab = (props) => {
  const { act } = useBackend();
  return (
    <Stack fill vertical>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <NoticeBox
              mb={-0.5}
              width={buttonWidthNormal}
              height={lineHeightNormal}
            >
              Your admin button here, coder!
            </NoticeBox>
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="plus"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Curar todas as doenças"
              onClick={() => act('clear_virus')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="biohazard"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Surto do gatilho"
              onClick={() => act('virus')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="plane-slash"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Corrija a gravidade da estação."
              onClick={() => act('fix_gravity')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="grin-beam-sweat"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Quebre todas as luzes"
              onClick={() => act('blackout')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="magic"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Conserte todas as luzes."
              onClick={() => act('whiteout')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="bomb"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="List Bombers"
              onClick={() => act('list_bombers')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="signal"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Sinalizadores de lista"
              onClick={() => act('list_signalers')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="robot"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Lista de leis"
              onClick={() => act('list_lawchanges')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="address-book"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Mostre o Manifesto"
              onClick={() => act('manifest')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="dna"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Mostre DNA"
              onClick={() => act('dna')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="fingerprint"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Mostre as impressões digitais."
              onClick={() => act('fingerprints')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="flag"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Alternar CTF"
              onClick={() => act('ctfbutton')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="sync-alt"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Reset Thunderdome"
              onClick={() => act('tdomereset')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="moon"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Set Nightshift"
              onClick={() => act('night_shift_set')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="pencil-alt"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Renomear estação"
              onClick={() => act('set_name')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="eraser"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Nome padrão da estação"
              onClick={() => act('reset_name')}
            />
          </Stack.Item>
          <Stack.Item>
            <NoticeBox
              mb={-0.5}
              width={buttonWidthNormal}
              height={lineHeightNormal}
            >
              Your admin button here, coder!
            </NoticeBox>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

const FunTab = (props) => {
  const { act } = useBackend();
  return (
    <Stack fill vertical>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="robot"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Faça N.E.R.D."
              onClick={() => act('makeNerd')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="flag"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="CTF Modo Instagib"
              onClick={() => act('ctf_instagib')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="plus"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Mass Cure todos."
              onClick={() => act('mass_heal')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="bolt"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Todas as áreas powered"
              onClick={() => act('power')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="moon"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Todas as áreas não powered"
              onClick={() => act('unpower')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="plug"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Recarregar SMES"
              onClick={() => act('quickpower')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="user-ninja"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Nomes Anônimos"
              onClick={() => act('anon_name')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="robot"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Triplo modo IA"
              onClick={() => act('tripleAI')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="bullhorn"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Só pode ser..."
              onClick={() => act('onlyone')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="grin-beam-sweat"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Invocar armas"
              onClick={() => act('guns')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="magic"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Invoque a Magia"
              onClick={() => act('magic')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="meteor"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Convocar Eventos"
              onClick={() => act('events')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="hammer"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Estação igualitária"
              onClick={() => act('eagles')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="house"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Envie o ônibus de volta."
              onClick={() => act('send_shuttle_back')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="oil-well"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Toque em Ore Vents."
              onClick={() => act('ore_vents')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <Button
              icon="bullseye"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Tempestade de Portal Personalizada"
              onClick={() => act('customportal')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="bomb"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Troque o boné da bomba."
              onClick={() => act('changebombcap')}
            />
          </Stack.Item>
          <Stack.Item>
            <Button
              icon="dollar-sign"
              lineHeight={lineHeightNormal}
              width={buttonWidthNormal}
              content="Dpt Ordem Refrigeração"
              onClick={() => act('department_cooldown_override')}
            />
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

const FunForYouTab = (props) => {
  const { act } = useBackend();
  return (
    <Stack fill vertical>
      <Stack.Item>
        <Stack>
          <Stack.Item>
            <NoticeBox danger mb={0} width={19.6}>
              <Button
                color="red"
                icon="user-secret"
                fluid
                content="Todo mundo é a antag"
                onClick={() => act('antag_all')}
              />
            </NoticeBox>
          </Stack.Item>
          <Stack.Item>
            <NoticeBox danger width={19.6} mb={0}>
              <Button
                color="red"
                icon="brain"
                fluid
                content="Todo mundo tem danos cerebrais."
                onClick={() => act('massbraindamage')}
              />
            </NoticeBox>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack>
          <Stack.Item>
            <NoticeBox danger mb={0} width={19.6}>
              <Button
                color="red"
                icon="hand-lizard"
                fluid
                content="Mudar a espécie de todos"
                onClick={() => act('allspecies')}
              />
            </NoticeBox>
          </Stack.Item>
          <Stack.Item>
            <NoticeBox danger width={19.6} mb={0}>
              <Button
                color="red"
                icon="paw"
                fluid
                content="Mude todos para macacos."
                onClick={() => act('monkey')}
              />
            </NoticeBox>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <NoticeBox danger mb={0}>
          <Button
            color="black"
            icon="fire"
            fluid
            content="O chão é lava! ( PERIGO: extremamente coxo)"
            onClick={() => act('floorlava')}
          />
        </NoticeBox>
      </Stack.Item>
      <Stack.Item>
        <NoticeBox danger mb={0}>
          <Button
            color="black"
            icon="fire"
            fluid
            content="Desenhos chineses! Sem voltar, também foda-se."
            onClick={() => act('anime')}
          />
        </NoticeBox>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <NoticeBox danger width={19.6} mb={0}>
              <Button
                color="red"
                icon="cat"
                fluid
                content="Purrbação em massa"
                onClick={() => act('masspurrbation')}
              />
            </NoticeBox>
          </Stack.Item>
          <Stack.Item>
            <NoticeBox info width={19.6} mb={0}>
              <Button
                color="blue"
                icon="user"
                fluid
                content="Curar Purrbation"
                onClick={() => act('massremovepurrbation')}
              />
            </NoticeBox>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <NoticeBox danger width={19.6} mb={0}>
              <Button
                color="red"
                icon="cat"
                fluid
                content="CASCAAADE"
                onClick={() => act('cascade')}
              />
            </NoticeBox>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack>
          <Stack.Item>
            <NoticeBox danger width={19.6} mb={0}>
              <Button
                color="red"
                icon="flushed"
                fluid
                content="Imergir totalmente todos"
                onClick={() => act('massimmerse')}
              />
            </NoticeBox>
          </Stack.Item>
          <Stack.Item>
            <NoticeBox info width={19.6} mb={0}>
              <Button
                color="blue"
                icon="sync-alt"
                fluid
                content="Destrua a imersão"
                onClick={() => act('unmassimmerse')}
              />
            </NoticeBox>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack fill>
          <Stack.Item>
            <NoticeBox danger width={19.6} mb={0}>
              <Button
                color="red"
                icon="comment-slash"
                fluid
                content="Torre de Babel"
                onClick={() => act('towerOfBabel')}
              />
            </NoticeBox>
          </Stack.Item>
          <Stack.Item>
            <NoticeBox info width={19.6} mb={0}>
              <Button
                color="blue"
                icon="comment"
                fluid
                content="Torre de Babel"
                onClick={() => act('cureTowerOfBabel')}
              />
            </NoticeBox>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

export const Secrets = (props) => {
  const { act, data } = useBackend();
  const { is_debugger, is_funmin } = data;
  const [tabIndex, setTabIndex] = useState(2);
  const TabComponent = TAB2NAME[tabIndex - 1].component();

  return (
    <Window title="Painel de Segredos" width={500} height={520} theme="admin">
      <Window.Content>
        <Flex direction="column" height="100%">
          <Flex.Item mb={1}>
            <Section
              title="Secrets"
              buttons={
                <>
                  <Button
                    color="blue"
                    icon="address-card"
                    content="Diário de administração"
                    onClick={() => act('admin_log')}
                  />
                  <Button
                    color="blue"
                    icon="eye"
                    content="Mostre os administradores."
                    onClick={() => act('show_admins')}
                  />
                </>
              }
            >
              <Flex mx={-0.5} align="stretch" justify="center">
                <Flex.Item bold>
                  <NoticeBox color="black">
                    &quot;The first rule of adminbuse is: you don&apos;t talk
                    about the adminbuse.&quot;
                  </NoticeBox>
                </Flex.Item>
              </Flex>
              <Flex
                textAlign="center"
                mx={-0.5}
                align="stretch"
                justify="center"
              >
                <Flex.Item ml={-10} mr={1}>
                  <Button
                    selected={tabIndex === 2}
                    icon="check-circle"
                    content="Helpful"
                    onClick={() => setTabIndex(2)}
                  />
                </Flex.Item>
                <Flex.Item ml={1}>
                  <Button
                    disabled={is_funmin === 0}
                    selected={tabIndex === 3}
                    icon="smile"
                    content="Fun"
                    onClick={() => setTabIndex(3)}
                  />
                </Flex.Item>
              </Flex>
              <Flex mx={-0.5} align="stretch" justify="center">
                <Flex.Item mt={1}>
                  <Button
                    disabled={is_debugger === 0}
                    selected={tabIndex === 1}
                    icon="glasses"
                    content="Debugging"
                    onClick={() => setTabIndex(1)}
                  />
                </Flex.Item>
                <Flex.Item>
                  <LabeledControls>
                    <LabeledControls.Item
                      minWidth="66px"
                      label="Possibilidades de queixa de administrador"
                    >
                      <RoundGauge
                        size={2}
                        value={TAB2NAME[tabIndex - 1].gauge}
                        minValue={0}
                        maxValue={100}
                        alertAfter={100 * 0.7}
                        ranges={{
                          good: [-2, 100 * 0.25],
                          average: [100 * 0.25, 100 * 0.75],
                          bad: [100 * 0.75, 100],
                        }}
                        format={(value) => `${toFixed(value)}%`}
                      />
                    </LabeledControls.Item>
                  </LabeledControls>
                </Flex.Item>
                <Flex.Item mt={1}>
                  <Button
                    disabled={is_funmin === 0}
                    selected={tabIndex === 4}
                    icon="smile-wink"
                    content="Só diversão para você"
                    onClick={() => setTabIndex(4)}
                  />
                </Flex.Item>
              </Flex>
            </Section>
          </Flex.Item>
          <Flex.Item grow={1}>
            <Section
              fill={false}
              title={
                TAB2NAME[tabIndex - 1].title +
                ' Or: ' +
                TAB2NAME[tabIndex - 1].blurb
              }
            >
              <TabComponent />
            </Section>
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};
