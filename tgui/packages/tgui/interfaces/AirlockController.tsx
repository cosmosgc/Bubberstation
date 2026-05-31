import { Box, Button, Icon, LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type AirlockControllerData = {
  airlockState: string;
  sensorPressure: number;
  pumpStatus: string;
  interiorStatus: string;
  exteriorStatus: string;
};

type AirlockStatus = {
  primary: string;
  icon: string;
  color: string;
};

export const AirlockController = (props) => {
  const { data } = useBackend<AirlockControllerData>();
  const { airlockState, pumpStatus, interiorStatus, exteriorStatus } = data;
  const currentStatus: AirlockStatus = getAirlockStatus(airlockState);
  const nameToUpperCase = (str: string) =>
    str.replace(/^\w/, (c) => c.toUpperCase());

  return (
    <Window width={500} height={190}>
      <Window.Content>
        <Section title="Status da câmara de ar" buttons={<AirLockButtons />}>
          <LabeledList>
            <LabeledList.Item label="Estado atual">
              {currentStatus.primary}
            </LabeledList.Item>
            <LabeledList.Item label="Pressão na câmara">
              <PressureIndicator currentStatus={currentStatus} />
            </LabeledList.Item>
            <LabeledList.Item label="Bomba de controle">
              {nameToUpperCase(pumpStatus)}
            </LabeledList.Item>
            <LabeledList.Item label="Porta interior">
              <Box color={interiorStatus === 'open' && 'good'}>
                {nameToUpperCase(interiorStatus)}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="Porta Exterior">
              <Box color={exteriorStatus === 'open' && 'good'}>
                {nameToUpperCase(exteriorStatus)}
              </Box>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};

/** Displays the buttons on top of the window to cycle the airlock */
const AirLockButtons = (props) => {
  const { act, data } = useBackend<AirlockControllerData>();
  const { airlockState } = data;
  switch (airlockState) {
    case 'pressurize':
    case 'depressurize':
      return (
        <Button icon="stop-circle" onClick={() => act('abort')}>
          Abort
        </Button>
      );
    case 'closed':
      return (
        <>
          <Button icon="lock-open" onClick={() => act('cycleInterior')}>
            Open Interior Airlock
          </Button>
          <Button icon="lock-open" onClick={() => act('cycleExterior')}>
            Open Exterior Airlock
          </Button>
        </>
      );
    case 'inopen':
      return (
        <>
          <Button icon="lock" onClick={() => act('cycleClosed')}>
            Close Interior Airlock
          </Button>
          <Button icon="sync" onClick={() => act('cycleExterior')}>
            Cycle to Exterior Airlock
          </Button>
        </>
      );
    case 'outopen':
      return (
        <>
          <Button icon="lock" onClick={() => act('cycleClosed')}>
            Close Exterior Airlock
          </Button>
          <Button icon="sync" onClick={() => act('cycleInterior')}>
            Cycle to Interior Airlock
          </Button>
        </>
      );
    default:
      return null;
  }
};

/** Displays the numeric pressure alongside an icon for the user */
const PressureIndicator = (props) => {
  const { data } = useBackend<AirlockControllerData>();
  const { sensorPressure } = data;
  const {
    currentStatus: { icon, color },
  } = props;
  const spin = icon === 'fan';

  return (
    <Box color={color}>
      {sensorPressure} kPa {icon && <Icon name={icon} spin={spin} />}
    </Box>
  );
};

/** Displays the current status as two text strings, depending on door state. */
const getAirlockStatus = (airlockState): AirlockStatus => {
  switch (airlockState) {
    case 'inopen':
      return {
        primary: 'Porta de ar interior aberta.',
        icon: '',
        color: 'good',
      };
    case 'pressurize':
      return {
        primary: 'Ciclismo para a câmara de ar interior',
        icon: 'fan',
        color: 'average',
      };
    case 'closed':
      return {
        primary: 'Inactive',
        icon: '',
        color: 'white',
      };
    case 'depressurize':
      return {
        primary: 'Ciclismo para a câmara externa',
        icon: 'fan',
        color: 'average',
      };
    case 'outopen':
      return {
        primary: 'Porta de ar exterior aberta.',
        icon: 'exclamation-triangle',
        color: 'bad',
      };
    default:
      return {
        primary: 'Unknown',
        icon: '',
        color: 'average',
      };
  }
};
