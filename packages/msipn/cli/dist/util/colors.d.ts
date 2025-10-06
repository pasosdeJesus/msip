export declare const color: {
    blue: (s: string) => string;
    green: (s: string) => string;
    red: (s: string) => string;
    yellow: (s: string) => string;
    dim: (s: string) => string;
    bold: (s: string) => string;
};
export declare function success(msg: string): void;
export declare function problem(msg: string): void;
export declare function info(msg: string): void;
export declare function warn(msg: string): void;
export declare function colorizeCommandName(name: string): string;
