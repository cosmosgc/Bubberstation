import { DmIcon, Icon } from 'tgui-core/components';

import { JOB2ICON } from '../common/JobToIcon';
import type { Antagonist, Observable } from './types';

// BUBBER EDIT ADDITION BEGIN - Custom observe menu icons
const customJobs = [
  'Especialista em Telecomms',
  'Barber',
  'Blueshield',
  'Bouncer',
  'Oficial de Correções.',
  'Agente da Alfândega',
  'Guarda de Engenharia.',
  'Consultor Nanotrasen',
  'Orderly',
  'Guarda da Ciência',
  'Médico de Segurança',
  'Persistência Refém',
  'Persistência do Estado Maior',
  'Técnico de Saneamento de Persistência',
  'Pesquisador de Persistência',
  'Diretor de Engenharia de Persistência',
  'Oficial Médico Persistência',
  'Persistência Técnico de Carga',
  'Mestre de Persistência em Armas',
  'Oficial de Persistência',
  'Sindicate Corporate Liaison',
  'Persistência Almirante',
  'Alferes Tarkon',
];
// BUBBER EDIT ADDITION END - Custom observe menu icons

type Props = {
  item: Observable | Antagonist;
  realNameDisplay: boolean;
};

type IconSettings = {
  dmi: string;
  transform: string;
};

const normalIcon: IconSettings = {
  dmi: 'icons/mob/huds/hud.dmi',
  transform: 'Escala(2,3) traduzX(9px) traduzY(1px)',
};

const antagIcon: IconSettings = {
  dmi: 'icons/mob/huds/antag_hud.dmi',
  transform: 'Tradução:',
};

// BUBBER EDIT ADDITION BEGIN - Custom observe menu icons
const customIcon: IconSettings = {
  dmi: 'modular_zubbers/icons/mob/huds/hud.dmi',
  transform: 'Escala(2,3) traduzX(9px) traduzY(1px)',
};
// BUBBER EDIT ADDITION END - Custom observe menu icons

export function JobIcon(props: Props) {
  const { item, realNameDisplay } = props;

  // We don't need to cast here but typescript isn't smart enough to know that
  const { icon = '', job = '', mind_icon = '', mind_job = '' } = item;
  let usedIcon = realNameDisplay ? mind_icon || icon : icon;
  let usedJob = realNameDisplay ? mind_job || job : job;

  let iconSettings: IconSettings;
  if ('antag' in item && !realNameDisplay) {
    iconSettings = antagIcon;
    usedJob = item.antag;
    usedIcon = item.antag_icon;
    // BUBBER EDIT ADDITION BEGIN - Custom observe menu icons
  } else if (customJobs.includes(usedJob)) {
    iconSettings = customIcon;
    // BUBBER EDIT ADDITION END - Custom observe menu icons
  } else {
    iconSettings = normalIcon;
  }

  return (
    <div className="JobIcon">
      {icon === 'borg' ? (
        <Icon color="lightblue" name={JOB2ICON[usedJob]} ml={0.3} mt={0.4} />
      ) : (
        <DmIcon
          icon={iconSettings.dmi}
          icon_state={usedIcon}
          style={{
            transform: iconSettings.transform,
          }}
        />
      )}
    </div>
  );
}
