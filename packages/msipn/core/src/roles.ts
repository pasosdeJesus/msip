export const ROLES_NUMERICOS = {
  ADMIN: 1,
  DIRECTOR: 3,
  OPERADOR: 5
} as const;

export type RolClave = keyof typeof ROLES_NUMERICOS;

export function rolClaveDesdeNumero(n: number): RolClave | undefined {
  return (Object.keys(ROLES_NUMERICOS) as RolClave[])
    .find(k => ROLES_NUMERICOS[k] === n);
}

export function tieneRol(user: any, ...roles: RolClave[]) {
  if (!user) return false;
  return roles.some(r => user.rol === ROLES_NUMERICOS[r]);
}

export function esAdminLike(user: any) {
  return tieneRol(user, 'ADMIN', 'DIRECTOR');
}
