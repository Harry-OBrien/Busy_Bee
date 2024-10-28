module.exports = {
	env: {
		es6: true,
		node: true,
	},
	parserOptions: {
		"ecmaVersion": 2018,
	},
	extends: [
		"eslint:recommended",
		"google",
	],
	rules: {
		"indent": ["error", "tab"],
		"no-tabs": "off",
		"no-restricted-globals": ["error", "name", "length"],
		"prefer-arrow-callback": "error",
		"quotes": ["error", "double", { "allowTemplateLiterals": true }],
		"object-curly-spacing": ["error", "always"],
	},
	overrides: [
		{
			files: ["**/*.spec.*"],
			env: {
				mocha: true,
			},
			rules: {},
		},
	],
	globals: {},
};
