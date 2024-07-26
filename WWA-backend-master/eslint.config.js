module.exports = [
    {
      files: ["**/*.js"],
      languageOptions: {
        ecmaVersion: 12,
        sourceType: "module"
      },
      rules: {
        "quotes": ["error", "double"],  // Change to 'double' for double quotes
        "semi": ["error", "always"],    // Change to 'always' to enforce semicolons
        "no-console": "off",
      },
      linterOptions: {
        reportUnusedDisableDirectives: true
      },
    },
  ];
  