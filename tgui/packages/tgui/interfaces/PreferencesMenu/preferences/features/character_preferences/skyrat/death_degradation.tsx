// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type Feature, FeatureNumberInput } from '../../base';

export const dc_starting_degradation: Feature<number> = {
  name: 'A Iniciar degradação',
  component: FeatureNumberInput,
  description: 'A degradação que você vai começar.',
};

export const dc_max_degradation: Feature<number> = {
  name: 'Degradação máxima',
  component: FeatureNumberInput,
  description: 'A degradação máxima absoluta que você pode ter.',
};

export const dc_living_degradation_recovery_per_second: Feature<number> = {
  name: 'Recuperar por segundo enquanto vivo',
  component: FeatureNumberInput,
  description:
    'Enquanto estiver vivo, sua degradação será reduzida a isso por segundo. Se negativo, isso o fará morrer lentamente.',
};

export const dc_dead_degradation_per_second: Feature<number> = {
  name: 'B Degradação por segundo enquanto morto',
  component: FeatureNumberInput,
};

export const dc_degradation_on_death: Feature<number> = {
  name: 'Degradação imediata na morte',
  component: FeatureNumberInput,
  description: 'Tem um resfriamento de cerca de 5 minutos entre as mortes.',
};

export const dc_stasis_dead_degradation_mult: Feature<number> = {
  name: 'B Stasis degradação mult',
  component: FeatureNumberInput,
  description:
    'Enquanto estiver em estase, qualquer degradação passiva que receber será reduzida por isso.',
};

export const dc_formeldahyde_dead_degradation_mult: Feature<number> = {
  name: 'Degradação da morte de Formeldehyde',
  component: FeatureNumberInput,
  description:
    'Se você é orgânico e tem formeldahyde em seu sistema, qualquer degradação passiva causada por estar morto será multiplicada contra isso.',
};

export const dc_rezadone_living_degradation_reduction: Feature<number> = {
  name: 'C Pure rezadone redução da degradação',
  component: FeatureNumberInput,
  description:
    'Se você é orgânico, vivo, e metabolizando Rezadona a 100% de pureza, você vai se recuperar passivamente da degradação a esta taxa por segundo.',
};

export const dc_eigenstasium_degradation_reduction: Feature<number> = {
  name: 'Redução da degradação do autoestásio',
  component: FeatureNumberInput,
  description:
    'Se você tem eigenstácio em seu sistema, você vai se recuperar passivamente da degradação a esta taxa por segundo. Isso funciona com sintéticos e mortos.',
};

export const dc_crit_threshold_reduction_min_percent_of_max: Feature<number> = {
  name: 'Crit limiar: começar degradação por cento',
  component: FeatureNumberInput,
  description:
    'O limiar de hematócrito começará a diminuir quando a degradação for este percentual ao máximo.',
};

export const dc_crit_threshold_reduction_percent_of_max: Feature<number> = {
  name: 'Limiar crítico:',
  component: FeatureNumberInput,
  description:
    'O limite do hematócrito vai parar de diminuir e atingir sua redução máxima quando a degradação for este percentual ao máximo.',
};

export const dc_max_crit_threshold_reduction: Feature<number> = {
  name: 'Limite máximo de redução.',
  component: FeatureNumberInput,
  description:
    'When at the ending degradation percent, crit threshold will be reduced by this, \
	    with lower percentages causing equally displaced reducions, such as having 50% degradation causing 50% of this to be applied.',
};

export const dc_stamina_damage_min_percent_of_max: Feature<number> = {
  name: 'Danos na resistência:',
  component: FeatureNumberInput,
  description:
    'Dano mínimo de resistência começará a aumentar quando a degradação atingir este percentual de degradação máxima.',
};

export const dc_stamina_damage_percent_of_max: Feature<number> = {
  name: 'Dano de resistência:',
  component: FeatureNumberInput,
  description:
    'Dano mínimo de resistência atingirá seu valor máximo possível quando a degradação atingir esse percentual de degradação máxima.',
};

export const dc_max_stamina_damage: Feature<number> = {
  name: 'Danos de resistência:',
  component: FeatureNumberInput,
  description:
    'When at the ending degradation percent, your stamina damage will always be at LEAST this, \
        with lower percentages causing equally displaced minimums, such as having 50% degradation with 80 max stamina damage causing a minimum of 40 damage.',
};

export const dc_permakill_at_max: Feature<boolean> = {
  name: 'Permaghost na degradação máxima.',
  component: CheckboxInput,
  description:
    'Se for verdade, você será permanentemente assombrado se sua degradação atingir seu valor máximo possível.',
};

export const dc_force_death_if_permakilled: Feature<boolean> = {
  name: 'Forçar a morte se for permagostada',
  component: CheckboxInput,
  description: 'Se for verdade, você será morto permanentemente em Permaghost também.',
};
