// eslint.config.js
export default [
    {
      files: ["**/*.js"],
      languageOptions: {
        ecmaVersion: 12,
        sourceType: "module"
      },
      rules: {
        "no-console": "off",
        "semi": ["error", "always"],
        "quotes": ["error", "double"]
      },
      linterOptions: {
        reportUnusedDisableDirectives: true
      },
    },
  ];
  