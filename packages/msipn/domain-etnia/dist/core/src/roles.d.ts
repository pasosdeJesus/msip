export declare const ROLES_NUMERICOS: {
    readonly ADMIN: 1;
    readonly DIRECTOR: 3;
    readonly OPERADOR: 5;
};
export type RolClave = keyof typeof ROLES_NUMERICOS;
export declare function rolClaveDesdeNumero(n: number): RolClave | undefined;
export declare function tieneRol(user: any, ...roles: RolClave[]): boolean;
export declare function esAdminLike(user: any): boolean;
