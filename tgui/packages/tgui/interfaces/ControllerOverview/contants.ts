type SortType = {
  label: string;
  propName: string;
  inDeciseconds: boolean;
};

export const SORTING_TYPES: readonly SortType[] = [
  {
    label: 'Alphabetical',
    propName: 'name',
    inDeciseconds: false,
  },
  {
    label: 'Cost',
    propName: 'cost_ms',
    inDeciseconds: true,
  },
  {
    label: 'Ordem Init',
    propName: 'init_order',
    inDeciseconds: false,
  },
  {
    label: 'Último Fogo',
    propName: 'last_fire',
    inDeciseconds: false,
  },
  {
    label: 'Próximo Fogo',
    propName: 'next_fire',
    inDeciseconds: false,
  },
  {
    label: 'Uso do Tique',
    propName: 'tick_usage',
    inDeciseconds: true,
  },
  {
    label: 'Avg Usage Per Tick',
    propName: 'usage_per_tick',
    inDeciseconds: true,
  },
  {
    label: 'Subsistema Overtime',
    propName: 'overtime',
    inDeciseconds: true,
  },
];
