int calculateReadingTime(String content){
  final int wordcount = content.split(RegExp(r'\s+')).length;
  final int readingTime = (wordcount / 200).ceil();
  return readingTime;
}