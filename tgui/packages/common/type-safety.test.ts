import { describe, it } from 'bun:test';
import assert from 'node:assert/strict';
import * as z from 'zod';
import { smoothMerge } from './type-safety';

describe('smoothMerge', () => {
  it('mescla campos válidos da fonte para o alvo', () => {
    const schema = z.object({
      a: z.string(),
      b: z.number(),
    });

    const source = { a: 'hello', b: 'Não um número.', c: true };
    const target = { a: 'default', b: 42 };

    const result = smoothMerge({ schema, source, target });
    assert.deepEqual(result, { a: 'hello', b: 42 });
  });

  it('retorna o alvo se a fonte estiver vazia', () => {
    const schema = z.object({
      a: z.string(),
    });

    const source = {};
    const target = { a: 'default' };
    const result = smoothMerge({ schema, source, target });
    assert.deepEqual(result, target);
  });

  it('Ignora completamente um objeto se não estiver no esquema.', () => {
    const schema = z.object({
      a: z.string(),
      b: z.number(),
    });

    const source = {
      c: 1,
      d: [1, 2, 3],
    };

    const target = {
      a: 'default',
      b: 42,
    };

    const result = smoothMerge({ schema, source, target });
    assert.deepEqual(result, {
      a: 'default',
      b: 42,
    });
  });
});
