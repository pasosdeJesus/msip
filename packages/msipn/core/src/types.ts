// Tipos base para metadata MVP
export type ScalarType = 'string' | 'text' | 'integer' | 'boolean' | 'dateParts' | 'enum' | 'timestamp' | 'password';

export interface FieldBase {
  type: ScalarType;
  required?: boolean;
  nullable?: boolean;
  maxLength?: number;
  default?: any;
  label?: string;
  help?: string;
  searchable?: boolean;
  sortable?: boolean;
  hidden?: boolean;
}

export interface EnumField extends FieldBase {
  type: 'enum';
  values: string[];
  dynamicValuesFnKey?: string;
}

export interface FKField extends FieldBase {
  type: 'integer';
  fk: {
    references: string; // e.g. 'tdocumento.id'
    displayField?: string;
    cascadeDelete?: boolean;
  };
}

export type FieldDefinition = FieldBase | EnumField | FKField;

export interface RelationDefinition {
  kind: 'belongsTo' | 'hasMany' | 'manyToMany';
  target: string;
  through?: string;
  sourceFk?: string;
  targetFk?: string;
  fkField?: string; // belongsTo
}

export type StandardOperator = 'eq' | 'ilike' | 'in' | 'range' | 'enum';

export interface BaseFilterDefinition {
  name: string;
  field?: string;
}

export interface StandardFilterDefinition extends BaseFilterDefinition {
  operator: StandardOperator;
}

export interface CustomFilterDefinition extends BaseFilterDefinition {
  operator: 'custom';
  customBuilderKey: string;
}

export type FilterDefinition = StandardFilterDefinition | CustomFilterDefinition;

export interface ValidationRule {
  name: string;
  run: (record: any) => true | string;
  phase?: 'pre' | 'post';
}

export interface PermissionSet {
  read: (ctx: any) => boolean;
  create: (ctx: any) => boolean;
  update: (ctx: any) => boolean;
  delete: (ctx: any) => boolean;
  fieldVisibility?: Record<string, (ctx: any) => boolean>;
}

export interface EntityDefinition {
  name: string;
  table: string;
  primaryKey: string;
  labels: { singular: string; plural: string };
  fields: Record<string, FieldDefinition>;
  relations?: Record<string, RelationDefinition>;
  filters?: FilterDefinition[];
  validations?: ValidationRule[];
  permissions: PermissionSet;
  presentation?: { label?(record: any): string };
}
