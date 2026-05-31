const doomMessages = [
  'Compre ouro!',
  'Compre baixo, venda alto!',
  'INVESTE EM CRYPTO!',
  'Venda tudo!',
  'A economia está colapsando!',
  'A economia está arruinada!',
  'O mercado está bombando!',
  'A estação está indo para a banca!',
];

// Used when the economy is crashing to get a random funny message.
export function getRandomDoomMessage(): string {
  return doomMessages[Math.floor(Math.random() * doomMessages.length)];
}
