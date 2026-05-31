// THIS IS A SKYRAT UI FILE
import {
  CheckboxInput,
  type FeatureChoiced,
  type FeatureToggle,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const master_erp_pref: FeatureToggle = {
  name: 'Mostrar/Ocultar Preferências de Representação Erótica',
  category: 'ERP',
  description: 'Isso mostra preferências ERP.',
  component: CheckboxInput,
};

export const erp_pref: FeatureToggle = {
  name: 'Interação erótica de representação',
  category: 'ERP',
  description: 'Isso informa os jogadores de se você deseja se envolver em ERP.',
  component: CheckboxInput,
};

export const erp_sounds_pref: FeatureToggle = {
  name: 'Filhos ERP',
  category: 'ERP',
  description: 'Se quiser ouvir sons da mecânica ERP.',
  component: CheckboxInput,
};

export const bimbofication_pref: FeatureToggle = {
  name: 'Bimbofication',
  category: 'ERP',
  description:
    'Se você for capaz de reagir aos efeitos da bimboficação.',
  component: CheckboxInput,
};

export const aphro_pref: FeatureToggle = {
  name: 'Aphrodisiacs',
  category: 'ERP',
  description:
    'Comuta se deseja receber os efeitos dos afrodisíacos.',
  component: CheckboxInput,
};

export const sextoy_pref: FeatureToggle = {
  name: 'Brinquedo sexual',
  category: 'ERP',
  description: 'Quando habilitado, você será capaz de interagir com brinquedos sexuais.',
  component: CheckboxInput,
};

export const sextoy_sounds_pref: FeatureToggle = {
  name: 'Filhos de Brinquedo sexual',
  category: 'ERP',
  description: 'Se você ouvir sons de brinquedos sexuais.',
  component: CheckboxInput,
};

export const vore_enable_pref: FeatureToggle = {
  name: 'Activar Vore Mecânico',
  category: 'ERP',
  description: 'Se você puder usar mecânica vore.',
  component: CheckboxInput,
};

// BUBBER EDIT START: MECHANICAL HYPNOSIS PREF
export const hypnosis_pref: FeatureToggle = {
  name: 'Hypnosis',
  category: 'ERP',
  description:
    'Determina se você deseja permitir hipnose/hipnose química de forma obscena.',
  component: CheckboxInput,
};
// BUBBER EDIT END

export const breast_enlargement_pref: FeatureToggle = {
  name: 'Aumento do peito',
  category: 'ERP',
  description:
    'Determina se você deseja receber os efeitos dos produtos químicos da ampliação do peito.',
  component: CheckboxInput,
};

export const breast_shrinkage_pref: FeatureToggle = {
  name: 'Retração dos seios',
  category: 'ERP',
  description:
    'Determina se deseja receber os efeitos de produtos químicos de encolhimento de seios.',
  component: CheckboxInput,
};

export const breast_removal_pref: FeatureToggle = {
  name: 'Retração completa dos seios',
  category: 'ERP',
  description:
    'Determina se você deseja receber todos os efeitos de produtos químicos de encolhimento de seios.',
  component: CheckboxInput,
};

export const penis_enlargement_pref: FeatureToggle = {
  name: 'Aumento do pênis',
  category: 'ERP',
  description:
    'Determina se você deseja receber os efeitos de produtos químicos da ampliação do pênis.',
  component: CheckboxInput,
};

export const penis_shrinkage_pref: FeatureToggle = {
  name: 'Retração do pênis',
  category: 'ERP',
  description:
    'Determina se você deseja receber os efeitos de produtos químicos de encolhimento do pênis.',
  component: CheckboxInput,
};

export const gender_change_pref: FeatureToggle = {
  name: 'Mudança de gênero forçada',
  category: 'ERP',
  description: 'Determina se você deseja permitir que o sexo forçado mude.',
  component: CheckboxInput,
};

export const autocum_pref: FeatureToggle = {
  name: 'Autocum',
  category: 'ERP',
  description:
    'Comuta se você automaticamente goza usando o sistema de excitação, ou se precisar fazer manualmente.',
  component: CheckboxInput,
};

export const autoemote_pref: FeatureToggle = {
  name: 'Auto Emote',
  category: 'ERP',
  description:
    'Comuta se você emote automaticamente usando o sistema de excitação, ou se você precisa fazê-lo manualmente.',
  component: CheckboxInput,
};

export const erp_sexuality_pref: FeatureChoiced = {
  name: 'Preferência de sexualidade',
  category: 'ERP',
  description:
    'Determina o conteúdo sexual que vê, uso limitado. Nenhum mostrará todo o conteúdo.',
  component: FeatureDropdownInput,
};

export const genitalia_removal_pref: FeatureToggle = {
  name: 'Remoção ERP Genitalia',
  category: 'ERP',
  description:
    'Se marcada, permite que as drogas removam a genitália existente em seu personagem.',
  component: CheckboxInput,
};

export const new_genitalia_growth_pref: FeatureToggle = {
  name: 'ERP Nova Genitália Crescimento',
  category: 'ERP',
  description:
    'Se marcada, permite que as drogas cresçam novos genitais em seu caráter.',
  component: CheckboxInput,
};

export const vore_overlays: FeatureToggle = {
  name: 'Vore Overlays',
  category: 'ERP',
  description:
    'Quando estiver habilitado, você será exibido em tela cheia sobrepostos enquanto estiver dentro de um caça-almas?',
  component: CheckboxInput,
};

export const vore_overlay_options: FeatureToggle = {
  name: 'Opções de Sobreposição Vore',
  category: 'ERP',
  description:
    'Você quer ver overlays fullscreen vore como uma opção para o soulcatcher overlays?',
  component: CheckboxInput,
};
