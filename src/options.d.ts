declare interface Options {
	onlyShowFailures?: boolean;
	directories: Array<Instance>;
	includeDescendants?: boolean;
	verbose?: boolean;
}

export = Options;
