module.exports = {
    files: ["**/*.js"],
    languageOptions: {
      ecmaVersion: 12,
      sourceType: "module"
    },
    rules: {
      "quotes": ["error", "double"],
      "semi": ["error", "always"],
      "no-console": "off",
      "indent": ["error", 2],
      "no-unused-vars": ["error", { "argsIgnorePattern": "^_" }],
      "eqeqeq": ["error", "always"],
      "no-trailing-spaces": "error",
      "curly": ["error", "all"],
      "prefer-const": "error",
      "no-var": "error"
    },
    linterOptions: {
      reportUnusedDisableDirectives: true
    }
  };
  