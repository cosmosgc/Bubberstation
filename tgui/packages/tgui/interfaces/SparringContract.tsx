import { useState } from 'react';
import {
  BlockQuote,
  Button,
  Dropdown,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const weaponlist = [
  'Luta de Punho',
  'Armas Cerimoniais',
  'Apenas Melee.',
  'Qualquer arma.',
];

const stakelist = ['Sem Stakes.', 'Santo jogo.', 'Jogo de Dinheiro', 'Sua alma'];

const weaponblurb = [
  'Você vai lutar apenas com seus punhos. Qualquer arma será considerada uma violação.',
  'Você só pode lutar com armas cerimoniais. Você ficará em desvantagem sem uma!',
  'Pode lutar com armas ou punhos se não tiver nenhum. Armas rangedas são uma violação.',
  'Pode lutar com todas as armas que quiser. Tente não matá-los, certo?',
];

const stakesblurb = [
  "Sem apostas, só por diversão. Quem não gosta de treinos recreativos?",
  "Uma combinação para a divindade do capelão. O Capelão sofre grandes consequências para o fracasso, mas avança sua seita vencendo.",
  'Uma partida com dinheiro em jogo. Quem ganhar leva todo o dinheiro de quem perder.',
  "Uma luta letal com a alma do perdedor ficando sob a propriedade do vencedor.",
];

type Info = {
  set_weapon: number;
  set_area: string;
  set_stakes: number;
  left_sign: string;
  right_sign: string;
  in_area: BooleanLike;
  no_chaplains: BooleanLike;
  stakes_holy_match: number;
  possible_areas: Array<string>;
};

export const SparringContract = (props) => {
  const { data, act } = useBackend<Info>();
  const {
    set_weapon,
    set_area,
    set_stakes,
    possible_areas,
    left_sign,
    right_sign,
    in_area,
    no_chaplains,
    stakes_holy_match,
  } = data;
  const [weapon, setWeapon] = useState(set_weapon);
  const [area, setArea] = useState(set_area);
  const [stakes, setStakes] = useState(set_stakes);

  return (
    <Window width={420} height={380}>
      <Window.Content>
        <Section fill>
          <Stack vertical fill>
            <Stack.Item>
              <Stack vertical>
                <Stack.Item>
                  <Stack fill>
                    <Stack.Item grow fontSize="16px">
                      Weapons:
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        tooltip={`
                        The Chaplain's Deity wishes for honorable fighting.
                        As such, it uses contracts. Signing your name will
                        set the terms for the battle. Then, the person you
                        intend to spar with must sign the other side. If terms
                        are changed on an already signed contract, the
                        signatures will erase and the new terms must be
                        re-agreed upon.
                        `}
                        icon="info"
                      >
                        Contract?
                      </Button>
                    </Stack.Item>
                  </Stack>
                </Stack.Item>
                <Stack.Item>
                  <Dropdown
                    width="100%"
                    selected={weaponlist[weapon - 1]}
                    options={weaponlist}
                    onSelected={(value) =>
                      setWeapon(weaponlist.indexOf(value) + 1)
                    }
                  />
                </Stack.Item>
                <Stack.Item>
                  <BlockQuote>{weaponblurb[weapon - 1]}</BlockQuote>
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item>
              <Stack vertical>
                <Stack.Item fontSize="16px">Arena:</Stack.Item>
                <Stack.Item>
                  <Dropdown
                    width="100%"
                    selected={area}
                    options={possible_areas}
                    onSelected={(value) => setArea(value)}
                  />
                </Stack.Item>
                <Stack.Item>
                  <BlockQuote>
                    This fight will take place in the {area}. Leaving the arena
                    mid-fight is a violation.
                  </BlockQuote>
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item>
              <Stack vertical>
                <Stack.Item fontSize="16px">Stakes:</Stack.Item>
                <Stack.Item>
                  <Dropdown
                    width="100%"
                    selected={stakelist[stakes - 1]}
                    options={stakelist}
                    onSelected={(value) =>
                      setStakes(stakelist.indexOf(value) + 1)
                    }
                  />
                </Stack.Item>
                <Stack.Item>
                  <BlockQuote>{stakesblurb[stakes - 1]}</BlockQuote>
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item grow>
              <Stack textAlign="center">
                <Stack.Item fontSize={left_sign !== 'none' && '14px'} grow>
                  {(left_sign === 'none' && (
                    <Button
                      icon="pen"
                      onClick={() =>
                        act('sign', {
                          weapon: weapon,
                          area: area,
                          stakes: stakes,
                          sign_position: 'left',
                        })
                      }
                    >
                      Sign Here
                    </Button>
                  )) ||
                    left_sign}
                </Stack.Item>
                <Stack.Item fontSize="16px">VS</Stack.Item>
                <Stack.Item fontSize={right_sign !== 'none' && '14px'} grow>
                  {(right_sign === 'none' && (
                    <Button
                      icon="pen"
                      onClick={() =>
                        act('sign', {
                          weapon: weapon,
                          area: area,
                          stakes: stakes,
                        })
                      }
                    >
                      Sign Here
                    </Button>
                  )) ||
                    right_sign}
                </Stack.Item>
              </Stack>
            </Stack.Item>
            <Stack.Item mb={-0.5}>
              <Stack fill>
                <Stack.Item grow>
                  <Button
                    disabled={
                      !in_area ||
                      (no_chaplains && set_stakes === stakes_holy_match)
                    }
                    icon="fist-raised"
                    onClick={() => act('fight')}
                  >
                    FIGHT!
                  </Button>
                  <Button
                    tooltip={`
                      If you've already signed but you want to renegotiate
                      the terms, you can clear out the signatures with
                      this button.
                    `}
                    icon="door-open"
                    onClick={() => act('clear')}
                  >
                    Clear
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    tooltip={
                      (in_area &&
                        `Both participants are present in the ${area}.`) ||
                      'Amas os participantes precisam estar na arena!'
                    }
                    color={(in_area && 'green') || 'red'}
                    icon="ring"
                  >
                    Arena
                  </Button>
                  <Button
                    tooltip={
                      (left_sign !== 'none' &&
                        right_sign !== 'none' &&
                        'Ambas como assinatura presentes, termos acordados.') ||
                      'Você precisa de assinaturas de ambos os lutadores nos termos!'
                    }
                    color={
                      (left_sign !== 'none' &&
                        right_sign !== 'none' &&
                        'green') ||
                      'red'
                    }
                    icon="file-signature"
                  >
                    Signatures
                  </Button>
                  <Button
                    tooltip={
                      (!no_chaplains &&
                        'Pelo menos um capelão está presente. Santo jogo permitido.') ||
                      'Nenhum capelão presente nesta luta. Nada de Holy Matches!'
                    }
                    color={(!no_chaplains && 'green') || 'yellow'}
                    icon="cross"
                  >
                    Chaplain
                  </Button>
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
