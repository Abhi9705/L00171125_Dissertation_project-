module.exports = [
    {
      files: ["**/*.js"],
      languageOptions: {
        ecmaVersion: 12,
        sourceType: "module"
      },
      rules: {
        "quotes": ["error", "single", { "avoidEscape": true, "allowTemplateLiterals": true }],
        "semi": "off", // Disable the semicolon rule
        "no-console": "off",
      },
      linterOptions: {
        reportUnusedDisableDirectives: true
      },
    },
  ];
  