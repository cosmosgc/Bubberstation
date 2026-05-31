import { describe, expect, it } from 'bun:test';

import {
  getGasColor,
  getGasFromId,
  getGasFromPath,
  getGasLabel,
} from './constants';

describe('Funções auxiliares de gás', () => {
  it('deve obter a etiqueta de gás adequada', () => {
    const gasId = 'antinoblium';
    const gasLabel = getGasLabel(gasId);
    expect(gasLabel).toBe('Anti-Noblium');
  });

  it('deve obter a etiqueta de gás adequada com um recuo', () => {
    const gasId = 'nonexistent';
    const gasLabel = getGasLabel(gasId, 'fallback');

    expect(gasLabel).toBe('fallback');
  });

  it('Não deve devolver nenhum se nenhum gás e nenhum retorno for encontrado.', () => {
    const gasId = 'nonexistent';
    const gasLabel = getGasLabel(gasId);

    expect(gasLabel).toBe('None');
  });

  it('deve ter a cor do gás adequada', () => {
    const gasId = 'antinoblium';
    const gasColor = getGasColor(gasId);

    expect(gasColor).toBe('maroon');
  });

  it('deve devolver uma corda se nenhum gás é encontrado', () => {
    const gasId = 'nonexistent';
    const gasColor = getGasColor(gasId);

    expect(gasColor).toBe('black');
  });

  it('Deve devolver o objeto de gás se encontrado.', () => {
    const gasId = 'antinoblium';
    const gas = getGasFromId(gasId);

    expect(gas).toEqual({
      id: 'antinoblium',
      path: '/datum/gas/antinoblium',
      name: 'Antinoblium',
      label: 'Anti-Noblium',
      color: 'maroon',
    });
  });

  it('Deve retornar indefinido se nenhum gás for encontrado.', () => {
    const gasId = 'nonexistent';
    const gas = getGasFromId(gasId);

    expect(gas).toBeUndefined();
  });

  it('deve devolver o gás usando um caminho', () => {
    const gasPath = '/datum/gas/antinoblium';
    const gas = getGasFromPath(gasPath);

    expect(gas).toEqual({
      id: 'antinoblium',
      path: '/datum/gas/antinoblium',
      name: 'Antinoblium',
      label: 'Anti-Noblium',
      color: 'maroon',
    });
  });
});
