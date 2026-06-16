import { beforeEach, describe, expect, it } from 'bun:test';

import { ChannelIterator } from './ChannelIterator';

describe('ChannelIterator', () => {
  let channelIterator: ChannelIterator;

  beforeEach(() => {
    channelIterator = new ChannelIterator();
  });

  it('deve circular através de canais corretamente', () => {
    expect(channelIterator.current()).toBe('Say');
    expect(channelIterator.next()).toBe('Radio');
    expect(channelIterator.next()).toBe('Me');

    // SKYRAT EDIT ADDITION START
    expect(channelIterator.next()).toBe('Whis');
    expect(channelIterator.next()).toBe('LOOC');
    // SKYRAT EDIT ADDITION END

    expect(channelIterator.next()).toBe('OOC');
    expect(channelIterator.next()).toBe('Pray');
    expect(channelIterator.next()).toBe('Say'); // Admin is blacklisted so it should be skipped
  });

  it('deve definir um canal corretamente', () => {
    channelIterator.set('OOC');
    expect(channelIterator.current()).toBe('OOC');
  });

  it('deve retornar verdadeiro quando o canal atual é "Diga"', () => {
    channelIterator.set('Say');
    expect(channelIterator.isSay()).toBe(true);
  });

  it('Deve voltar falso quando o canal atual não é "Diga"', () => {
    channelIterator.set('Radio');
    expect(channelIterator.isSay()).toBe(false);
  });

  it('deve retornar verdadeiro quando o canal atual é visível', () => {
    channelIterator.set('Say');
    expect(channelIterator.isVisible()).toBe(true);
  });

  it('Deve retornar falso quando o canal atual não estiver visível.', () => {
    channelIterator.set('OOC');
    expect(channelIterator.isVisible()).toBe(false);
  });

  it('Não deve vazar uma mensagem de um canal na lista negra.', () => {
    channelIterator.set('Admin');
    expect(channelIterator.next()).toBe('Admin');
  });
});
