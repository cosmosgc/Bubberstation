import { type Antagonist, Category } from '../base';

export const REVOLUTIONARY_MECHANICAL_DESCRIPTION = `
      Armed with a flash, convert as many people to the revolution as you can.
      Kill or exile all heads of staff on the station.
   `;

const HeadRevolutionary: Antagonist = {
  key: 'headrevolutionary',
  name: 'Chefe Revolucionário',
  description: ['Viva a revolução!', REVOLUTIONARY_MECHANICAL_DESCRIPTION],
  category: Category.Roundstart,
};

export default HeadRevolutionary;
