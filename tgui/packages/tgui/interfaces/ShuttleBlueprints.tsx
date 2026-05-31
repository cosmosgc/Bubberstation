import { type ReactNode, useState } from 'react';
import {
  Box,
  Button,
  Dropdown,
  Input,
  ProgressBar,
  Section,
  Stack,
  Tooltip,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Direction } from '../constants';
import { Window } from '../layouts';

type AreaData = { name: string; ref: string };

type VisualizationToggleProps = { visualizing: BooleanLike };

type ShuttleConstructionUnieuqData = {
  linkedShuttle: 0;
  tooManyShuttles: BooleanLike;
  onCustomShuttle: BooleanLike;
};

type ShuttleConfigurationUniqueData = {
  linkedShuttle: string;
  onShuttle: BooleanLike;
  inDefaultArea: BooleanLike;
  currentArea: AreaData;
  defaultApc: BooleanLike;
  apcInMergeRegion: BooleanLike;
  apcs: Record<string, BooleanLike>;
  neighboringAreas: Record<string, string>;
  idle: BooleanLike;
};

type ShuttleBlueprintsData = {
  shuttles?: Record<string, string>;
  visualizing: BooleanLike;
  masterExists: BooleanLike;
  isMaster: BooleanLike;
  maxShuttleSize: number;
} & (OnShuttleFrameData | OffShuttleFrameData) &
  (ShuttleConstructionUnieuqData | ShuttleConfigurationUniqueData);

type OnShuttleFrameData = {
  onShuttleFrame: 1;
  size: number;
  problems: number;
};

type OffShuttleFrameData = {
  onShuttleFrame: 0;
  size: undefined;
  problems: undefined;
};

type DirectionPadProps = {
  title: string;
  tooltip?: ReactNode;
  enabledDirections: Direction;
  selectedDirection: Direction;
  onSelect: (direction: Direction) => void;
};

const directionData: [Direction, string][] = [
  [Direction.NORTH, 'up'],
  [Direction.SOUTH, 'down'],
  [Direction.EAST, 'right'],
  [Direction.WEST, 'left'],
];

type ProblemsTooltipProps = {
  description: string;
  problemHeader: string;
  problems: number;
  problemStrings: string[];
};

const DirectionPad = (props: DirectionPadProps) => {
  const { title, tooltip, enabledDirections, selectedDirection, onSelect } =
    props;
  const [north, south, east, west] = directionData.map(
    ([direction, icon_suffix], i) => (
      <Stack.Item key={i}>
        <Button
          fluid
          m={0}
          icon={`arrow-${icon_suffix}`}
          selected={selectedDirection & direction}
          disabled={!(enabledDirections & direction)}
          onClick={() => onSelect(direction)}
        />
      </Stack.Item>
    ),
  );
  const titleNode = (
    <Box width="100%" textAlign="center">
      {title}
    </Box>
  );
  return (
    <Section
      fill
      title={
        tooltip ? <Tooltip content={tooltip}>{titleNode}</Tooltip> : titleNode
      }
    >
      <Stack fill vertical align="center" justify="center">
        {north}
        <Stack.Item>
          <Stack>
            {west}
            <Stack.Item width="1rem" mx={1} />
            {east}
          </Stack>
        </Stack.Item>
        {south}
      </Stack>
    </Section>
  );
};

const VisualizationToggle = (props: VisualizationToggleProps) => {
  const { visualizing } = props;
  const { act } = useBackend<ShuttleBlueprintsData>();
  return (
    <Tooltip
      content="Toggle a visualization of shuttle frames you can use to construct a shuttle.
                Red tiles indicate frame parts built in invalid areas,
                or parts of suitable areas that need frame parts built on them."
    >
      <Box inline>
        Visualization:
        <Button
          color="transparent"
          icon={visualizing ? 'toggle-on' : 'toggle-off'}
          onClick={() => act('toggleVisualization')}
        />
      </Box>
    </Tooltip>
  );
};

const ProblemsTooltip = (props: ProblemsTooltipProps) => {
  const { description, problemHeader, problems, problemStrings } = props;

  const problemElements: React.ReactElement[] = [];
  for (let i = 0; i < problemStrings.length; i++) {
    if (problems & (1 << i)) {
      problemElements.push(<Box key={i}>{`● ${problemStrings[i]}`}</Box>);
    }
  }

  return (
    <Box>
      {description}
      {problems ? (
        <>
          <Box>{problemHeader}</Box>
          {problemElements}
        </>
      ) : undefined}
    </Box>
  );
};

const ShuttleConstruction = () => {
  const [shuttleDirection, setShuttleDirection] = useState<Direction>(
    Direction.NORTH,
  );
  const { act, data } = useBackend<ShuttleBlueprintsData>();
  if (data.linkedShuttle !== 0) {
    throw new Error('Tipo falha de guarda - ligado O ônibus deve ser 0.');
  }
  const {
    onShuttleFrame,
    visualizing,
    tooManyShuttles,
    onCustomShuttle,
    masterExists,
    size,
    maxShuttleSize,
    problems,
  } = data;
  return (
    <Stack justify="space-around">
      <Stack.Item grow>
        <DirectionPad
          title="Direção do ônibus"
          tooltip="Isso especifica a direção que a nave está enfrentando."
          enabledDirections={Direction.ALL}
          selectedDirection={shuttleDirection}
          onSelect={(dir) => setShuttleDirection(dir)}
        />
      </Stack.Item>
      <Stack.Item>
        <Stack fill vertical align="end" justify="space-between">
          <Stack.Item>
            <VisualizationToggle visualizing={visualizing} />
          </Stack.Item>
          <Stack.Item>
            <Stack vertical>
              <Stack.Item>
                <Button.Confirm
                  disabled={!onShuttleFrame || tooManyShuttles || problems}
                  tooltip={
                    <ProblemsTooltip
                      description="Criar uma nova nave usando uma estrutura de transporte."
                      problemHeader="Os seguintes problemas impedem que você crie uma nave com este quadro."
                      problems={problems ?? 0}
                      problemStrings={[
                        'Você não está em uma estrutura de transporte.',
                        'Há muitas naves personalizadas atualmente.',
                        'Este quadro é muito grande.',
                        'This frame includes the APC of a custom area, but does not enclose the entire area.\
                         Remove the APC or add the rest of the area to the frame.',
                        'Este quadro entra em uma área em que as naves não podem atracar.',
                        'Este quadro inclui um APC pertencente a uma área não-costume.',
                      ]}
                    />
                  }
                  onClick={() =>
                    act('tryBuildShuttle', { dir: shuttleDirection })
                  }
                >
                  Build New Shuttle
                </Button.Confirm>
              </Stack.Item>
              {onShuttleFrame ? (
                <Stack.Item>
                  <ProgressBar
                    value={size}
                    maxValue={maxShuttleSize}
                    ranges={{
                      green: [0, maxShuttleSize * 0.5],
                      yellow: [maxShuttleSize * 0.5, maxShuttleSize * 0.75],
                      orange: [maxShuttleSize * 0.75, maxShuttleSize],
                      red: [maxShuttleSize, Infinity],
                    }}
                  >
                    {`${size}/${maxShuttleSize}`}
                  </ProgressBar>
                </Stack.Item>
              ) : undefined}
            </Stack>
          </Stack.Item>
          <Stack.Item>
            <Button.Confirm
              disabled={!onCustomShuttle || masterExists}
              tooltip={
                onCustomShuttle
                  ? masterExists
                    ? 'The master blueprint for this shuttle still exists. \
                          Whoever has it can copy it to this set of blueprints.'
                    : null
                  : 'Você deve estar em um transporte personalizado para fazer isso.'
              }
              onClick={() => act('tryLinkShuttle')}
            >
              Connect To Existing Shuttle
            </Button.Confirm>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

const ShuttleConfiguration = () => {
  const [name, setName] = useState('');
  const [mergeArea = { name: '', ref: '' }, setMergeArea] =
    useState<AreaData>();
  const { act, data } = useBackend<ShuttleBlueprintsData>();
  if (data.linkedShuttle === 0) {
    throw new Error('Tipo falha de guarda - ligado O ônibus deve ser não-zero.');
  }
  const {
    visualizing,
    onShuttleFrame,
    onShuttle,
    inDefaultArea,
    currentArea = { name: '', ref: '' },
    neighboringAreas = {},
    apcs = {},
    defaultApc,
    apcInMergeRegion,
    idle,
    isMaster,
    size,
    maxShuttleSize,
    problems,
  } = data;
  const { name: currentAreaName, ref: currentAreaRef } = currentArea;
  const { name: mergeAreaName, ref: mergeAreaRef } = mergeArea;
  const removalApcConflict = defaultApc && apcs[currentAreaRef];
  const mergeApcConflict = apcInMergeRegion && apcs[mergeAreaRef];
  const tooLarge = (size ?? 0) > maxShuttleSize;
  return (
    <Stack fill vertical align="center" justify="space-around">
      <Stack.Item textAlign="center">
        <h2>Current Area:</h2>
        <h3>
          {onShuttle
            ? inDefaultArea
              ? 'Área Predefinida'
              : currentAreaName
            : 'Não no ônibus.'}
        </h3>
      </Stack.Item>
      <Stack.Item>
        <Input fluid placeholder="Novo nome da área" onChange={setName} />
        <Stack>
          <Stack.Item>
            <Button.Confirm
              disabled={!(onShuttle && inDefaultArea)}
              tooltip={
                onShuttle
                  ? inDefaultArea
                    ? 'Designe um quarto dentro da nave como sua própria área.'
                    : 'Você só pode designar uma nova área da área padrão.'
                  : 'Você deve estar na nave ligada para fazer isso.'
              }
              onClick={() => act('createNewArea', { name: name })}
            >
              Designate New Area
            </Button.Confirm>
          </Stack.Item>
          <Stack.Item>
            <Button.Confirm
              disabled={!onShuttle || inDefaultArea}
              tooltip={
                onShuttle
                  ? inDefaultArea
                    ? 'Você não pode renomear a área padrão.'
                    : null
                  : 'Você deve estar na nave ligada para fazer isso.'
              }
              onClick={() => act('renameArea', { name: name })}
            >
              Rename Current Area
            </Button.Confirm>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item width="100%">
        <Stack fill justify="center">
          <Stack.Item>
            <Dropdown
              placeholder="Selecionar área"
              options={Object.entries(neighboringAreas).map(([ref, name]) => {
                return {
                  displayText: name,
                  value: ref,
                };
              })}
              selected={mergeAreaName}
              onSelected={(value) =>
                setMergeArea({ name: neighboringAreas[value], ref: value })
              }
            />
          </Stack.Item>
          <Stack.Item>
            <Button.Confirm
              disabled={
                !(onShuttle && inDefaultArea && mergeArea) || mergeApcConflict
              }
              tooltip={
                'Expanda a área selecionada com a seção conectada da área padrão.' +
                (onShuttle
                  ? mergeArea
                    ? inDefaultArea
                      ? mergeApcConflict
                        ? '\nTanto a área selecionada quanto a região que se expandiria para ter APCs. Você deve remover um primeiro.'
                        : ''
                      : '\nVocê só pode expandir a área selecionada para a área padrão.'
                    : ''
                  : '\nVocê deve estar na nave ligada para fazer isso.')
              }
              onClick={() => act('mergeIntoArea', { area: mergeAreaRef })}
            >
              Expand Area
            </Button.Confirm>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack vertical>
          <Stack.Item>
            <Stack>
              <Stack.Item>
                <Button.Confirm
                  disabled={!(idle && onShuttleFrame) || problems || tooLarge}
                  tooltip={
                    <ProblemsTooltip
                      description="Expanda a nave com uma estrutura adjacente."
                      problemHeader="Os seguintes problemas o impedem de expandir a nave auxiliar."
                      problems={problems ?? 0}
                      problemStrings={[
                        'Você deve estar na estrutura da nave que deseja expandir a nave.',
                        'Este quadro não é adjacente à nave conectada.',
                        'Este quadro é muito grande.',
                        'This frame includes the APC of a custom area, but does not enclose the entire area.\
                         Remove the APC or add the rest of the area to the frame.',
                        'Este quadro entra em uma área em que as naves não podem atracar.',
                        'Este quadro inclui um APC pertencente a uma área não-costume.',
                      ]}
                    />
                  }
                  onClick={() => act('expandWithFrame')}
                >
                  Expand Shuttle With Connected Frame
                </Button.Confirm>
              </Stack.Item>
              <Stack.Item>
                <VisualizationToggle visualizing={visualizing} />
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item>
            {onShuttleFrame ? (
              <Stack.Item>
                <ProgressBar
                  value={size}
                  maxValue={maxShuttleSize}
                  ranges={{
                    green: [0, maxShuttleSize * 0.5],
                    yellow: [maxShuttleSize * 0.5, maxShuttleSize * 0.75],
                    orange: [maxShuttleSize * 0.75, maxShuttleSize],
                    red: [maxShuttleSize, Infinity],
                  }}
                >
                  {`${size}/${maxShuttleSize}`}
                </ProgressBar>
              </Stack.Item>
            ) : undefined}
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Button.Confirm
          disabled={!onShuttle || inDefaultArea || removalApcConflict}
          tooltip={
            'Mesclar a área atual na área padrão.' +
            (onShuttle
              ? inDefaultArea
                ? '\nVocê já está na área padrão.'
                : removalApcConflict
                  ? '\nAs áreas atuais e padrão têm APCs. Você deve remover um primeiro.'
                  : ''
              : '\nVocê deve estar na nave ligada para fazer isso.')
          }
          onClick={() => act('releaseArea')}
        >
          Undesignate Area
        </Button.Confirm>
      </Stack.Item>
      <Stack.Item>
        <Button.Confirm
          disabled={!idle || !isMaster}
          tooltip={`Remove all empty space from the shuttle.${
            isMaster
              ? idle
                ? '\nThis will delete any areas left without any space, \
              and will decommission the shuttle entirely if there is nothing left of it.'
                : '\nA nave deve estar ociosa para fazer isso.'
              : '\nSó a planta principal pode fazer isso.'
          }`}
          onClick={() => act('cleanupEmptyTurfs')}
        >
          Clean Up Empty Space
        </Button.Confirm>
      </Stack.Item>
    </Stack>
  );
};

export const ShuttleBlueprints = (props) => {
  const { act, data } = useBackend<ShuttleBlueprintsData>();
  const { linkedShuttle, shuttles, masterExists, isMaster } = data;
  return (
    <Window width={450} height={340}>
      <Window.Content>
        <Section
          fill
          buttons={
            <>
              {shuttles && (
                <Dropdown
                  options={[
                    { displayText: 'None', value: 0 },
                    ...Object.entries(shuttles).map(
                      ([ref, name]: [string, string]) => {
                        return { displayText: name, value: ref };
                      },
                    ),
                  ]}
                  selected={linkedShuttle ? shuttles[linkedShuttle] : 'None'}
                  onSelected={(value) => {
                    if (value === 0) {
                      act('unsetShuttle');
                    } else {
                      act('switchShuttle', { ref: value });
                    }
                  }}
                />
              )}
              {!!linkedShuttle && !masterExists && !isMaster && (
                <Button.Confirm onClick={() => act('promoteToMaster')}>
                  Promote To Master Blueprint
                </Button.Confirm>
              )}
            </>
          }
        >
          {linkedShuttle ? <ShuttleConfiguration /> : <ShuttleConstruction />}
        </Section>
      </Window.Content>
    </Window>
  );
};
