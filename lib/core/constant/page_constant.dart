import '../../features/auth/introduction/model/page_model.dart';

class IntroPage {
  static Page firstPage = Page(
    title: 'Welcome to Infinity Academy',
    body:
        'Discover a new way of learning with Infinity Academy. Our platform offers a wide range of courses and resources to help you achieve your educational goals for 10th and 12th pass Student',
    path: 'assets/intro/app.json',
  );

  static Page secondPage = Page(
    title: 'Interactive Learning',
    body:
        'Engage with interactive lessons and quizzes designed to make learning fun and effective. Track your progress and stay motivated.',
    path: 'assets/intro/work.json',
  );

  static Page thirdPage = Page(
    title: 'Join Our Community',
    body:
        'Connect with fellow learners and educators. Share your knowledge, ask questions, and collaborate on projects to enhance your learning experience.',
    path: 'assets/intro/commerce.json',
  );
}
