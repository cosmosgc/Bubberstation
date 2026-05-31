/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

import { storage } from 'common/storage';
import { createLogger } from 'tgui/logging';
import { MAX_CONNECTIONS_STORED } from './constants';
import { type ConnectionRecord, connectionsMatch } from './helpers';

type Telemetry = {
  connections: ConnectionRecord[];
};

type TelemetryRequestPayload = {
  limits?: {
    connections: number;
  };
};

const logger = createLogger('telemetry');

let telemetry: Telemetry | null = null;
let wasRequestedWithPayload;

export function telemetryRequest(payload: TelemetryRequestPayload): void {
  // Defer telemetry request until we have the actual telemetry
  if (!telemetry) {
    logger.debug('Telemetria diferida.');
    wasRequestedWithPayload = payload;
    return;
  }

  logger.debug('enviando telemetria');
  const limits = payload?.limits?.connections;
  // Trim connections according to the server limit
  const connections = telemetry.connections.slice(0, limits);
  Byond.sendMessage('telemetry', { connections });
}

export function testTelemetryCommand() {
  setTimeout(() => {
    if (!telemetry) {
      Byond.sendMessage('ready');
    }
  }, 500);
}

type TelemetryUpdatePayload = {
  config: {
    client: ConnectionRecord;
  };
};

export async function handleTelemetryData(
  payload: TelemetryUpdatePayload,
): Promise<void> {
  // Extract client data
  const client = payload?.config?.client;
  if (!client) {
    logger.error('backend/update carga útil está faltando dados do cliente!');
    return;
  }

  // Load telemetry
  if (!telemetry) {
    const stored = await storage.get('telemetry');
    telemetry = {
      connections: stored?.connections ?? [],
    };
    logger.debug('Telemetria recuperada do armazenamento.', telemetry);
  }

  // Append a connection record
  let telemetryMutated = false;

  const duplicateConnection = telemetry!.connections.find((conn) =>
    connectionsMatch(conn, client),
  );

  if (!duplicateConnection) {
    telemetryMutated = true;
    telemetry!.connections.unshift(client);
    if (telemetry!.connections.length > MAX_CONNECTIONS_STORED) {
      telemetry!.connections.pop();
    }
  }

  // Save telemetry
  if (telemetryMutated) {
    logger.debug('Salvando telemetria para armazenamento.', telemetry);
    storage.set('telemetry', telemetry);
  }

  // Continue deferred telemetry requests
  if (wasRequestedWithPayload) {
    const deferred = wasRequestedWithPayload;
    wasRequestedWithPayload = null;
    telemetryRequest(deferred);
  }
}
