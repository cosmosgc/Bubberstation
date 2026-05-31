import {
  AnimatedNumber,
  Box,
  Button,
  Flex,
  Icon,
  LabeledList,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';

export const MedicalKiosk = (props) => {
  const { act, data } = useBackend();
  const [scanIndex] = useSharedState('scanIndex');
  const { active_status_1, active_status_2, active_status_3, active_status_4 } =
    data;
  return (
    <Window width={575} height={420}>
      <Window.Content scrollable>
        <Flex mb={1}>
          <Flex.Item mr={1}>
            <Section minHeight="100%">
              <MedicalKioskScanButton
                index={1}
                icon="procedures"
                name="Scan de Saúde Geral"
                description={`
                  Reads back exact values of your general health scan.
                `}
              />
              <MedicalKioskScanButton
                index={2}
                icon="heartbeat"
                name="Exame baseado em sinomas"
                description={`
                  Provides information based on various non-obvious symptoms,
                  like blood levels or disease status.
                `}
              />
              <MedicalKioskScanButton
                index={3}
                icon="radiation-alt"
                name="Scan Neurológico/Radiológico"
                description={`
                  Provides information about brain trauma and radiation.
                `}
              />
              <MedicalKioskScanButton
                index={4}
                icon="mortar-pestle"
                name="Scan químico e psicoativo"
                description={`
                  Provides a list of consumed chemicals, as well as potential
                  side effects.
                `}
              />
            </Section>
          </Flex.Item>
          <Flex.Item grow={1} basis={0}>
            <MedicalKioskInstructions />
          </Flex.Item>
        </Flex>
        {!!active_status_1 && scanIndex === 1 && <MedicalKioskScanResults1 />}
        {!!active_status_2 && scanIndex === 2 && <MedicalKioskScanResults2 />}
        {!!active_status_3 && scanIndex === 3 && <MedicalKioskScanResults3 />}
        {!!active_status_4 && scanIndex === 4 && <MedicalKioskScanResults4 />}
      </Window.Content>
    </Window>
  );
};

const MedicalKioskScanButton = (props) => {
  const { index, name, description, icon } = props;
  const { act, data } = useBackend();
  const [scanIndex, setScanIndex] = useSharedState('scanIndex');
  const paid = data[`active_status_${index}`];
  return (
    <Stack align="baseline">
      <Stack.Item width="16px" textAlign="center">
        <Icon
          name={paid ? 'check' : 'dollar-sign'}
          color={paid ? 'green' : 'grey'}
        />
      </Stack.Item>
      <Stack.Item grow basis="content">
        <Button
          fluid
          icon={icon}
          selected={paid && scanIndex === index}
          tooltip={description}
          tooltipPosition="right"
          content={name}
          onClick={() => {
            if (!paid) {
              act(`beginScan_${index}`);
            }
            setScanIndex(index);
          }}
        />
      </Stack.Item>
    </Stack>
  );
};

const MedicalKioskInstructions = (props) => {
  const { act, data } = useBackend();
  const { kiosk_cost, patient_name } = data;
  return (
    <Section minHeight="100%">
      <Box italic>
        Greetings Valued Employee! Please select a desired automatic health
        check procedure. Diagnosis costs <b>{kiosk_cost} credits.</b>
      </Box>
      <Box mt={1}>
        <Box inline color="label" mr={1}>
          Patient:
        </Box>
        {patient_name}
      </Box>
      <Button
        mt={1}
        tooltip={`
          Resets the current scanning target, cancelling current scans.
        `}
        icon="sync"
        color="average"
        onClick={() => act('clearTarget')}
        content="Reinicie o scanner."
      />
    </Section>
  );
};

const MedicalKioskScanResults1 = (props) => {
  const { data } = useBackend();
  const {
    patient_health,
    brute_health,
    burn_health,
    suffocation_health,
    toxin_health,
  } = data;
  return (
    <Section title="Saúde do Paciente">
      <LabeledList>
        <LabeledList.Item label="Saúde Total">
          <ProgressBar value={patient_health / 100}>
            <AnimatedNumber value={patient_health} />%
          </ProgressBar>
        </LabeledList.Item>
        <LabeledList.Divider />
        <LabeledList.Item label="Dano Bruto">
          <ProgressBar value={brute_health / 100} color="bad">
            <AnimatedNumber value={brute_health} />
          </ProgressBar>
        </LabeledList.Item>
        <LabeledList.Item label="Dano por Queimaduras">
          <ProgressBar value={burn_health / 100} color="bad">
            <AnimatedNumber value={burn_health} />
          </ProgressBar>
        </LabeledList.Item>
        <LabeledList.Item label="Dano por oxigênio">
          <ProgressBar value={suffocation_health / 100} color="bad">
            <AnimatedNumber value={suffocation_health} />
          </ProgressBar>
        </LabeledList.Item>
        <LabeledList.Item label="Dano Toxina">
          <ProgressBar value={toxin_health / 100} color="bad">
            <AnimatedNumber value={toxin_health} />
          </ProgressBar>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const MedicalKioskScanResults2 = (props) => {
  const { data } = useBackend();
  const {
    patient_status,
    patient_illness,
    illness_info,
    bleed_status,
    blood_levels,
    blood_name,
    blood_status,
  } = data;
  return (
    <Section title="Exame baseado em sinomas">
      <LabeledList>
        <LabeledList.Item label="Situação do paciente" color="good">
          {patient_status}
        </LabeledList.Item>
        <LabeledList.Divider />
        <LabeledList.Item label="Estado da doença">
          {patient_illness}
        </LabeledList.Item>
        <LabeledList.Item label="Informação da doença.">
          {illness_info}
        </LabeledList.Item>
        <LabeledList.Divider />
        <LabeledList.Item label={`${blood_name} Levels`}>
          <ProgressBar value={blood_levels / 100} color="bad">
            <AnimatedNumber value={blood_levels} />
          </ProgressBar>
          <Box mt={1} color="label">
            {bleed_status}
          </Box>
        </LabeledList.Item>
        <LabeledList.Item label={`${blood_name} Information`}>
          {blood_status}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const MedicalKioskScanResults3 = (props) => {
  const { data } = useBackend();
  const { brain_damage, brain_health, trauma_status } = data;
  return (
    <Section title="Saúde Neurológica do Paciente">
      <LabeledList>
        <LabeledList.Item label="Dano cerebral">
          <ProgressBar value={brain_damage / 100} color="good">
            <AnimatedNumber value={brain_damage} />
          </ProgressBar>
        </LabeledList.Item>
        <LabeledList.Item label="Estado Cérebro" color="health-0">
          {brain_health}
        </LabeledList.Item>
        <LabeledList.Item label="Trauma cerebral">
          {trauma_status}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const MedicalKioskScanResults4 = (props) => {
  const { data } = useBackend();
  const {
    chemical_list = [],
    overdose_list = [],
    addict_list = [],
    hallucinating_status,
    blood_alcohol,
  } = data;
  return (
    <Section title="Análise Química e Psicoativa">
      <LabeledList>
        <LabeledList.Item label="Teor Químico">
          {chemical_list.length === 0 && (
            <Box color="average">No reagents detected.</Box>
          )}
          {chemical_list.map((chem) => (
            <Box key={chem.id} color="good">
              {chem.volume} units of {chem.name}
            </Box>
          ))}
        </LabeledList.Item>
        <LabeledList.Item label="Situação de Overdose" color="bad">
          {overdose_list.length === 0 && (
            <Box color="good">Patient is not overdosing.</Box>
          )}
          {overdose_list.map((chem) => (
            <Box key={chem.id}>Overdosing on {chem.name}</Box>
          ))}
        </LabeledList.Item>
        <LabeledList.Item label="Estado do vício" color="bad">
          {addict_list.length === 0 && (
            <Box color="good">Patient has no addictions.</Box>
          )}
          {addict_list.map((chem) => (
            <Box key={chem.id}>Addicted to {chem.name}</Box>
          ))}
        </LabeledList.Item>
        <LabeledList.Item label="Status Psiatosivo">
          {hallucinating_status}
        </LabeledList.Item>
        <LabeledList.Item label="Teor de álcool no sangue">
          <ProgressBar
            value={blood_alcohol}
            minValue={0}
            maxValue={0.3}
            ranges={{
              blue: [-Infinity, 0.23],
              bad: [0.23, Infinity],
            }}
          >
            <AnimatedNumber value={blood_alcohol} />
          </ProgressBar>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
