String generateMapsLink(String input) {
  // Regular expression to find latitude and longitude in the input string
  final latLonRegex = RegExp(r'Lat:\s*([-\d.]+)\s*Lon:\s*([-\d.]+)');

  // Find the first match in the input string
  final match = latLonRegex.firstMatch(input);

  if (match != null) {
    // Extract latitude and longitude from the match
    final latitude = match.group(1);
    final longitude = match.group(2);

    // Return the Google Maps link with the extracted coordinates
    return 'https://www.google.com/maps?q=$latitude,$longitude';
  } else {
    // If no match is found, return an error message or empty string
    return 'Invalid input: No valid latitude and longitude found';
  }
}
