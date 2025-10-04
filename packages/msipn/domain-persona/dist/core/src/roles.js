export const ROLES_NUMERICOS = {
    ADMIN: 1,
    DIRECTOR: 3,
    OPERADOR: 5
};
export function rolClaveDesdeNumero(n) {
    return Object.keys(ROLES_NUMERICOS)
        .find(k => ROLES_NUMERICOS[k] === n);
}
export function tieneRol(user, ...roles) {
    if (!user)
        return false;
    return roles.some(r => user.rol === ROLES_NUMERICOS[r]);
}
export function esAdminLike(user) {
    return tieneRol(user, 'ADMIN', 'DIRECTOR');
}
