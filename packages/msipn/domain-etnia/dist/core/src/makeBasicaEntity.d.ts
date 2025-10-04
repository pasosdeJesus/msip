import { EntityDefinition, FieldDefinition, ValidationRule, PermissionSet } from './types';
export interface MakeBasicaOptions {
    name: string;
    table: string;
    labels: {
        singular: string;
        plural: string;
    };
    extraFields?: Record<string, FieldDefinition>;
    extraValidations?: ValidationRule[];
    permissions?: Partial<PermissionSet>;
    nombreUnique?: boolean;
    orderField?: string;
}
export declare function makeBasicaEntity(opts: MakeBasicaOptions): EntityDefinition;
