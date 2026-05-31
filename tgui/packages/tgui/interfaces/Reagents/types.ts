import type { Dispatch, SetStateAction } from 'react';
import type { BooleanLike } from 'tgui-core/react';

export type ReagentsData = {
  beakerSync: BooleanLike;
  bitflags: Record<string, number>;
  currentReagents: string[];
  linkedBeaker: string;
  master_reaction_list: Reaction[];
  reagent_mode_reagent: Reagent | null;
  reagent_mode_recipe: Recipe | null;
  selectedBitflags: number;
};

export type ReagentsProps = {
  pageState: [number, Dispatch<SetStateAction<number>>];
};

type Pairs = [
  [number, number],
  [number, number],
  [number, number],
  [number, number],
];

export type Recipe = {
  catalysts: Reagent[];
  explodeTemp: number;
  explosive: Pairs;
  hasProduct: BooleanLike;
  id: string;
  inversePurity: string;
  isColdRecipe: BooleanLike;
  lowerpH: number;
  minPurity: number;
  name: string;
  reactants: Reactant[];
  reagentCol: string;
  reqContainer: string | null;
  subReactIndex: number;
  subReactLen: number;
  tempMin: number;
  thermics: string;
  thermodynamics: Pairs;
  thermoUpper: number;
  upperpH: number;
};

type Reactant = {
  color: string;
  id: string;
  name: string;
  ratio: number;
  tooltip: string | null;
  tooltipBool: BooleanLike;
};

export type Reagent = {
  addictions: string[];
  desc: string;
  id: string;
  metaRate: number;
  name: string;
  OD: number;
  pH: number;
  pHCol: string;
  reagentCol: string;
};

type ReactionReagent = {
  id: string;
  name: string;
};

export type Reaction = {
  bitflags: number;
  id: string;
  name: string;
  reactants: ReactionReagent[];
};

export const bitflagInfo = [
  {
    flag: 'BRUTE',
    icon: 'gavel',
    tooltip: 'Produz um reagente que cura ou causa danos brutos.',
    category: 'Affects',
    toggle: 'toggle_tag_brute', // future todo : just make this use ui state
  },
  {
    flag: 'BURN',
    icon: 'burn',
    tooltip: 'Produz um reagente que cura ou causa danos à queimadura.',
    category: 'Affects',
    toggle: 'toggle_tag_burn',
  },
  {
    flag: 'TOXIN',
    icon: 'biohazard',
    tooltip: 'Produz um reagente que cura ou causa danos nas toxinas.',
    category: 'Affects',
    toggle: 'toggle_tag_toxin',
  },
  {
    flag: 'OXY',
    icon: 'wind',
    tooltip: 'Produz um reagente que cura ou causa danos sufocantes.',
    category: 'Affects',
    toggle: 'toggle_tag_oxy',
  },
  {
    flag: 'HEALING',
    icon: 'medkit',
    tooltip: 'Produz um reagente de cura.',
    category: 'Type',
    toggle: 'toggle_tag_healing',
  },
  {
    flag: 'DAMAGING',
    icon: 'skull-crossbones',
    tooltip: 'Produz um reagente prejudicial.',
    category: 'Type',
    toggle: 'toggle_tag_damaging',
  },
  {
    flag: 'EXPLOSIVE',
    icon: 'bomb',
    tooltip: 'Produz um reagente que explode ou explode na reação.',
    category: 'Type',
    toggle: 'toggle_tag_explosive',
  },
  {
    flag: 'OTHER',
    icon: 'question',
    tooltip: 'Produz um reagente com outro efeito colateral.',
    category: 'Affects',
    toggle: 'toggle_tag_other',
  },
  {
    flag: 'DANGEROUS',
    icon: 'exclamation-triangle',
    tooltip: 'A reação pode ter um efeito perigoso imediato.',
    category: 'Difficulty',
    toggle: 'toggle_tag_dangerous',
  },
  {
    flag: 'EASY',
    icon: 'chess-pawn',
    tooltip: 'Fácil de fazer a reação.',
    category: 'Difficulty',
    toggle: 'toggle_tag_easy',
  },
  {
    flag: 'MODERATE',
    icon: 'chess-knight',
    tooltip: 'Reação de dificuldade moderada.',
    category: 'Difficulty',
    toggle: 'toggle_tag_moderate',
  },
  {
    flag: 'HARD',
    icon: 'chess-queen',
    tooltip: 'É difícil fazer uma reação.',
    category: 'Difficulty',
    toggle: 'toggle_tag_hard',
  },
  {
    flag: 'ORGAN',
    icon: 'brain',
    tooltip: 'Produz um reagente que cura ou causa danos nos órgãos.',
    category: 'Affects',
    toggle: 'toggle_tag_organ',
  },
  {
    flag: 'DRINK',
    icon: 'cocktail',
    tooltip: 'Produz um reagente potável. Normalmente se apresentava no bar.',
    category: 'Type',
    toggle: 'toggle_tag_drink',
  },
  {
    flag: 'FOOD',
    icon: 'drumstick-bite',
    tooltip: 'Produz uma comida. Normalmente se apresenta na cozinha.',
    category: 'Type',
    toggle: 'toggle_tag_food',
  },
  {
    flag: 'SLIME',
    icon: 'microscope',
    tooltip: 'Uma reação relacionada à Xenobiologia.',
    category: 'Type',
    toggle: 'toggle_tag_slime',
  },
  {
    flag: 'DRUG',
    icon: 'pills',
    tooltip:
      'Produz um reagente viciante com efeitos positivos e negativos.',
    category: 'Type',
    toggle: 'toggle_tag_drug',
  },
  {
    flag: 'UNIQUE',
    icon: 'puzzle-piece',
    tooltip: 'Uma reação única ou especial.',
    category: 'Type',
    toggle: 'toggle_tag_unique',
  },
  {
    flag: 'CHEMICAL',
    icon: 'flask',
    tooltip: 'Produz um reagente que altera outras reações.',
    category: 'Affects',
    toggle: 'toggle_tag_chemical',
  },
  {
    flag: 'PLANT',
    icon: 'seedling',
    tooltip: 'Produz um reagente que pode julgar ou prejudicar plantas.',
    category: 'Affects',
    toggle: 'toggle_tag_plant',
  },
  {
    flag: 'COMPETITIVE',
    icon: 'recycle',
    tooltip: 'Uma reação que compete com outras reações.',
    category: 'Difficulty',
    toggle: 'toggle_tag_competitive',
  },
  {
    flag: 'COMPONENT',
    icon: 'question',
    tooltip: 'Produz um reagente comumente usado em outras reações.',
    category: 'Type',
    toggle: 'toggle_tag_component',
  },
  {
    flag: 'ACTIVE',
    icon: 'question',
    tooltip: 'A reação tem um efeito ativo e imediato.',
    category: 'Type',
    toggle: 'toggle_tag_active',
  },
];
