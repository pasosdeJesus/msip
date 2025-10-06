import pc from 'picocolors';

// Enable colors only if stdout is TTY and not explicitly disabled
const enabled = process.stdout.isTTY && process.env.FORCE_COLOR !== '0';

function wrap(fn: (s: string) => string) {
  return (s: string) => enabled ? fn(s) : s;
}

export const color = {
  blue: wrap(pc.blue),
  green: wrap(pc.green),
  red: wrap(pc.red),
  yellow: wrap(pc.yellow),
  dim: wrap(pc.dim),
  bold: wrap(pc.bold)
};

export function success(msg: string) {
  console.log(color.green(msg));
}

export function problem(msg: string) {
  console.error(color.red(msg));
}

export function info(msg: string) {
  console.log(color.blue(msg));
}

export function warn(msg: string) {
  console.warn(color.yellow(msg));
}

export function colorizeCommandName(name: string) {
  return color.blue(name);
}
