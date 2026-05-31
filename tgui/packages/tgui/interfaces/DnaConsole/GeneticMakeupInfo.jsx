import { LabeledList, Section } from 'tgui-core/components';

export const GeneticMakeupInfo = (props) => {
  const { makeup } = props;

  return (
    <Section title="Informação sobre enzimas">
      <LabeledList>
        <LabeledList.Item label="Name">
          {makeup.name || 'None'}
        </LabeledList.Item>
        <LabeledList.Item label="Tipo sanguíneo">
          {makeup.blood_type || 'None'}
        </LabeledList.Item>
        <LabeledList.Item label="Enzima Única">
          {makeup.UE || 'None'}
        </LabeledList.Item>
        <LabeledList.Item label="Identificador Único">
          {makeup.UI || 'None'}
        </LabeledList.Item>
        <LabeledList.Item label="Características únicas">
          {makeup.UF || 'None'}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
