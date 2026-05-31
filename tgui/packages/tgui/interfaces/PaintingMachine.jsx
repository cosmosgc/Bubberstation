import { Button, Dropdown, Section, Stack } from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';

export const PaintingMachine = (props) => {
  const { act, data } = useBackend();

  const { pdaTypes, cardTrims, hasPDA, pdaName, hasID, idName } = data;

  const [selectedPDA] = useSharedState(
    'pdaSelection',
    pdaTypes[Object.keys(pdaTypes)[0]],
  );

  const [selectedTrim] = useSharedState(
    'trimSelection',
    cardTrims[Object.keys(cardTrims)[0]],
  );

  return (
    <Window width={500} height={620}>
      <Window.Content scrollable>
        <Section
          title="PDA Painter"
          buttons={
            <>
              <Button.Confirm
                disabled={!hasPDA}
                content="Pinte PDA"
                confirmContent="Confirmado?"
                onClick={() =>
                  act('trim_pda', {
                    selection: selectedPDA,
                  })
                }
              />
              <Button.Confirm
                disabled={!hasPDA}
                content="Reset Imprint"
                confirmContent="Confirmado?"
                onClick={() => {
                  act('reset_pda');
                }}
              />
            </>
          }
        >
          <Stack vertical>
            <Stack.Item height="100%">
              <EjectButton
                name={pdaName || '-----'}
                onClickEject={() => act('eject_pda')}
              />
            </Stack.Item>
            <Stack.Item height="100%">
              <PainterDropdown stateKey="pdaSelection" options={pdaTypes} />
            </Stack.Item>
          </Stack>
        </Section>
        <Section
          title="ID Aparar Impressora"
          buttons={
            <>
              <Button.Confirm
                disabled={!hasID}
                content="Reiniciar conta de identificação"
                confirmContent="Confirmado?"
                onClick={() => act('reset_card')}
              />
              <Button.Confirm
                disabled={!hasID}
                content="Identifique-se."
                confirmContent="Confirmado?"
                onClick={(sel) =>
                  act('trim_card', {
                    selection: selectedTrim,
                  })
                }
              />
              <Button
                icon="question-circle"
                tooltip={
                  'Isso é destrutivo.' +
                  'e limpará todos os acessos no cartão.'
                }
                tooltipPosition="left"
              />
            </>
          }
        >
          <Stack vertical>
            <Stack.Item height="100%">
              <EjectButton
                name={idName || '-----'}
                onClickEject={() => act('eject_card')}
              />
            </Stack.Item>
            <Stack.Item height="100%">
              <PainterDropdown stateKey="trimSelection" options={cardTrims} />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};

export const EjectButton = (props) => {
  const { name, onClickEject } = props;

  return (
    <Button
      fluid
      ellipsis
      icon="eject"
      content={name}
      onClick={() => onClickEject()}
    />
  );
};

export const PainterDropdown = (props) => {
  const { stateKey, options } = props;

  const [selectedOption, setSelectedOption] = useSharedState(
    stateKey,
    options[Object.keys(options)[0]],
  );

  return (
    <Dropdown
      width="100%"
      selected={selectedOption}
      options={Object.keys(options).map((path) => {
        return options[path];
      })}
      onSelected={(sel) => setSelectedOption(sel)}
    />
  );
};
