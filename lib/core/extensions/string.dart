extension StringHelpers on String {
  firstLetterCapitalized() {
    return this[0].toUpperCase() + substring(1, length).toLowerCase();
  }
}
