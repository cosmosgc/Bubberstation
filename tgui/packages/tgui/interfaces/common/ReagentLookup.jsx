import { Box, Button, Icon, LabeledList } from 'tgui-core/components';

import { useBackend } from '../../backend';

export const ReagentLookup = (props) => {
  const { reagent } = props;
  const { act } = useBackend();
  if (!reagent) {
    return <Box>No reagent selected!</Box>;
  }

  return (
    <LabeledList>
      <LabeledList.Item label="Reagent">
        <Icon name="circle" mr={1} color={reagent.reagentCol} />
        {reagent.name}
        <Button
          ml={1}
          icon="wifi"
          color="teal"
          tooltip="Abra a página associada para este reagente."
          tooltipPosition="left"
          onClick={() => {
            Byond.command(`wiki Guide_to_chemistry#${reagent.name}`);
          }}
        />
      </LabeledList.Item>
      <LabeledList.Item label="Description">{reagent.desc}</LabeledList.Item>
      <LabeledList.Item label="pH">
        <Icon name="circle" mr={1} color={reagent.pHCol} />
        {reagent.pH}
      </LabeledList.Item>
      <LabeledList.Item label="Properties">
        <LabeledList>
          {!!reagent.OD && (
            <LabeledList.Item label="Overdose">{reagent.OD}u</LabeledList.Item>
          )}
          {reagent.addictions[0] && (
            <LabeledList.Item label="Addiction">
              {reagent.addictions.map((addiction) => (
                <Box key={addiction}>{addiction}</Box>
              ))}
            </LabeledList.Item>
          )}
          <LabeledList.Item label="Taxa de metabolização">
            {reagent.metaRate}u/s
          </LabeledList.Item>
        </LabeledList>
      </LabeledList.Item>
      <LabeledList.Item label="Impurities">
        <LabeledList>
          {reagent.impureReagent && (
            <LabeledList.Item label="Reage impuro.">
              <Button
                icon="vial"
                tooltip="Este reagente se converterá parcialmente nisso quando a pureza estiver acima da pureza inversa no consumo."
                tooltipPosition="left"
                content={reagent.impureReagent}
                onClick={() =>
                  act('reagent_click', {
                    id: reagent.impureId,
                  })
                }
              />
            </LabeledList.Item>
          )}
          {reagent.inverseReagent && (
            <LabeledList.Item label="Reagente inverso.">
              <Button
                icon="vial"
                content={reagent.inverseReagent}
                tooltip="Este reagente se converterá nisso quando a pureza estiver abaixo da pureza inversa no consumo."
                tooltipPosition="left"
                onClick={() =>
                  act('reagent_click', {
                    id: reagent.inverseId,
                  })
                }
              />
            </LabeledList.Item>
          )}
          {reagent.failedReagent && (
            <LabeledList.Item label="Reage Falhado.">
              <Button
                icon="vial"
                tooltip="Este reagente vai se transformar nisso se a pureza da reação estiver abaixo da pureza mínima na conclusão."
                tooltipPosition="left"
                content={reagent.failedReagent}
                onClick={() =>
                  act('reagent_click', {
                    id: reagent.failedId,
                  })
                }
              />
            </LabeledList.Item>
          )}
        </LabeledList>
        {reagent.isImpure && <Box>This reagent is created by impurity.</Box>}
        {reagent.deadProcess && <Box>This reagent works on the dead.</Box>}
        {!reagent.failedReagent &&
          !reagent.inverseReagent &&
          !reagent.impureReagent && (
            <Box>This reagent has no impure reagents.</Box>
          )}
      </LabeledList.Item>
      <LabeledList.Item>
        <Button
          icon="flask"
          mt={2}
          content={'Encontre a reação associada.'}
          color="purple"
          onClick={() =>
            act('find_reagent_reaction', {
              id: reagent.id,
            })
          }
        />
      </LabeledList.Item>
    </LabeledList>
  );
};
