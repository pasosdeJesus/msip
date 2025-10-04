import { FieldDefinition, ValidationRule, FilterDefinition } from './types';
export interface BasicaOptions {
    nombreMaxLength?: number;
    observacionesMaxLength?: number;
    enforceNombreUnique?: boolean;
}
export declare const basicaMixin: (opts?: BasicaOptions) => {
    fields: Record<string, FieldDefinition>;
    validations: ValidationRule[];
    filters: FilterDefinition[];
    hooks: {
        beforeValidate: (record: any) => void;
    };
};
