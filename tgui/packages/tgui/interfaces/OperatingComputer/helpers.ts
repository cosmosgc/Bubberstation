import { capitalizeFirst } from 'tgui-core/string';
import type { OperationData } from './types';

export function extractSurgeryName(
  operation: OperationData,
  catalog: boolean,
): { name: string; tool: string; true_name?: string } {
  // operation names may be "make incision", "lobotomy", or "disarticulation (amputation)"
  const { name, tool_rec } = operation;
  if (!name) {
    return { name: 'Cirurgia de Erro', tool: 'Error' };
  }
  const parenthesis = name.indexOf('(');
  if (parenthesis === -1) {
    return { name: capitalizeFirst(name), tool: tool_rec };
  }
  const in_parenthesis = name.slice(parenthesis + 1, name.indexOf(')')).trim();
  if (!catalog) {
    return {
      name: capitalizeFirst(in_parenthesis),
      tool: tool_rec,
    };
  }
  const out_parenthesis = capitalizeFirst(name.slice(0, parenthesis).trim());
  return {
    name: capitalizeFirst(out_parenthesis),
    tool: tool_rec,
    true_name: capitalizeFirst(in_parenthesis),
  };
}

export function extractRequirementMap(
  surgery: OperationData,
): Record<string, string[]> {
  if (surgery.requirements?.length !== 4) {
    return {}; // we can assert this never happens, but just in case...
  }
  const hard_requirements = surgery.requirements[0];
  const soft_requirements = surgery.requirements[1];
  const optional_requirements = surgery.requirements[2];
  const blocked_requirements = surgery.requirements[3];

  // you *have* to have one of the soft requirements, so if there's only one...
  if (soft_requirements.length === 1) {
    hard_requirements.push(soft_requirements[0]);
    soft_requirements.length = 0;
  }

  const optional_title = () => {
    if (optional_requirements.length === 1) {
      if (hard_requirements.length === 0) return 'O seguinte é opcional:';
      return 'Além disso, o seguinte é opcional:';
    }
    if (hard_requirements.length === 0)
      return 'Todos os seguintes são opcionais:';
    return 'Além disso, todos os seguintes são opcionais:';
  };

  const blocked_title = () => {
    if (blocked_requirements.length === 1) {
      if (hard_requirements.length === 0)
        return 'O seguinte bloquearia o procedimento:';
      return 'No entanto, o seguinte bloquearia o procedimento:';
    }
    if (hard_requirements.length === 0)
      return 'Qualquer um dos seguintes bloquearia o procedimento:';
    return 'No entanto, qualquer um dos seguintes bloquearia o procedimento:';
  };

  return {
    [`${hard_requirements.length === 1 ? 'The' : 'Todos os'} following are required:`]:
      hard_requirements,
    'Além disso, um dos seguintes é necessário:': soft_requirements,
    [optional_title()]: optional_requirements,
    [blocked_title()]: blocked_requirements,
  };
}
