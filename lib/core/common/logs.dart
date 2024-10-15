import 'dart:developer' as developer;

void printYellow(String text) {
  developer.log('\x1B[33m$text\x1B[0m');
}

void printRed(String text) {
  developer.log('\x1B[31m$text\x1B[0m');
}

void printCyan(String text) {
  developer.log('\x1B[36m$text\x1B[0m');
}

void printGreen(String text) {
  developer.log('\x1B[32m$text\x1B[0m');
}

// Reset:   \x1B[0m
// Black:   \x1B[30m
// White:   \x1B[37m
// Red:     \x1B[31m
// Green:   \x1B[32m
// Yellow:  \x1B[33m
// Blue:    \x1B[34m
// Cyan:    \x1B[36m
