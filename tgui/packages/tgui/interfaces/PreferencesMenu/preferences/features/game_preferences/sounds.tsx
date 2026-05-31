import {
  CheckboxInput,
  type Feature,
  type FeatureChoiced,
  FeatureSliderInput,
  type FeatureToggle,
} from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const sound_ambience_volume: Feature<number> = {
  name: 'Volume de ambiente',
  category: 'SOUND',
  description: `Ambience refers to the more noticeable ambient sounds that play on occasion.`,
  component: FeatureSliderInput,
};

export const sound_breathing: FeatureToggle = {
  name: 'Activar sons respiratórios',
  category: 'SOUND',
  description: 'Quando habilitado, ouvir sons de respiração quando usar internos.',
  component: CheckboxInput,
};

export const sound_announcements: FeatureToggle = {
  name: 'Activar sons de anúncio',
  category: 'SOUND',
  description: 'Quando habilitado, ouvir sons de relatórios de comando, avisos, etc.',
  component: CheckboxInput,
};

export const sound_ghost_poll_prompt: FeatureChoiced = {
  name: 'Chamada de pesquisa fantasma.',
  category: 'SOUND',
  description: 'Escolha qual é o sinal de som para fazer pesquisas fantasmas.',
  component: FeatureDropdownInput,
};

export const sound_ghost_poll_prompt_volume: Feature<number> = {
  name: 'Volume da sondagem fantasma.',
  category: 'SOUND',
  description: 'O volume em que a pesquisa fantasma vai tocar.',
  component: FeatureSliderInput,
};

export const sound_combatmode: FeatureToggle = {
  name: 'Activar o som do modo de combate',
  category: 'SOUND',
  description: 'Quando habilitado, ouvir sons quando alternando modo de combate.',
  component: CheckboxInput,
};

export const sound_instruments: Feature<number> = {
  name: 'Volume de instrumentos',
  category: 'SOUND',
  description: 'Volume de instrumentos.',
  component: FeatureSliderInput,
};

export const sound_jukebox: Feature<number> = {
  name: 'Volume Jukebox',
  category: 'SOUND',
  description: 'Volume de rastros de jukebox.',
  component: FeatureSliderInput,
};

export const sound_tts: FeatureChoiced = {
  name: 'Activar TTS',
  category: 'SOUND',
  description: `
    When enabled, be able to hear text-to-speech sounds in game.
    When set to "Blips", text to speech will be replaced with blip sounds based on the voice.
  `,
  component: FeatureDropdownInput,
};

export const sound_tts_volume: Feature<number> = {
  name: 'Volume TTS',
  category: 'SOUND',
  description: 'O volume em que o texto vai tocar.',
  component: FeatureSliderInput,
};

export const sound_lobby_volume: Feature<number> = {
  name: 'Lobby, volume de música.',
  category: 'SOUND',
  component: FeatureSliderInput,
};

export const sound_midi: Feature<number> = {
  name: 'Volume de música do administrador',
  category: 'SOUND',
  description: 'Volume de músicas administrativas.',
  component: FeatureSliderInput,
};

export const sound_ship_ambience_volume: Feature<number> = {
  name: 'Volume de ambiente da nave',
  category: 'SOUND',
  description: `Ship ambience refers to the low ambient buzz that plays on loop.`,
  component: FeatureSliderInput,
};

export const sound_achievement: FeatureChoiced = {
  name: 'A conquista destrava o som',
  category: 'SOUND',
  description: `
    The sound that's played when unlocking an achievement.
    If disabled, no sound will be played.
  `,
  component: FeatureDropdownInput,
};

export const sound_ai_vox: Feature<number> = {
  name: 'AI VOX anuncia volume',
  category: 'SOUND',
  description: 'Volume de anúncios vocais de IA (também conhecido como "VOX").',
  component: FeatureSliderInput,
};
