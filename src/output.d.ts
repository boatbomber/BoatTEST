import Options from "options";

interface Results {
	[dirName: number | string]: {
		[fileName: string]: {
			[testName: string]: {
				skipped?: boolean;
				success?: boolean;
				msg?: string;
			};
		};
	};
}

declare function output(options: Options, results: Results, passed: number, failed: number, skipped: number): void;

export = output;
