import {
  CheckboxInput,
  type Feature,
  type FeatureChoiced,
  FeatureShortTextInput,
  FeatureTextInput,
  type FeatureToggle,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const emote_length: FeatureChoiced = {
  name: 'Comprimento emotivo preferido',
  category: 'ADVERT',
  description:
    'Que tamanho de emoção prefere durante uma cena de RP, se tiver. Mostra no seu anúncio de personagens.',
  component: FeatureDropdownInput,
};

export const approach_pref: FeatureChoiced = {
  name: 'Método de aproximação preferido',
  category: 'ADVERT',
  description:
    'Como você gostaria de ser abordado para cenas RP, se em tudo. Mostra no seu anúncio de personagens.',
  component: FeatureDropdownInput,
};

export const furry_pref: FeatureChoiced = {
  name: 'Atração: furries?',
  category: 'ADVERT',
  description:
    'Como, e se, você gostaria de se envolver em RP com personagens peludos, como Anthromorphs, Birdfolk ou Insectoids.',
  component: FeatureDropdownInput,
};

export const scalie_pref: FeatureChoiced = {
  name: 'Atração: escalas?',
  category: 'ADVERT',
  description:
    'Como, e se, você gostaria de se envolver em RP com personagens de escala, como lagartos, peixes ou dragões.',
  component: FeatureDropdownInput,
};

export const other_pref: FeatureChoiced = {
  name: 'Atração: outros?',
  category: 'ADVERT',
  description:
    'Como, e se, você gostaria de se envolver em RP com personagens estranhos, como Silicones, Taurs, Megafauna e Xenos.',
  component: FeatureDropdownInput,
};

export const demihuman_pref: FeatureChoiced = {
  name: 'Atração: demihumanos?',
  category: 'ADVERT',
  description:
    'Como, e se, você gostaria de se envolver em RP com personagens demihumanos, como gatos ou cães humanos, monstros ou demônios.',
  component: FeatureDropdownInput,
};

export const human_pref: FeatureChoiced = {
  name: 'Atração: humanos?',
  category: 'ADVERT',
  description:
    'Como, e se, você gostaria de se envolver em RP com personagens humanos. Você sabe o que é um humano.',
  component: FeatureDropdownInput,
};

export const character_ad: Feature<string> = {
  name: 'Anúncio de Caracteres',
  description:
    'Um anúncio de roleplay para seu personagem. Fale sobre o que está procurando em termos de interpretação, e como se aproximar. Dê detalhes o máximo possível.',
  component: FeatureTextInput,
};

export const attraction: FeatureChoiced = {
  name: 'Atração de Caracteres',
  description:
    'O que classifica pelo que seu caráter é atraído. Isso é exibido no diretório.',
  component: FeatureDropdownInput,
};

export const display_gender: FeatureChoiced = {
  name: 'Gênero de Caracteres',
  description:
    'O que classifica como o gênero para o seu caráter. Isso é exibido no diretório.',
  component: FeatureDropdownInput,
};

export const flavor_text_nsfw: Feature<string> = {
  name: 'Texto Sabor (NSFW)',
  description:
    'A parte NSFW do seu texto de sabor. Costumava guardar detalhes sexuais visuais.',
  component: FeatureTextInput,
};

export const low_arousal_text: Feature<string> = {
  name: 'Sabor de excitação - Baixo',
  description: 'Como seu personagem pode ser percebido como um pouco excitado',
  component: FeatureShortTextInput,
};

export const medium_arousal_text: Feature<string> = {
  name: 'Sabor de excitação - Médio',
  description: 'Como seu personagem pode ser percebido como um pouco excitado',
  component: FeatureShortTextInput,
};

export const high_arousal_text: Feature<string> = {
  name: 'Sabor de excitação - Forte',
  description: 'Como seu caráter pode ser percebido como altamente excitado',
  component: FeatureShortTextInput,
};

export const silicon_flavor_text_nsfw: Feature<string> = {
  name: 'Texto de sabor de silicone NSFW',
  description:
    'Uma parte do seu texto de sabor que é armazenado em exame, usado para Silicones. Costumava guardar detalhes sexuais visuais.',
  component: FeatureTextInput,
};

export const headshot_silicon: Feature<string> = {
  name: 'Tiro na cabeça de silicone',
  description:
    'Requires a link ending with .png, .jpeg, or .jpg, starting with \
  https://, and hosted on Catbox, Imgbox, Gyazo, Lensdump, or F-List. \
  Renders the image underneath your character preview in the examine more window. \
  Image larger than 250x250 will be resized to 250x250. \
  Aim for 250x250 whenever possible',
  component: FeatureShortTextInput,
};

export const headshot_nsfw: Feature<string> = {
  name: 'Tiro na cabeça (NSFW)',
  description:
    'Headshot, but for NSFW references. \
    Requires a link ending with .png, .jpeg, or .jpg, starting with \
    https://, and hosted on Catbox, Imgbox, Gyazo, Lensdump, or F-List. \
    Renders the image underneath your character preview in the examine more window. \
    Image larger than 250x250 will be resized to 250x250. \
    Aim for 250x250 whenever possible',
  component: FeatureShortTextInput,
};

export const headshot_silicon_nsfw: Feature<string> = {
  name: 'Cabeça de silicone (NSFW)',
  description:
    'Headshot, but for NSFW references on Silicons. \
    Requires a link ending with .png, .jpeg, or .jpg, starting with \
    https://, and hosted on Catbox, Imgbox, Gyazo, Lensdump, or F-List. \
    Renders the image underneath your character preview in the examine more window. \
    Image larger than 250x250 will be resized to 250x250. \
    Aim for 250x250 whenever possible',
  component: FeatureShortTextInput,
};

export const ooc_notes_silicon: Feature<string> = {
  name: 'Notas OOC (Silicon)',
  description: 'O mesmo que o COO, mas para seu caráter de silicone!',
  component: FeatureTextInput,
};

export const custom_species_silicon: Feature<string> = {
  name: 'Nome do modelo de silicone',
  description:
    'O nome do módulo para sua empresa de silicone, como "Armadyne Pleasure Model".',
  component: FeatureShortTextInput,
};

export const custom_species_lore_silicon: Feature<string> = {
  name: 'Silicon Model Lore',
  description:
    'Lore para o seu silício, normalmente sua empresa, fazer, modelo, e detalhes sobre sua criação.',
  component: FeatureTextInput,
};

export const art_ref: Feature<string> = {
  name: 'Referência Artística',
  description:
    'Art Reference that others can see for your character \
    Requires a link ending with .png, .jpeg, or .jpg, starting with \
    https://, and hosted on Catbox, Imgbox, Gyazo, Lensdump, or F-List.',
  component: FeatureShortTextInput,
};

export const art_ref_nsfw: FeatureToggle = {
  name: 'Referência Artística (NSFW)',
  description: 'Sua foto de referência é NSFW?',
  component: CheckboxInput,
};
