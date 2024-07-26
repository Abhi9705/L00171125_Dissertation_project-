// eslint.config.js
module.exports = [
    {
      files: ["**/*.js"],
      languageOptions: {
        ecmaVersion: 12,
        sourceType: "module"
      },
      rules: {
        "no-console": "off",
        "semi": ["error", "never"],
        "quotes": ["error", "single"]
      },
      linterOptions: {
        reportUnusedDisableDirectives: true
      },
    },
  ];
  