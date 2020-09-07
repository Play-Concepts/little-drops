class StoryChapter {
  String chapterName;
  String chapterDetails;
  String score;

  StoryChapter({
    this.chapterName,
    this.chapterDetails,
    this.score,
  });
}

List<StoryChapter> chapters = [
  StoryChapter(
      chapterName: 'Introduction',
      chapterDetails: 'Introduction to geography',
      score: '81'),
  StoryChapter(
      chapterName: 'Maps type & Usages',
      chapterDetails: 'Learn about maps type & how to use each...',
      score: '79'),
  StoryChapter(
      chapterName: 'Population & Country',
      chapterDetails: 'Learn the worldwide population & country...',
      score: '80'),
  StoryChapter(
      chapterName: 'Climate ',
      chapterDetails: 'Learn about climate...',
      score: '60'),
  StoryChapter(
      chapterName: 'Earth-forming Process ',
      chapterDetails: 'Learn how the earth-forming process be...',
      score: '56'),
  StoryChapter(
      chapterName: 'Rocks',
      chapterDetails: 'Learn the type of the rocks,and their spec...',
      score: '90'),
  StoryChapter(
      chapterName: 'Earthquake',
      chapterDetails: 'Learn about seismology...',
      score: '90'),
];
