// THIS IS A SKYRAT UI FILE
import {
  CheckboxInput,
  type Feature,
  type FeatureChoiced,
  type FeatureChoicedServerData,
  FeatureColorInput,
  FeatureNumberInput,
  FeatureShortTextInput,
  FeatureTextInput,
  type FeatureToggle,
  FeatureTriBoolInput,
  FeatureTriColorInput,
  type FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const feature_leg_type: FeatureChoiced = {
  name: 'Tipo de perna',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_mcolor2: Feature<string> = {
  name: 'Cor mutante 2',
  component: FeatureColorInput,
};
export const feature_mcolor3: Feature<string> = {
  name: 'Cor mutante 3',
  component: FeatureColorInput,
};

export const flavor_text: Feature<string> = {
  name: 'Texto Sabor',
  description:
    'Aparece quando examinado, fornece uma descrição visual com personalidade, permitindo que outros personagens formem sua primeira impressão de você. Procure ajuda nos guias wiki.',
  component: FeatureTextInput,
};

export const silicon_flavor_text: Feature<string> = {
  name: 'Texto de sabor de silicone',
  description: "Mas aparece quando se joga como borg ou IA.",
  component: FeatureTextInput,
};

export const ooc_notes: Feature<string> = {
  name: 'Notas OOC',
  description:
    'Cobre suas preferências sexuais, informações sobre você, referências de arte e outros detalhes. Aqui, você se apresenta, ao invés de seu personagem.',
  component: FeatureTextInput,
};

export const custom_species: Feature<string> = {
  name: 'Nome da espécie personalizada',
  description:
    'O nome da sua espécie personalizada. Se ficar em branco, você usará o nome da espécie selecionada (por exemplo, Humano, Lagarto).',
  component: FeatureShortTextInput,
};

export const custom_species_lore: Feature<string> = {
  name: 'Espécies personalizadas Lore',
  description:
    "A tradição para sua espécie personalizada, se você não estiver usando a tradição do servidor. Deixe em branco para usar a lenda para sua espécie selecionada.",
  component: FeatureTextInput,
};

export const custom_taste: Feature<string> = {
  name: 'Sabor de Caracteres',
  description: 'Qual é o gosto do seu personagem quando lambido?',
  component: FeatureShortTextInput,
};

export const custom_smell: Feature<string> = {
  name: 'Fedor de Personagem',
  description: 'Qual é o cheiro do seu personagem quando cheira?',
  component: FeatureShortTextInput,
};

export const general_record: Feature<string> = {
  name: 'Registros - General',
  description:
    'The first part of any record that describes you. \
    For a quick description, your languages and origin, and birthday.',
  component: FeatureTextInput,
};

export const security_record: Feature<string> = {
  name: 'Registros - Segurança',
  description:
    'Privileged information accessible by Security, Command and the NTC. \
    Used to throw these roles a bone, and give more information to work with. \
    For employment and criminal history, loyalties and exploitable tidbits, and more.',
  component: FeatureTextInput,
};

export const medical_record: Feature<string> = {
  name: 'Registros - Médicos',
  description:
    'Viewable with medical access. \
  For things like medical history, prescriptions, DNR orders, etc.',
  component: FeatureTextInput,
};

export const exploitable_info: Feature<string> = {
  name: 'Registros - Explorable',
  description:
    'Can be IC or OOC. Viewable by certain antagonists/OPFOR users, as well as ghosts. Generally contains \
  things like weaknesses, strengths, important background, trigger words, etc. It ALSO may contain things like \
  antagonist preferences, e.g. if you want to be antagonized, by whom, with what, etc.',
  component: FeatureTextInput,
};

export const background_info: Feature<string> = {
  name: 'Registros - Fundo',
  description:
    'Só vê-lo sozinho e fantasmas. Você pode ter o que quiser aqui. Pode ser valioso como uma forma de se orientar para o seu caráter.',
  component: FeatureTextInput,
};

export const pda_ringer: Feature<string> = {
  name: 'Mensagem PDA Ringer',
  description:
    'Quer que seu PDA diga algo além de "bip"? Aceita os primeiros 20 caracteres.',
  component: FeatureShortTextInput,
};

export const allow_mismatched_parts_toggle: FeatureToggle = {
  name: 'Permitindo partes desiguais.',
  description: 'Permite que partes de qualquer espécie sejam escolhidas.',
  component: CheckboxInput,
};

export const allow_mismatched_hair_color_toggle: FeatureToggle = {
  name: 'Deixe a cor do cabelo desfigurada',
  description:
    'Permite que espécies que normalmente têm uma cor de cabelo fixa tenham cores diferentes. Isso inclui fontes redondas, como tingir cabelo, alterar forma, etc. Atualmente só é aplicável a lodo.',
  component: CheckboxInput,
};

export const allow_genitals_toggle: FeatureToggle = {
  name: 'Permitir peças genitais.',
  description: 'Permite se você quiser ter genitais em seu caráter.',
  component: CheckboxInput,
};

export const allow_emissives_toggle: FeatureToggle = {
  name: 'Permita Emissários.',
  description: 'Partes emissivas brilham no escuro.',
  component: CheckboxInput,
};

export const eye_emissives: FeatureToggle = {
  name: 'Emissários Olhos',
  description: 'Partes emissivas brilham no escuro.',
  component: CheckboxInput,
};

export const eyes_opacity: Feature<number> = {
  name: 'Opacidade dos olhos',
  component: FeatureNumberInput,
};

export const mutant_colors_color: Feature<string[]> = {
  name: 'Cores Mutantes',
  component: FeatureTriColorInput,
  description: 'Cor do corpo usada para espécies não humanas.',
};

export const body_markings_toggle: FeatureToggle = {
  name: 'Marcações do corpo',
  component: CheckboxInput,
};

export const feature_body_markings: Feature<string> = {
  name: 'Seleção de Marcas Corporais',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const body_markings_color: Feature<string[]> = {
  name: 'Marcações Corporais Cores',
  component: FeatureTriColorInput,
};

export const body_markings_emissive: Feature<boolean[]> = {
  name: 'Marcas Corporais Emissivas',
  component: FeatureTriBoolInput,
};

export const tail_toggle: FeatureToggle = {
  name: 'Tail',
  component: CheckboxInput,
};

export const feature_tail: Feature<string> = {
  name: 'Seleção da cauda',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const tail_color: Feature<string[]> = {
  name: 'Cores da cauda',
  component: FeatureTriColorInput,
};

export const tail_emissive: Feature<boolean[]> = {
  name: 'Emissários de cauda',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const snout_toggle: FeatureToggle = {
  name: 'Snout',
  component: CheckboxInput,
};

export const feature_snout: Feature<string> = {
  name: 'Snout Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const snout_color: Feature<string[]> = {
  name: 'Cores de focinho',
  component: FeatureTriColorInput,
};

export const snout_emissive: Feature<boolean[]> = {
  name: 'Snout Emissives',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const horns_toggle: FeatureToggle = {
  name: 'Horns',
  component: CheckboxInput,
};

export const feature_horns: Feature<string> = {
  name: 'Seleção de Cornos',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const horns_color: Feature<string[]> = {
  name: 'Cornos Cores',
  component: FeatureTriColorInput,
};

export const horns_emissive: Feature<boolean[]> = {
  name: 'Emissários de Cornos',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const ears_toggle: FeatureToggle = {
  name: 'Ears',
  component: CheckboxInput,
};

export const feature_ears: Feature<string> = {
  name: 'Seleção de Ouvidos',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ears_color: Feature<string[]> = {
  name: 'Cores dos Ouvidos',
  component: FeatureTriColorInput,
};

export const ears_emissive: Feature<boolean[]> = {
  name: 'Orelhas Emissivas',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const quad_eyes: FeatureToggle = {
  name: 'Quad Eyes',
  description:
    'Dá ao personagem quatro olhos, pode ter algumas esquisitices com olhos personalizados.',
  component: CheckboxInput,
};

export const quad_eyes_offset: Feature<number> = {
  name: 'Quad Eyes Offset',
  component: FeatureNumberInput,
};

export const quad_eyes_offset_width: Feature<number> = {
  name: 'Quad Eyes Offset Largura',
  component: FeatureNumberInput,
};

export const wings_toggle: FeatureToggle = {
  name: 'Wings',
  component: CheckboxInput,
};

export const feature_wings: Feature<string> = {
  name: 'Selecção de Asas',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const wings_color: Feature<string[]> = {
  name: 'Asas Cores',
  component: FeatureTriColorInput,
};

export const wings_emissive: Feature<boolean[]> = {
  name: 'Asas Emissivas',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const frills_toggle: FeatureToggle = {
  name: 'Frills',
  component: CheckboxInput,
};

export const feature_frills: Feature<string> = {
  name: 'Frills Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const frills_color: Feature<string[]> = {
  name: 'Cores de Frills',
  component: FeatureTriColorInput,
};

export const frills_emissive: Feature<boolean[]> = {
  name: 'Emissários de Frills',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const spines_toggle: FeatureToggle = {
  name: 'Spines',
  component: CheckboxInput,
};

export const feature_spines: Feature<string> = {
  name: 'Seleção de Espinhos',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const spines_color: Feature<string[]> = {
  name: 'Cor das Espinas',
  component: FeatureTriColorInput,
};

export const spines_emissive: Feature<boolean[]> = {
  name: 'Espinhos Emissivos',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const digitigrade_legs: FeatureChoiced = {
  name: 'Legs',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const caps_toggle: FeatureToggle = {
  name: 'Cap',
  component: CheckboxInput,
};

export const feature_caps: Feature<string> = {
  name: 'Cap Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const caps_color: Feature<string[]> = {
  name: 'Cores do Cap',
  component: FeatureTriColorInput,
};

export const caps_emissive: Feature<boolean[]> = {
  name: 'Caps Emissives',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const moth_antennae_toggle: FeatureToggle = {
  name: 'Antena de traça',
  component: CheckboxInput,
};

export const feature_moth_antennae: Feature<string> = {
  name: 'Selecção de Antena de Malha',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const moth_antennae_color: Feature<string[]> = {
  name: 'Cor da antena de traça',
  component: FeatureTriColorInput,
};

export const moth_antennae_emissive: Feature<boolean[]> = {
  name: 'Emissores de antena de mariposa',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const moth_markings_toggle: FeatureToggle = {
  name: 'Marcações de traças',
  component: CheckboxInput,
};

export const feature_moth_markings: Feature<string> = {
  name: 'Selecção de Marcas de Traças',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const moth_markings_color: Feature<string[]> = {
  name: 'Marcas de traça Cores',
  component: FeatureTriColorInput,
};

export const moth_markings_emissive: Feature<boolean[]> = {
  name: 'Marcas de traça Emissivas',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const fluff_toggle: FeatureToggle = {
  name: 'Fluff',
  component: CheckboxInput,
};

export const feature_fluff: Feature<string> = {
  name: 'Selecção de Fluff',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const fluff_color: Feature<string[]> = {
  name: 'Cores Fluff',
  component: FeatureTriColorInput,
};

export const fluff_emissive: Feature<boolean[]> = {
  name: 'Emissores de Fluff',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const head_acc_toggle: FeatureToggle = {
  name: 'Acessórios de cabeça',
  component: CheckboxInput,
};

export const feature_head_acc: Feature<string> = {
  name: 'Seleção de acessórios de cabeça',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const head_acc_color: Feature<string[]> = {
  name: 'Cores dos acessórios da cabeça',
  component: FeatureTriColorInput,
};

export const head_acc_emissive: Feature<boolean[]> = {
  name: 'Emissores de acessórios de cabeça',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const feature_ipc_screen: Feature<string> = {
  name: 'Seleção de Tela IPC',
  description: 'Pode ser mudado em volta.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ipc_screen_color: Feature<string> = {
  name: 'Cor da tela do IPC Greyscale',
  component: FeatureColorInput,
};

export const ipc_screen_emissive: Feature<boolean> = {
  name: 'Emissor de tela IPC',
  description: 'Partes emissivas brilham no escuro.',
  component: CheckboxInput,
};

export const ipc_antenna_toggle: FeatureToggle = {
  name: 'Synth Antenna',
  component: CheckboxInput,
};

export const feature_ipc_antenna: Feature<string> = {
  name: 'Synth Antenna Seleção',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ipc_antenna_color: Feature<string[]> = {
  name: 'Cores da antena sintética',
  component: FeatureTriColorInput,
};

export const ipc_antenna_emissive: Feature<boolean[]> = {
  name: 'Synth Antenna Emissives',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const feature_ipc_chassis: Feature<string> = {
  name: 'Synth Chassis Selection',
  description: 'Só funciona para sintéticos.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ipc_chassis_color: Feature<string> = {
  name: 'Synth Chassis Colors',
  description:
    'Só funciona para sintéticos e chassis que suportam coloração em escala de cinza.',
  component: FeatureColorInput,
};

export const feature_ipc_head: Feature<string> = {
  name: 'Synth Head Selection',
  description: 'Só trabalha para sintéticos.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ipc_head_color: Feature<string> = {
  name: 'Cores da cabeça sintética',
  component: FeatureColorInput,
};

export const feature_hair_opacity_toggle: Feature<boolean> = {
  name: 'Opacidade do cabelo Sobrecarregar',
  component: CheckboxInput,
};

export const feature_hair_opacity: Feature<number> = {
  name: 'Opacidade do cabelo',
  component: FeatureNumberInput,
};

export const neck_acc_toggle: FeatureToggle = {
  name: 'Acessórios de pescoço',
  component: CheckboxInput,
};

export const feature_neck_acc: Feature<string> = {
  name: 'Selecção de Acessórios de Pescoço',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const neck_acc_color: Feature<string[]> = {
  name: 'Neck Acessórios Cores',
  component: FeatureTriColorInput,
};

export const neck_acc_emissive: Feature<boolean[]> = {
  name: 'Acessórios do pescoço Emissivos',
  component: FeatureTriBoolInput,
};

export const skrell_hair_toggle: FeatureToggle = {
  name: 'Cabelo Skrell',
  component: CheckboxInput,
};

export const feature_skrell_hair: Feature<string> = {
  name: 'Selecção de Cabelo Skrell',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const skrell_hair_color: Feature<string[]> = {
  name: 'Cores de cabelo Skrell',
  component: FeatureTriColorInput,
};

export const skrell_hair_emissive: Feature<boolean[]> = {
  name: 'Emissários de Cabelo Skrell',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const taur_toggle: FeatureToggle = {
  name: 'Taur',
  component: CheckboxInput,
};

export const feature_taur: Feature<string> = {
  name: 'Selecção Taur',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const taur_color: Feature<string[]> = {
  name: 'Cores Taur',
  component: FeatureTriColorInput,
};

export const taur_emissive: Feature<boolean[]> = {
  name: 'Emissários Taur',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const naga_sole: FeatureToggle = {
  name: 'Taur (Naga) desativar solas endurecidas',
  description:
    'Se usar um taur corpo serpentina, determina se você é imune a caltrops e alguns outros efeitos de estar descalço.',
  component: CheckboxInput,
};

export const synthetic_taur: FeatureToggle = {
  name: 'Taur (Sintético)',
  description:
    "Se usar um corpo taur, determina se o corpo taur é sintético, não se aplica a corpos taur que já são sintéticos.",
  component: CheckboxInput,
};

export const xenodorsal_toggle: FeatureToggle = {
  name: 'Xenodorsal',
  component: CheckboxInput,
};

export const feature_xenodorsal: Feature<string> = {
  name: 'Seleção Xenodorsal',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const xenodorsal_color: Feature<string[]> = {
  name: 'Cores Xenodorsal',
  component: FeatureTriColorInput,
};

export const xenodorsal_emissive: Feature<boolean[]> = {
  name: 'Emissários Xenodorsal',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const xenohead_toggle: FeatureToggle = {
  name: 'Xeno Head.',
  component: CheckboxInput,
};

export const feature_xenohead: Feature<string> = {
  name: 'Xeno Head Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const xenohead_color: Feature<string[]> = {
  name: 'Xeno Head Colors',
  component: FeatureTriColorInput,
};

export const xenohead_emissive: Feature<boolean[]> = {
  name: 'Xeno Chefe Emissários',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const undershirt_color: Feature<string> = {
  name: 'Cor da camisa.',
  component: FeatureColorInput,
};

export const socks_color: Feature<string> = {
  name: 'Cor das meias',
  component: FeatureColorInput,
};

export const heterochromia_toggle: FeatureToggle = {
  name: 'Heterochromia',
  component: CheckboxInput,
};

export const feature_heterochromia: Feature<string> = {
  name: 'Seleção de heterocromia',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const heterochromia_color: Feature<string[]> = {
  name: 'Cores de heterocromia',
  component: FeatureTriColorInput,
};

export const heterochromia_emissive: Feature<boolean[]> = {
  name: 'Emissores de heterocromia',
  description: 'Partes emissivas brilham no escuro.',
  component: FeatureTriBoolInput,
};

export const vox_bodycolor: Feature<string> = {
  name: 'Vox Bodycolor',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const pod_hair_color: Feature<string[]> = {
  name: 'Cor floral do cabelo',
  component: FeatureTriColorInput,
};

export const pod_hair_emissive: Feature<boolean> = {
  name: 'Emissora de Cabelo Floral',
  description: 'Partes emissivas brilham no escuro.',
  component: CheckboxInput,
};
