import type { ColumnType } from "kysely";

export type Generated<T> = T extends ColumnType<infer S, infer I, infer U>
  ? ColumnType<S, I | undefined, U>
  : ColumnType<T, T | undefined, T>;

export type Timestamp = ColumnType<Date, Date | string, Date | string>;

export interface Example {
  created_at: Generated<Timestamp | null>;
  id: Generated<number>;
  name: string;
}

export interface ExampleInapp {
  id: Generated<number>;
  nombre: string;
}

export interface DB {
  example: Example;
  example_inapp: ExampleInapp;
}
