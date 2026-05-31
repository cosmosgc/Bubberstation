import {
  Button,
  Input,
  LabeledList,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { AccessConfig, type Region } from './common/AccessConfig';

type Data = {
  accesses: string[];
  oneAccess: BooleanLike;
  passedCycleId: string;
  passedName: string;
  regions: Region[];
  shell: BooleanLike;
  unres_direction: number;
};

export function AirlockElectronics(props) {
  return (
    <Window width={420} height={485}>
      <Window.Content>
        <AirLockMainSection />
      </Window.Content>
    </Window>
  );
}

export function AirLockMainSection(props) {
  const { act, data } = useBackend<Data>();
  const {
    accesses = [],
    oneAccess,
    passedName,
    passedCycleId,
    regions = [],
    unres_direction,
    shell,
  } = data;

  return (
    <Stack fill vertical>
      <Stack.Item>
        <Section fill>
          <LabeledList>
            <LabeledList.Item label="Concha de circuito integrado">
              <Button.Checkbox
                checked={shell}
                onClick={() => {
                  act('set_shell', { on: !shell });
                }}
                tooltip="Se esta câmara de ar pode ter um circuito integrado dentro dela ou não."
              >
                Shell
              </Button.Checkbox>
            </LabeledList.Item>
            <LabeledList.Item label="Acesso Necessário">
              <Button
                icon={oneAccess ? 'unlock' : 'lock'}
                onClick={() => act('one_access')}
              >
                {oneAccess ? 'One' : 'All'}
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Acesso Livre">
              <Button
                icon={unres_direction & 1 ? 'check-square-o' : 'square-o'}
                selected={unres_direction & 1}
                onClick={() =>
                  act('direc_set', {
                    unres_direction: '1',
                  })
                }
              >
                North
              </Button>
              <Button
                icon={unres_direction & 2 ? 'check-square-o' : 'square-o'}
                selected={unres_direction & 2}
                onClick={() =>
                  act('direc_set', {
                    unres_direction: '2',
                  })
                }
              >
                South
              </Button>
              <Button
                icon={unres_direction & 4 ? 'check-square-o' : 'square-o'}
                selected={unres_direction & 4}
                onClick={() =>
                  act('direc_set', {
                    unres_direction: '4',
                  })
                }
              >
                East
              </Button>
              <Button
                icon={unres_direction & 8 ? 'check-square-o' : 'square-o'}
                selected={unres_direction & 8}
                onClick={() =>
                  act('direc_set', {
                    unres_direction: '8',
                  })
                }
              >
                West
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Nome da câmara de ar">
              <Input
                fluid
                maxLength={30}
                value={passedName}
                onBlur={(value) =>
                  act('passedName', {
                    passedName: value,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Ciclismo Id">
              <Input
                fluid
                maxLength={30}
                value={passedCycleId}
                onBlur={(value) =>
                  act('passedCycleId', {
                    passedCycleId: value,
                  })
                }
              />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
      <Stack.Item grow>
        <AccessConfig
          accesses={regions}
          selectedList={accesses}
          accessMod={(ref) =>
            act('set', {
              access: ref,
            })
          }
          grantAll={() => act('grant_all')}
          denyAll={() => act('clear_all')}
          grantDep={(ref) =>
            act('grant_region', {
              region: ref,
            })
          }
          denyDep={(ref) =>
            act('deny_region', {
              region: ref,
            })
          }
        />
      </Stack.Item>
    </Stack>
  );
}
