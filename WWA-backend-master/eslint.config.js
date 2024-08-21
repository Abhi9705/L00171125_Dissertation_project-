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
      
  
    },
    linterOptions: {
      reportUnusedDisableDirectives: true
    }
  };
  