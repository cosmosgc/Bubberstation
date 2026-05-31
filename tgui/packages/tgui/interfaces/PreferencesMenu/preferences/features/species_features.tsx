import {
  type Feature,
  type FeatureChoiced,
  type FeatureChoicedServerData,
  FeatureColorInput,
  type FeatureValueProps,
} from './base';
import { FeatureDropdownInput } from './dropdowns';

export const eye_color: Feature<string> = {
  name: 'Cor dos olhos',
  component: FeatureColorInput,
};

export const facial_hair_color: Feature<string> = {
  name: 'Cor do cabelo facial',
  component: FeatureColorInput,
};

export const facial_hair_gradient: FeatureChoiced = {
  name: 'Gradiente de cabelo facial',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const facial_hair_gradient_color: Feature<string> = {
  name: 'Cor do gradiente de cabelo facial',
  component: FeatureColorInput,
};

export const hair_color: Feature<string> = {
  name: 'Cor do cabelo',
  component: FeatureColorInput,
};

export const hair_gradient: FeatureChoiced = {
  name: 'Gradiente de cabelo',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const hair_gradient_color: Feature<string> = {
  name: 'Cor do gradiente de cabelo',
  component: FeatureColorInput,
};

export const feature_cat_ears: FeatureChoiced = {
  name: 'Ears',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_cat_tail: FeatureChoiced = {
  name: 'Tail',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_monkey_tail: FeatureChoiced = {
  name: 'Tail',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_lizard_legs: FeatureChoiced = {
  name: 'Legs',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_lizard_spines: FeatureChoiced = {
  name: 'Spines',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_lizard_tail: FeatureChoiced = {
  name: 'Tail',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_mcolor: Feature<string> = {
  name: 'Cor mutante',
  component: FeatureColorInput,
};

export const underwear_color: Feature<string> = {
  name: 'Cor das cuecas',
  component: FeatureColorInput,
};

export const bra_color: Feature<string> = {
  name: 'Cor do sutiã',
  component: FeatureColorInput,
};

export const feature_vampire_status: Feature<string> = {
  name: 'Status de vampiro',
  component: FeatureDropdownInput,
};

export const heterochromatic: Feature<string> = {
  name: 'Cor heterocromática (Olho direito)',
  component: FeatureColorInput,
};
