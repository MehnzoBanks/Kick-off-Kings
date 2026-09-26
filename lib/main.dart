import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const KickoffKings());
}

// ============================================================
// APP
// ============================================================

class KickoffKings extends StatelessWidget {
  const KickoffKings({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kickoff Kings',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.green,
        scaffoldBackgroundColor: const Color(0xFF090B10),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

// ============================================================
// MAIN PAGE
// ============================================================

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selected = 0;

  final pages = const [
    HomePage(),
    MatchesPage(),
    NewsPage(),
    TransfersPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selected],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (index) {
          setState(() {
            selected = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_soccer_outlined),
            selectedIcon: Icon(Icons.sports_soccer),
            label: 'Matches',
          ),
          NavigationDestination(
            icon: Icon(Icons.article_outlined),
            selectedIcon: Icon(Icons.article),
            label: 'News',
          ),
          NavigationDestination(
            icon: Icon(Icons.swap_horiz_outlined),
            selectedIcon: Icon(Icons.swap_horiz),
            label: 'Transfers',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOME
// ============================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'KICKOFF KINGS',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF14251F),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Football Hub',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Live scores, fixtures, news and transfers.',
                  style: TextStyle(
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Latest News',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const NewsItem(
            title: 'Latest football news and updates',
          ),
          const NewsItem(
            title: 'Transfer window latest developments',
          ),
          const NewsItem(
            title: 'Champions League updates',
          ),
        ],
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final String title;

  const NewsItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF12161D),
      child: ListTile(
        leading: const Icon(
          Icons.article,
          color: Colors.green,
        ),
        title: Text(title),
      ),
    );
  }
}

// ============================================================
// LEAGUE MODEL
// ============================================================

class League {
  final int id;
  final String name;
  final String country;
  final IconData icon;

  const League(
    this.id,
    this.name,
    this.country,
    this.icon,
  );
}

const leagues = [
  League(
    39,
    'Premier League',
    'England',
    Icons.emoji_events,
  ),
  League(
    2,
    'Champions League',
    'Europe',
    Icons.star,
  ),
  League(
    140,
    'La Liga',
    'Spain',
    Icons.sports_soccer,
  ),
  League(
    135,
    'Serie A',
    'Italy',
    Icons.sports_soccer,
  ),
  League(
    78,
    'Bundesliga',
    'Germany',
    Icons.sports_soccer,
  ),
  League(
    61,
    'Ligue 1',
    'France',
    Icons.sports_soccer,
  ),
  League(
    3,
    'Europa League',
    'Europe',
    Icons.star_border,
  ),
  League(
    848,
    'Conference League',
    'Europe',
    Icons.star_border,
  ),
];

// ============================================================
// MATCHES - LEAGUE LIST
// ============================================================

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Matches',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select a league',
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              itemCount: leagues.length,
              itemBuilder: (context, index) {
                final league = leagues[index];

                return Card(
                  color: const Color(0xFF12161D),
                  margin: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: CircleAvatar(
                      backgroundColor:
                          const Color(0xFF173A2D),
                      child: Icon(
                        league.icon,
                        color: Colors.greenAccent,
                      ),
                    ),
                    title: Text(
                      league.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(league.country),
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LeaguePage(
                            league: league,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LEAGUE MATCHES
// ============================================================

class LeaguePage extends StatefulWidget {
  final League league;

  const LeaguePage({
    super.key,
    required this.league,
  });

  @override
  State<LeaguePage> createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> {
  late Future<List<FootballMatch>> future;

  @override
  void initState() {
    super.initState();
    future = FootballApi.matches(widget.league.id);
  }

  void reload() {
    setState(() {
      future = FootballApi.matches(widget.league.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.league.name),
        actions: [
          IconButton(
            onPressed: reload,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<FootballMatch>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 50,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: reload,
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          final matches = snapshot.data ?? [];

          if (matches.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                  'No matches found for this league today.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final live = matches
              .where((match) => match.isLive)
              .toList();

          final upcoming = matches
              .where((match) => match.isUpcoming)
              .toList();

          final finished = matches
              .where((match) => match.isFinished)
              .toList();

          return RefreshIndicator(
            onRefresh: () async {
              final newFuture =
                  FootballApi.matches(widget.league.id);

              setState(() {
                future = newFuture;
              });

              await newFuture;
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              children: [
                if (live.isNotEmpty) ...[
                  const StatusHeader(
                    title: 'LIVE',
                    live: true,
                  ),
                  ...live.map(
                    (match) => MatchTile(
                      match: match,
                    ),
                  ),
                ],
                if (upcoming.isNotEmpty) ...[
                  const StatusHeader(
                    title: 'NOT STARTED',
                  ),
                  ...upcoming.map(
                    (match) => MatchTile(
                      match: match,
                    ),
                  ),
                ],
                if (finished.isNotEmpty) ...[
                  const StatusHeader(
                    title: 'FINISHED',
                  ),
                  ...finished.map(
                    (match) => MatchTile(
                      match: match,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// STATUS HEADER
// ============================================================

class StatusHeader extends StatelessWidget {
  final String title;
  final bool live;

  const StatusHeader({
    super.key,
    required this.title,
    this.live = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        18,
        18,
        18,
        8,
      ),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 10,
            color: live ? Colors.red : Colors.green,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: live ? Colors.red : Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MATCH TILE
// ============================================================

class MatchTile extends StatelessWidget {
  final FootballMatch match;

  const MatchTile({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      color: const Color(0xFF12161D),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    match.league,
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 11,
                    ),
                  ),
                ),
                Text(
                  match.isLive
                      ? 'LIVE'
                      : match.isFinished
                          ? 'FT'
                          : match.time,
                  style: TextStyle(
                    color: match.isLive
                        ? Colors.red
                        : Colors.white60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Team(
                    name: match.home,
                    logo: match.homeLogo,
                  ),
                ),
                SizedBox(
                  width: 75,
                  child: Text(
                    '${match.homeScore} - ${match.awayScore}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Expanded(
                  child: Team(
                    name: match.away,
                    logo: match.awayLogo,
                    right: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TEAM
// ============================================================

class Team extends StatelessWidget {
  final String name;
  final String logo;
  final bool right;

  const Team({
    super.key,
    required this.name,
    required this.logo,
    this.right = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: right
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        if (logo.isNotEmpty)
          Image.network(
            logo,
            width: 32,
            height: 32,
            errorBuilder: (_, __, ___) {
              return const Icon(
                Icons.shield,
                size: 32,
              );
            },
          )
        else
          const Icon(
            Icons.shield,
            size: 32,
          ),
        const SizedBox(height: 5),
        Text(
          name,
          textAlign:
              right ? TextAlign.right : TextAlign.left,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// MATCH MODEL
// ============================================================

class FootballMatch {
  final String league;
  final String home;
  final String away;
  final String homeLogo;
  final String awayLogo;
  final String homeScore;
  final String awayScore;
  final String status;
  final DateTime date;

  FootballMatch({
    required this.league,
    required this.home,
    required this.away,
    required this.homeLogo,
    required this.awayLogo,
    required this.homeScore,
    required this.awayScore,
    required this.status,
    required this.date,
  });

  factory FootballMatch.fromJson(
    Map<String, dynamic> json,
  ) {
    final fixture = json['fixture'] ?? {};
    final teams = json['teams'] ?? {};
    final home = teams['home'] ?? {};
    final away = teams['away'] ?? {};
    final goals = json['goals'] ?? {};
    final league = json['league'] ?? {};
    final status = fixture['status'] ?? {};

    return FootballMatch(
      league: league['name']?.toString() ?? 'Football',
      home: home['name']?.toString() ?? 'Home',
      away: away['name']?.toString() ?? 'Away',
      homeLogo: home['logo']?.toString() ?? '',
      awayLogo: away['logo']?.toString() ?? '',
      homeScore: goals['home']?.toString() ?? '-',
      awayScore: goals['away']?.toString() ?? '-',
      status: status['short']?.toString() ?? 'NS',
      date: DateTime.tryParse(
            fixture['date']?.toString() ?? '',
          )?.toLocal() ??
          DateTime.now(),
    );
  }

  bool get isLive {
    return [
      '1H',
      'HT',
      '2H',
      'ET',
      'BT',
      'P',
      'LIVE',
    ].contains(status);
  }

  bool get isFinished {
    return [
      'FT',
      'AET',
      'PEN',
      'AWD',
      'WO',
    ].contains(status);
  }

  bool get isUpcoming {
    return !isLive && !isFinished;
  }

  String get time {
    final hour =
        date.hour.toString().padLeft(2, '0');
    final minute =
        date.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }
}

// ============================================================
// FOOTBALL API
// ============================================================

class FootballApi {
  static const String key = String.fromEnvironment(
    'API_FOOTBALL_KEY',
  );

  // CORRECT API-FOOTBALL URL
  static const String base =
      'https://v3.football.api-sports.io';

  static Future<List<FootballMatch>> matches(
    int leagueId,
  ) async {
    if (key.isEmpty) {
      throw Exception(
        'API football key is missing. '
        'Make sure API_FOOTBALL_KEY is configured.',
      );
    }

    final now = DateTime.now();

    // Football seasons normally start around August.
    // For January-July, use the previous season.
    final season =
        now.month < 8 ? now.year - 1 : now.year;

    final date =
        '${now.year.toString().padLeft(4, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';

    final uri = Uri.parse(
      '$base/fixtures'
      '?league=$leagueId'
      '&season=$season'
      '&date=$date',
    );

    final response = await http.get(
      uri,
      headers: {
        'x-apisports-key': key,
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Football API error: ${response.statusCode}',
      );
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body);

    if (data['errors'] is Map &&
        (data['errors'] as Map).isNotEmpty) {
      throw Exception(
        'Football API error: ${data['errors']}',
      );
    }

    final responseList = data['response'];

    if (responseList is! List) {
      return [];
    }

    return responseList
        .map(
          (item) => FootballMatch.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}

// ============================================================
// NEWS PAGE
// ============================================================

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String selectedCategory = 'All';

  late Future<List<NewsArticle>> newsFuture;

  final List<String> categories = [
    'All',
    'Premier League',
    'Champions League',
    'Transfers',
    'World Football',
  ];

  @override
  void initState() {
    super.initState();
    newsFuture = NewsApi.fetchNews('football');
  }

  void loadCategory(String category) {
    setState(() {
      selectedCategory = category;

      String query;

      switch (category) {
        case 'Premier League':
          query = 'football AND "Premier League"';
          break;

        case 'Champions League':
          query = 'football AND "Champions League"';
          break;

        case 'Transfers':
          query =
              'football AND (transfer OR signing OR "transfer window")';
          break;

        case 'World Football':
          query = 'football';
          break;

        default:
          query = 'football';
      }

      newsFuture = NewsApi.fetchNews(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F0D),
        title: const Text(
          'Football News',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 55,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final selected = category == selectedCategory;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selected,
                    onSelected: (_) {
                      loadCategory(category);
                    },
                    selectedColor: Colors.green,
                    backgroundColor: const Color(0xFF1A211D),
                    labelStyle: TextStyle(
                      color: selected
                          ? Colors.white
                          : Colors.white70,
                      fontWeight: selected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: FutureBuilder<List<NewsArticle>>(
              future: newsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        snapshot.error.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  );
                }

                final articles = snapshot.data ?? [];

                if (articles.isEmpty) {
                  return const Center(
                    child: Text(
                      'No football stories found.',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  color: Colors.green,
                  onRefresh: () async {
                    setState(() {
                      loadCategory(selectedCategory);
                    });
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(12),
                    children: [
                      FeaturedNewsCard(
                        article: articles.first,
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        'Latest News',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      ...articles.skip(1).map(
                        (article) => NewsListCard(
                          article: article,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// NEWS API
// ============================================================

class NewsApi {
  static const String key =
      String.fromEnvironment('GNEWS_API_KEY');

  static const String base =
      'https://gnews.io/api/v4/search';

  static Future<List<NewsArticle>> fetchNews(
    String query,
  ) async {
    if (key.isEmpty) {
      throw Exception(
        'GNews API key is missing. Check GNEWS_API_KEY in GitHub Actions.',
      );
    }

    final uri = Uri.parse(base).replace(
      queryParameters: {
        'q': query,
        'lang': 'en',
        'max': '10',
        'sortby': 'publishedAt',
        'nullable': 'image,description',
        'apikey': key,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      String message = response.body;

      try {
        final errorData = jsonDecode(response.body);

        if (errorData is Map &&
            errorData['errors'] != null) {
          message = errorData['errors'].toString();
        }
      } catch (_) {}

      throw Exception(
        'GNews error ${response.statusCode}: $message',
      );
    }

    final data = jsonDecode(response.body);

    final articles = data['articles'];

    if (articles is! List) {
      return [];
    }

    return articles
        .map(
          (item) => NewsArticle.fromJson(
            Map<String, dynamic>.from(item),
          ),
        )
        .toList();
  }
}

// ============================================================
// NEWS ARTICLE MODEL
// ============================================================

class NewsArticle {
  final String category;
  final String title;
  final String description;
  final String imageUrl;
  final String articleUrl;
  final String source;
  final DateTime? publishedAt;
  final IconData icon;

  NewsArticle({
    required this.category,
    required this.title,
    required this.description,
    this.imageUrl = '',
    this.articleUrl = '',
    this.source = 'GNews',
    this.publishedAt,
    this.icon = Icons.sports_soccer,
  });

  factory NewsArticle.fromJson(
    Map<String, dynamic> json,
  ) {
    final title =
        json['title']?.toString() ?? 'Football News';

    final description =
        json['description']?.toString() ?? '';

    final content =
        '$title $description'.toLowerCase();

    return NewsArticle(
      category: detectCategory(content),
      title: title,
      description: description,
      imageUrl:
          json['image']?.toString() ?? '',
      articleUrl:
          json['url']?.toString() ?? '',
      source:
          json['source']?['name']?.toString() ?? 'GNews',
      publishedAt:
          DateTime.tryParse(
        json['publishedAt']?.toString() ?? '',
      ),
      icon: detectIcon(content),
    );
  }

  static String detectCategory(String text) {
    if (text.contains('transfer') ||
        text.contains('signing') ||
        text.contains('transfer window')) {
      return 'Transfers';
    }

    if (text.contains('champions league')) {
      return 'Champions League';
    }

    if (text.contains('premier league')) {
      return 'Premier League';
    }

    return 'World Football';
  }

  static IconData detectIcon(String text) {
    if (text.contains('transfer') ||
        text.contains('signing')) {
      return Icons.swap_horiz;
    }

    if (text.contains('champions league')) {
      return Icons.emoji_events;
    }

    if (text.contains('premier league')) {
      return Icons.sports_soccer;
    }

    return Icons.public;
  }
}

// ============================================================
// FEATURED NEWS CARD
// ============================================================

class FeaturedNewsCard extends StatelessWidget {
  final NewsArticle article;

  const FeaturedNewsCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NewsDetailPage(
              article: article,
            ),
          ),
        );
      },
      child: Container(
        height: 240,
        decoration: BoxDecoration(
          color: const Color(0xFF17201A),
          borderRadius: BorderRadius.circular(18),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: article.imageUrl.isNotEmpty
                  ? Image.network(
                      article.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.sports_soccer,
                            size: 70,
                            color: Colors.green,
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Icon(
                        Icons.sports_soccer,
                        size: 70,
                        color: Colors.green,
                      ),
                    ),
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Text(
                      article.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    article.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '${article.source} • ${formatNewsTime(article.publishedAt)}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ============================================================
// NEWS LIST CARD
// ============================================================

class NewsListCard extends StatelessWidget {
  final NewsArticle article;

  const NewsListCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF151B17),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NewsDetailPage(
                article: article,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(10),
                child: SizedBox(
                  width: 105,
                  height: 85,
                  child: article.imageUrl.isNotEmpty
                      ? Image.network(
                          article.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) {
                            return Icon(
                              article.icon,
                              size: 40,
                              color: Colors.green,
                            );
                          },
                        )
                      : Icon(
                          article.icon,
                          size: 40,
                          color: Colors.green,
                        ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.category,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      article.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      '${article.source} • ${formatNewsTime(article.publishedAt)}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ============================================================
// NEWS DETAIL PAGE
// ============================================================

class NewsDetailPage extends StatelessWidget {
  final NewsArticle article;

  const NewsDetailPage({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F0D),
        title: const Text('News'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            if (article.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  article.imageUrl,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) {
                    return Container(
                      height: 220,
                      color: const Color(0xFF17201A),
                      child: Center(
                        child: Icon(
                          article.icon,
                          size: 70,
                          color: Colors.green,
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF17201A),
                  borderRadius:
                      BorderRadius.circular(16),
                ),
                child: Center(
                  child: Icon(
                    article.icon,
                    size: 70,
                    color: Colors.green,
                  ),
                ),
              ),

            const SizedBox(height: 18),

            Text(
              article.category,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              article.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              '${article.source} • ${formatNewsTime(article.publishedAt)}',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              article.description.isNotEmpty
                  ? article.description
                  : 'No description available for this story.',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            if (article.articleUrl.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Opening the original article will be added next.',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.open_in_new),
                  label: const Text(
                    'READ ORIGINAL ARTICLE',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


// ============================================================
// NEWS TIME FORMAT
// ============================================================

String formatNewsTime(DateTime? date) {
  if (date == null) {
    return 'Recently';
  }

  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inMinutes < 1) {
    return 'Just now';
  }

  if (difference.inMinutes < 60) {
    return '${difference.inMinutes}m ago';
  }

  if (difference.inHours < 24) {
    return '${difference.inHours}h ago';
  }

  if (difference.inDays < 7) {
    return '${difference.inDays}d ago';
  }

  return '${date.day}/${date.month}/${date.year}';
}

// ============================================================
// TRANSFERS PAGE
// ============================================================

class TransfersPage extends StatelessWidget {
  const TransfersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Transfers',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Latest transfer activity',
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 20),
          const TransferCard(
            player: 'Transfer Updates',
            detail:
                'Latest football transfer news will appear here.',
          ),
          const TransferCard(
            player: 'Transfer Window',
            detail:
                'Follow major moves between clubs.',
          ),
        ],
      ),
    );
  }
}

class TransferCard extends StatelessWidget {
  final String player;
  final String detail;

  const TransferCard({
    super.key,
    required this.player,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF12161D),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF173A2D),
          child: Icon(
            Icons.swap_horiz,
            color: Colors.greenAccent,
          ),
        ),
        title: Text(
          player,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(detail),
        ),
      ),
    );
  }
}
// ============================================================
// PROFILE PAGE
// ============================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 25),
          const CircleAvatar(
            radius: 45,
            backgroundColor: Color(0xFF173A2D),
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.greenAccent,
            ),
          ),
          const SizedBox(height: 15),
          const Center(
            child: Text(
              'Football Fan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Card(
            color: const Color(0xFF12161D),
            child: ListTile(
              leading: const Icon(
                Icons.notifications_outlined,
              ),
              title: const Text('Notifications'),
              trailing: Switch(
                value: true,
                onChanged: (_) {},
              ),
            ),
          ),
          Card(
            color: const Color(0xFF12161D),
            child: const ListTile(
              leading: Icon(
                Icons.info_outline,
              ),
              title: Text('About Kickoff Kings'),
              trailing: Icon(
                Icons.chevron_right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



      
