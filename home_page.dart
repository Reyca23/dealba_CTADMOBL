import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'article_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Article> _allArticles = [
    Article(
      title: 'Understanding Flutter State Management',
      author: 'Clara',
      date: '10:00 AM',
      preview: 'Learn the differences between ephemeral and app state...',
      content: '''
Flutter offers several state management solutions. The simplest is setState for ephemeral state, 
while Provider or Riverpod are better for app state. Choose based on your app's complexity.

Key differences:
- Ephemeral state: Local to a single widget
- App state: Shared across multiple widgets

Best practices include separating business logic from UI and using immutable data models.
''',
    ),
    Article(
      title: 'Building Beautiful UIs',
      author: 'Mike',
      date: 'Yesterday',
      preview: 'Discover how to create stunning interfaces...',
      content: '''
Creating beautiful UIs in Flutter requires understanding of:
1. Material Design guidelines
2. Custom painting and animations
3. Responsive layout principles

Pro Tips:
- Use ConstrainedBox for responsive layouts
- Leverage the power of CustomPaint
- Implement subtle animations for better UX
''',
    ),
    Article(
      title: 'Advanced Dart Techniques',
      author: 'Emma',
      date: 'Mar 15',
      preview: 'Master advanced Dart programming concepts...',
      content: '''
Advanced Dart features every Flutter developer should know:

1. Extension Methods
   - Add functionality to existing classes
2. Null Safety
   - Write safer, more predictable code
3. Isolates
   - Achieve true parallelism

Remember: Great Flutter code starts with solid Dart fundamentals.
''',
    ),
    Article(
      title: 'Flutter Performance Optimization',
      author: 'Jessica',
      date: 'Mar 10',
      preview: 'Tips and tricks to make your apps run smoother...',
      content: '''
Performance Optimization Checklist:

✅ Minimize widget rebuilds with const constructors
✅ Use ListView.builder for long lists
✅ Avoid large widget trees
✅ Profile with Dart DevTools

Common Pitfalls:
- Unnecessary state changes
- Expensive computations in build()
- Overuse of opacity effects
''',
    ),

    // NEW ARTICLES ADDED BELOW
    Article(
      title: 'Flutter Navigation Deep Dive',
      author: 'David',
      date: 'Mar 8',
      preview: 'Master navigation patterns in Flutter applications...',
      content: '''
Navigation Patterns:
1. Basic Navigation (push/pop)
2. Named Routes
3. Nested Navigation
4. Deep Linking

Pro Tip: Use GoRouter for complex navigation scenarios.
''',
    ),
    Article(
      title: 'Flutter Animations Masterclass',
      author: 'Sophia',
      date: 'Mar 5',
      preview: 'Create stunning animations with Flutter...',
      content: '''
Animation Types:
- Implicit Animations (AnimatedContainer)
- Explicit Animations (AnimationController)
- Physics-based Animations
- Hero Animations

Use the AnimationBuilder for complex sequences.
''',
    ),
    Article(
      title: 'Flutter & Firebase Integration',
      author: 'Ryan',
      date: 'Mar 3',
      preview: 'Connect your Flutter app to Firebase services...',
      content: '''
Firebase Services:
- Authentication
- Firestore Database
- Cloud Storage
- Cloud Functions

Remember to follow security rules best practices.
''',
    ),
    Article(
      title: 'Responsive Flutter Layouts',
      author: 'Olivia',
      date: 'Feb 28',
      preview: 'Design layouts that work on all devices...',
      content: '''
Responsive Techniques:
- MediaQuery for screen sizes
- LayoutBuilder
- Flexible and Expanded widgets
- OrientationBuilder

Test on multiple device sizes during development.
''',
    ),
    Article(
      title: 'Flutter Testing Strategies',
      author: 'Ethan',
      date: 'Feb 25',
      preview: 'Ensure app quality with comprehensive testing...',
      content: '''
Testing Pyramid:
1. Unit Tests
2. Widget Tests
3. Integration Tests
4. Golden Tests

Use mockito for dependency mocking in tests.
''',
    ),
    Article(
      title: 'Flutter Web Development',
      author: 'Ava',
      date: 'Feb 22',
      preview: 'Build web applications with Flutter...',
      content: '''
Web-Specific Considerations:
- Responsive design
- Browser compatibility
- PWA capabilities
- SEO optimization

Use the Flutter web renderer wisely (html vs canvaskit).
''',
    ),
    Article(
      title: 'Flutter Desktop Applications',
      author: 'Noah',
      date: 'Feb 20',
      preview: 'Create native desktop apps with Flutter...',
      content: '''
Platform Integration:
- Windows
- macOS
- Linux

Handle platform-specific features using MethodChannels.
''',
    ),
    Article(
      title: 'Flutter Internationalization',
      author: 'Isabella',
      date: 'Feb 18',
      preview: 'Make your app support multiple languages...',
      content: '''
i18n Process:
1. Add flutter_localizations
2. Create ARB files
3. Generate localization files
4. Implement in UI

Remember RTL (Right-to-Left) language support.
''',
    ),
    Article(
      title: 'Flutter CI/CD Pipeline',
      author: 'Liam',
      date: 'Feb 15',
      preview: 'Automate your Flutter build and deployment...',
      content: '''
CI/CD Tools:
- GitHub Actions
- Codemagic
- Fastlane
- Firebase App Distribution

Always test on both iOS and Android before release.
''',
    ),
    Article(
      title: 'Flutter State Management with Riverpod',
      author: 'Mia',
      date: 'Feb 12',
      preview: 'Modern state management solution for Flutter...',
      content: '''
Riverpod Features:
- Type safety
- Testability
- Scoped providers
- Family modifiers

Combine with Flutter Hooks for maximum efficiency.
''',
    ),
  ];

  List<Article> _filteredArticles = [];
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Recent';

  @override
  void initState() {
    _filteredArticles = _allArticles;
    super.initState();
  }

  void _filterArticles(String query) {
    setState(() {
      _filteredArticles = _allArticles.where((article) {
        final titleLower = article.title.toLowerCase();
        final authorLower = article.author.toLowerCase();
        final previewLower = article.preview.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower) ||
            previewLower.contains(searchLower);
      }).toList();

      // Apply category filter after search
      if (_selectedCategory == 'Popular') {
        _filteredArticles = _filteredArticles.where((article) {
          return article.title.contains('Flutter') ||
              article.title.contains('Dart');
        }).toList();
      } else if (_selectedCategory == 'Bookmarks') {
        // Implement your bookmark logic here
        _filteredArticles = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Articles',
          style: TextStyle(
            fontWeight: FontWeight.bold, // This makes it bold
            fontSize: 25, // Optional: match your design
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme(!isDarkMode);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search articles...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _filterArticles('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
              ),
              onChanged: _filterArticles,
            ),
          ),
          // Category Chips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryButton('Recent',
                      isActive: _selectedCategory == 'Recent'),
                  const SizedBox(width: 8),
                  _buildCategoryButton('Popular',
                      isActive: _selectedCategory == 'Popular'),
                  const SizedBox(width: 8),
                  _buildCategoryButton('Bookmarks',
                      isActive: _selectedCategory == 'Bookmarks'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Articles List
          Expanded(
            child: _filteredArticles.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No articles found',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredArticles.length,
                    itemBuilder: (context, index) {
                      final article = _filteredArticles[index];
                      return _buildArticleCard(article, context);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String text, {bool isActive = false}) {
    return FilterChip(
      label: Text(text),
      selected: isActive,
      onSelected: (_) {
        setState(() {
          _selectedCategory = text;
          _filterArticles(_searchController.text);
        });
      },
      selectedColor: Theme.of(context).colorScheme.primary,
      labelStyle: TextStyle(
        color: isActive ? Colors.white : null,
      ),
    );
  }

  Widget _buildArticleCard(Article article, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => _viewArticleDetails(article, context),
        child: Column(
          children: [
            // Image Placeholder
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 50,
                  color: Colors.grey[600],
                ),
              ),
            ),
            // Article Content
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.preview,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.color
                              ?.withOpacity(0.8),
                        ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          article.author[0],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(article.author),
                      const Spacer(),
                      Text(
                        article.date,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _viewArticleDetails(Article article, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailPage(
          title: article.title,
          author: article.author,
          date: article.date,
          content: article.content,
        ),
      ),
    );
  }
}

class Article {
  final String title;
  final String author;
  final String date;
  final String preview;
  final String content;

  Article({
    required this.title,
    required this.author,
    required this.date,
    required this.preview,
    required this.content,
  });
}
