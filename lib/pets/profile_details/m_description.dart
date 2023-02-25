class Description {
  final String text;
  final String languageCode;

  Description(this.text, this.languageCode);

  Description.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        languageCode = json['languageCode'];

  Map<String, dynamic> toJson() => {
        'name': text,
        'email': languageCode,
      };
}
