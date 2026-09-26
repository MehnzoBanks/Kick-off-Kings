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

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'News',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
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

  final List<String> categories = const [
    'All',
    'Premier League',
    'Champions League',
    'Transfers',
    'World Football',
  ];

  final List<NewsArticle> articles = const [
    NewsArticle(
      category: 'Premier League',
      title: 'Premier League latest news and updates',
      description:
          'Get the latest stories, results and developments from England’s top flight.',
      icon: Icons.emoji_events,
    ),
    NewsArticle(
      category: 'Champions League',
      title: 'Champions League latest updates',
      description:
          'Follow the biggest stories from Europe’s premier club competition.',
      icon: Icons.star,
    ),
    NewsArticle(
      category: 'Transfers',
      title: 'Latest transfer news and rumours',
      description:
          'Keep up with the latest transfer activity from clubs around the world.',
      icon: Icons.swap_horiz,
    ),
    NewsArticle(
      category: 'World Football',
      title: 'World football latest',
      description:
          'The biggest football stories from leagues and competitions around the world.',
      icon: Icons.public,
    ),
    NewsArticle(
      category: 'Premier League',
      title: 'Premier League fixtures and results',
      description:
          'Stay up to date with fixtures, results and important league developments.',
      icon: Icons.sports_soccer,
    ),
    NewsArticle(
      category: 'World Football',
      title: 'Football stories from around the world',
      description:
          'Major football developments, teams, players and competitions.',
      icon: Icons.language,
    ),
  ];

  List<NewsArticle> get filteredArticles {
    if (selectedCategory == 'All') {
      return articles;
    }

    return articles
        .where(
          (article) =>
              article.category == selectedCategory,
        )
        .toList();
  }

  Future<void> refreshNews() async {
    await Future.delayed(
      const Duration(milliseconds: 800),
    );

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = filteredArticles;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshNews,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            16,
            18,
            16,
            30,
          ),
          children: [
            // ------------------------------------------------
            // HEADER
            // ------------------------------------------------

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'News',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF14251F),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: IconButton(
                    onPressed: refreshNews,
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

            const Text(
              'The latest football stories',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 20),

            // ------------------------------------------------
            // CATEGORY FILTERS
            // ------------------------------------------------

            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected =
                      category == selectedCategory;

                  return ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    selectedColor:
                        Colors.green.shade700,
                    backgroundColor:
                        const Color(0xFF12161D),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                    side: BorderSide(
                      color: isSelected
                          ? Colors.green
                          : Colors.white12,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            // ------------------------------------------------
            // FEATURED STORY
            // ------------------------------------------------

            if (filtered.isNotEmpty) ...[
              const Text(
                'Featured',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 10),

              FeaturedNewsCard(
                article: filtered.first,
              ),

              const SizedBox(height: 28),
            ],

            // ------------------------------------------------
            // LATEST NEWS
            // ------------------------------------------------

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Latest News',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Text(
                  '${filtered.length} stories',
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            if (filtered.isEmpty)
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color(0xFF12161D),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 45,
                      color: Colors.white38,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'No news available',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filtered
                  .skip(1)
                  .map(
                    (article) => NewsListCard(
                      article: article,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// NEWS MODEL
// ============================================================

class NewsArticle {
  final String category;
  final String title;
  final String description;
  final IconData icon;

  const NewsArticle({
    required this.category,
    required this.title,
    required this.description,
    required this.icon,
  });
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
    return InkWell(
      borderRadius: BorderRadius.circular(22),
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
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF183D2E),
              Color(0xFF0E1713),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                article.icon,
                size: 170,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent
                          .withOpacity(0.15),
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Text(
                      article.category.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    article.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
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
      margin: const EdgeInsets.only(bottom: 12),
      color: const Color(0xFF12161D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
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
          padding: const EdgeInsets.all(13),
          child: Row(
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: const Color(0xFF183D2E),
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: Icon(
                  article.icon,
                  size: 35,
                  color: Colors.greenAccent,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.category,
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Kickoff Kings • Latest',
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 5),

              const Icon(
                Icons.chevron_right,
                color: Colors.white38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// NEWS DETAIL
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
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: const Color(0xFF183D2E),
            ),
            child: Icon(
              article.icon,
              size: 100,
              color: Colors.greenAccent,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            article.category.toUpperCase(),
            style: const TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.w900,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            article.title,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Kickoff Kings • Latest',
            style: TextStyle(
              color: Colors.white38,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 25),

          Text(
            article.description,
            style: const TextStyle(
              fontSize: 17,
              height: 1.6,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'More football news and updates will appear here as the Kickoff Kings news feed is connected to a live news source.',
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
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



      
