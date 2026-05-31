import { beforeEach, describe, expect, it } from 'bun:test';

import { ChatHistory } from './ChatHistory';

describe('ChatHistory', () => {
  let chatHistory: ChatHistory;

  beforeEach(() => {
    chatHistory = new ChatHistory();
  });

  it('deve adicionar uma mensagem para a história', () => {
    chatHistory.add('Hello');
    expect(chatHistory.getOlderMessage()).toEqual('Hello');
  });

  it('deve recuperar mensagens mais antigas e novas.', () => {
    chatHistory.add('Hello');
    chatHistory.add('World');
    expect(chatHistory.getOlderMessage()).toEqual('World');
    expect(chatHistory.getOlderMessage()).toEqual('Hello');
    expect(chatHistory.getNewerMessage()).toEqual('World');
    expect(chatHistory.getNewerMessage()).toBeNull();
    expect(chatHistory.getOlderMessage()).toEqual('World');
  });

  it('deve limitar o histórico para 5 mensagens', () => {
    for (let i = 1; i <= 6; i++) {
      chatHistory.add(`Message ${i}`);
    }

    expect(chatHistory.getOlderMessage()).toEqual('Mensagem 6');
    for (let i = 5; i >= 2; i--) {
      expect(chatHistory.getOlderMessage()).toEqual(`Message ${i}`);
    }
    expect(chatHistory.getOlderMessage()).toBeNull();
  });

  it('deve lidar com a mensagem temporária corretamente.', () => {
    chatHistory.saveTemp('Mensagem temporária.');
    expect(chatHistory.getTemp()).toEqual('Mensagem temporária.');
    expect(chatHistory.getTemp()).toBeNull();
  });

  it('Deve ser reiniciado corretamente.', () => {
    chatHistory.add('Hello');
    chatHistory.getOlderMessage();
    chatHistory.reset();
    expect(chatHistory.isAtLatest()).toBe(true);
    expect(chatHistory.getOlderMessage()).toEqual('Hello');
  });
});
