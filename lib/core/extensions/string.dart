extension StringHelpers on String {
  firstLetterCapitalized() {
    return this[0].toUpperCase() + this.substring(0, this.length).toLowerCase();
  }
}
