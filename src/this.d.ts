type assertions = assertionMethods & { [index: string]: assertions };

interface assertionMethods {
	never: assertions;

	exist(): void;
	exists(): void;

	equal(expectedValue: unknown): void;
	equals(expectedValue: unknown): void;

	isA(expectedType: keyof CheckableTypes): void;

	fail(): void;
	fails(): void;
	throw(): void;
	throws(): void;

	match(pattern: string): void;
	matches(pattern: string): void;
}

declare function thisValue(options: unknown): assertions;

export = thisValue;
