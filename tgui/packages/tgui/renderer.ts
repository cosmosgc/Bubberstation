import { perf } from 'common/perf';
import type { ReactNode } from 'react';
import { createRoot, type Root } from 'react-dom/client';
import { createLogger } from './logging';

const logger = createLogger('renderer');

let reactRoot: Root;
let initialRender: string | boolean = true;
let suspended = false;

// These functions are used purely for profiling.
export function resumeRenderer() {
  initialRender = initialRender || 'resumed';
  suspended = false;
}

export function suspendRenderer() {
  suspended = true;
}

enum Render {
  Start = 'render/start',
  Finish = 'render/finish',
}

export function render(component: ReactNode) {
  perf.mark(Render.Start);
  // Start rendering
  if (!reactRoot) {
    const element = document.getElementById('react-root');
    reactRoot = createRoot(element!);
  }

  reactRoot.render(component);

  perf.mark(Render.Finish);
  if (suspended) {
    return;
  }

  // Report rendering time
  if (process.env.NODE_ENV !== 'production') {
    if (initialRender === 'resumed') {
      logger.log('renderizado em', perf.measure(Render.Start, Render.Finish));
    } else if (initialRender) {
      logger.debug('Servindo de:', location.href);
      logger.debug('O pacote entrou.', perf.measure('inception', 'init'));
      logger.debug('inicializado em', perf.measure('init', Render.Start));
      logger.log('renderizado em', perf.measure(Render.Start, Render.Finish));
      logger.log('totalmente carregado em', perf.measure('inception', Render.Finish));
    } else {
      logger.debug('renderizado em', perf.measure(Render.Start, Render.Finish));
    }
  }

  if (initialRender) {
    initialRender = false;
  }
}
