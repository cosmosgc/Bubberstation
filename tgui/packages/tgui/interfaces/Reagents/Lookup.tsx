import { Button, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { ReagentLookup } from '../common/ReagentLookup';
import { RecipeLookup } from '../common/RecipeLookup';
import { bookmarkedReactions } from '.';
import type { ReagentsData } from './types';

export function Lookup() {
  const { act, data } = useBackend<ReagentsData>();
  const { beakerSync, reagent_mode_recipe, reagent_mode_reagent } = data;

  return (
    <Stack fill>
      <Stack.Item grow basis={0}>
        <Section
          title="Pesquisa de receitas"
          minWidth="353px"
          buttons={
            <>
              <Button
                icon="atom"
                color={beakerSync ? 'green' : 'red'}
                tooltip="Quando ativada, a reação exibida exibirá automaticamente reações contínuas no copo associado."
                onClick={() => act('beaker_sync')}
              >
                Beaker Sync
              </Button>
              <Button
                icon="search"
                color="purple"
                tooltip="Procure uma receita pelo nome do produto."
                onClick={() => act('search_recipe')}
              >
                Search
              </Button>
              <Button
                icon="times"
                color="red"
                disabled={!reagent_mode_recipe}
                onClick={() =>
                  act('recipe_click', {
                    id: null,
                  })
                }
              />
            </>
          }
        >
          <RecipeLookup
            recipe={reagent_mode_recipe}
            bookmarkedReactions={bookmarkedReactions}
          />
        </Section>
      </Stack.Item>
      <Stack.Item grow basis={0}>
        <Section
          title="Pesquisa de reagentes."
          minWidth="300px"
          buttons={
            <>
              <Button
                icon="search"
                tooltip="Procure um reagente pelo nome."
                tooltipPosition="left"
                onClick={() => act('search_reagents')}
              >
                Search
              </Button>
              <Button
                icon="times"
                color="red"
                disabled={!reagent_mode_reagent}
                onClick={() =>
                  act('reagent_click', {
                    id: null,
                  })
                }
              />
            </>
          }
        >
          <ReagentLookup reagent={reagent_mode_reagent} />
        </Section>
      </Stack.Item>
    </Stack>
  );
}
