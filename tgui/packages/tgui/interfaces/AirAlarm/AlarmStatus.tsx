import { LabeledList, Section } from 'tgui-core/components';

import { useBackend } from '../../backend';
import type { AirAlarmData } from './types';

const dangerMap = {
  0: {
    color: 'good',
    localStatusText: 'Optimal',
  },
  1: {
    color: 'average',
    localStatusText: 'Caution',
  },
  2: {
    color: 'bad',
    localStatusText: 'Perigo (Requeridos internos)',
  },
} as const;

const faultMap = {
  0: {
    color: 'good',
    areaFaultText: 'None',
  },
  1: {
    color: 'purple',
    areaFaultText: 'Trigger Manual',
  },
  2: {
    color: 'average',
    areaFaultText: 'Detecção automática',
  },
} as const;

export function AirAlarmStatus(props) {
  const { data } = useBackend<AirAlarmData>();
  const { envData } = data;

  const localStatus = dangerMap[data.dangerLevel] || dangerMap[0];
  const areaFault = faultMap[data.faultStatus] || faultMap[0];

  return (
    <Section title="Estado Aéreo">
      <LabeledList>
        {envData.length <= 0 ? (
          <LabeledList.Item label="Warning" color="bad">
            Cannot obtain air sample for analysis.
          </LabeledList.Item>
        ) : (
          <>
            {envData.map((entry) => {
              const status = dangerMap[entry.danger] || dangerMap[0];
              return (
                <LabeledList.Item
                  key={entry.name}
                  label={entry.name}
                  color={status.color}
                >
                  {entry.value}
                </LabeledList.Item>
              );
            })}
            <LabeledList.Item label="Status Local" color={localStatus.color}>
              {localStatus.localStatusText}
            </LabeledList.Item>
            <LabeledList.Item
              label="Status da área"
              color={data.atmosAlarm || data.fireAlarm ? 'bad' : 'good'}
            >
              {(data.atmosAlarm && 'Alarme de atmosfera') ||
                (data.fireAlarm && 'Alarme de Fogo') ||
                'Nominal'}
            </LabeledList.Item>
            <LabeledList.Item label="Status da falha" color={areaFault.color}>
              {areaFault.areaFaultText}
            </LabeledList.Item>
            <LabeledList.Item
              label="Localização da falha"
              color={data.faultLocation ? 'blue' : 'good'}
            >
              {data.faultLocation || 'None'}
            </LabeledList.Item>
          </>
        )}
        {!!data.emagged && (
          <LabeledList.Item label="Warning" color="bad">
            Safety measures offline. Device may exhibit abnormal behavior.
          </LabeledList.Item>
        )}
      </LabeledList>
    </Section>
  );
}
