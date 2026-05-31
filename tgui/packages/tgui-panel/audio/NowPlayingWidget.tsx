/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

import { useAtomValue } from 'jotai';
import { Button, Collapsible, Flex, Knob, Section } from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';
import { useSettings } from '../settings/use-settings';
import { metaAtom, playingAtom } from './atoms';
import { player } from './handlers';

export function NowPlayingWidget(props) {
  const { settings, updateSettings } = useSettings();
  const meta = useAtomValue(metaAtom);
  const {
    album = 'Álbum Desconhecido',
    artist = 'Artista Desconhecido',
    duration,
    link,
    title,
    upload_date = 'Dados desconhecidos',
  } = meta || {};

  const playing = useAtomValue(playingAtom);

  const date = !Number.isNaN(upload_date)
    ? upload_date?.substring(0, 4) +
      '-' +
      upload_date?.substring(4, 6) +
      '-' +
      upload_date?.substring(6, 8)
    : upload_date;

  return (
    <Flex align="center">
      {playing ? (
        <Flex.Item
          mx={0.5}
          grow={1}
          style={{
            whiteSpace: 'nowrap',
            overflow: 'hidden',
            textOverflow: 'ellipsis',
          }}
        >
          {
            <Collapsible title={title || 'Trilha desconhecida'} color="blue">
              <Section>
                {link !== 'Link da Canção Escondido' && (
                  <Flex.Item grow={1} color="label">
                    URL: <a href={link}>{link}</a>
                  </Flex.Item>
                )}
                <Flex.Item grow={1} color="label">
                  Duration: {duration}
                </Flex.Item>
                {artist !== 'Artista Canção Escondida' &&
                  artist !== 'Artista Desconhecido' && (
                    <Flex.Item grow={1} color="label">
                      Artist: {artist}
                    </Flex.Item>
                  )}
                {album !== 'Álbum da Canção Escondido' && album !== 'Álbum Desconhecido' && (
                  <Flex.Item grow={1} color="label">
                    Album: {album}
                  </Flex.Item>
                )}
                {upload_date !== 'Data de envio da música escondida' &&
                  upload_date !== 'Data desconhecida' && (
                    <Flex.Item grow={1} color="label">
                      Uploaded: {date}
                    </Flex.Item>
                  )}
              </Section>
            </Collapsible>
          }
        </Flex.Item>
      ) : (
        <Flex.Item grow={1} color="label">
          Nothing to play.
        </Flex.Item>
      )}
      {playing && (
        <Flex.Item mx={0.5} fontSize="0.9em">
          <Button tooltip="Stop" icon="stop" onClick={() => player.stop()} />
        </Flex.Item>
      )}
      <Flex.Item mx={0.5} fontSize="0.9em">
        <Knob
          minValue={0}
          maxValue={1}
          value={settings.adminMusicVolume}
          step={0.0025}
          stepPixelSize={1}
          format={(value) => `${toFixed(value * 100)}%`}
          onChange={(e, value) => {
            updateSettings({
              adminMusicVolume: value,
            });
            player.setVolume(value);
          }}
        />
      </Flex.Item>
    </Flex>
  );
}
