import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const KickoffKingsApp());
}

// ============================================================
// APP
// ============================================================

class KickoffKingsApp extends StatelessWidget {
  const KickoffKingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kickoff Kings',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090B10),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF16C784),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MainShell(),
    );
  }
}

// ============================================================
// MAIN NAVIGATION
// ============================================================

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

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
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) {
          setState(() {
            index = i;
          });
        },
        backgroundColor: const Color(0xFF10131A),
        indicatorColor: const Color(0xFF164B3A),
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
            icon: Icon(Icons.swap_horiz),
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
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'KICKOFF KINGS',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 42,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                children: const [
                  CategoryChip('All', active: true),
                  CategoryChip('Premier League'),
                  CategoryChip('Champions League'),
                  CategoryChip('La Liga'),
                  CategoryChip('Transfers'),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SectionTitle('Top Story'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: NewsHero(
                title: 'Football’s biggest stories, all in one place',
                subtitle: 'Breaking news • Transfers • Matches',
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SectionTitle('Latest News'),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              NewsTile(
                title: 'Transfer window heats up as clubs prepare new moves',
                category: 'TRANSFERS',
              ),
              NewsTile(
                title: 'Champions League fixtures and key talking points',
                category: 'CHAMPIONS LEAGUE',
              ),
              NewsTile(
                title: 'Premier League teams prepare for the weekend',
                category: 'PREMIER LEAGUE',
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MATCHES - LEAGUE LIST
// ============================================================

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Matches',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AllMatchesPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.public),
                    tooltip: 'All matches',
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Text(
                'Top Leagues',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final league = topLeagues[index];

                  return LeagueCard(
                    league: league,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LeagueMatchesPage(
                            league: league,
                          ),
                        ),
                      );
                    },
                  );
                },
                childCount: topLeagues.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TOP LEAGUES
// ============================================================

class LeagueInfo {
  final int id;
  final String name;
  final String country;
  final String logo;

  const LeagueInfo({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
  });
}

const List<LeagueInfo> topLeagues = [
  LeagueInfo(
    id: 39,
    name: 'Premier League',
    country: 'England',
    logo: 'https://media.api-sports.io/football/leagues/39.png',
  ),
  LeagueInfo(
    id: 140,
    name: 'La Liga',
    country: 'Spain',
    logo: 'https://media.api-sports.io/football/leagues/140.png',
  ),
  LeagueInfo(
    id: 135,
    name: 'Serie A',
    country: 'Italy',
    logo: 'https://media.api-sports.io/football/leagues/135.png',
  ),
  LeagueInfo(
    id: 78,
    name: 'Bundesliga',
    country: 'Germany',
    logo: 'https://media.api-sports.io/football/leagues/78.png',
  ),
  LeagueInfo(
    id: 61,
    name: 'Ligue 1',
    country: 'France',
    logo: 'https://media.api-sports.io/football/leagues/61.png',
  ),
  LeagueInfo(
    id: 2,
    name: 'Champions League',
    country: 'Europe',
    logo: 'https://media.api-sports.io/football/leagues/2.png',
  ),
  LeagueInfo(
    id: 3,
    name: 'Europa League',
    country: 'Europe',
    logo: 'https://media.api-sports.io/football/leagues/3.png',
  ),
  LeagueInfo(
    id: 848,
    name: 'Conference League',
    country: 'Europe',
    logo: 'https://media.api-sports.io/football/leagues/848.png',
  ),
  LeagueInfo(
    id: 253,
    name: 'MLS',
    country: 'USA',
    logo: 'https://media.api-sports.io/football/leagues/253.png',
  ),
  LeagueInfo(
    id: 399,
    name: 'NPFL',
    country: 'Nigeria',
    logo: 'https://media.api-sports.io/football/leagues/399.png',
  ),
];

// ============================================================
// LEAGUE CARD
// ============================================================

class LeagueCard extends StatelessWidget {
  final LeagueInfo league;
  final VoidCallback onTap;

  const LeagueCard({
    super.key,
    required this.league,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: const Color(0xFF12161D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2029),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Image.network(
                  league.logo,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) {
                    return const Icon(
                      Icons.emoji_events_outlined,
                      color: Color(0xFF16C784),
                      size: 30,
                    );
                  },
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      league.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      league.country,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.white54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// LEAGUE MATCHES PAGE
// ============================================================

class LeagueMatchesPage extends StatefulWidget {
  final LeagueInfo league;

  const LeagueMatchesPage({
    super.key,
    required this.league,
  });

  @override
  State<LeagueMatchesPage> createState() => _LeagueMatchesPageState();
}

class _LeagueMatchesPageState extends State<LeagueMatchesPage> {
  late Future<List<FootballMatch>> matches;

  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    matches = FootballApi.getLeagueFixtures(widget.league.id);
  }

  Future<void> refresh() async {
    setState(() {
      matches = FootballApi.getLeagueFixtures(widget.league.id);
    });

    await matches;
  }

  List<FootballMatch> filterMatches(
    List<FootballMatch> data,
  ) {
    if (selectedTab == 0) {
      return data.where((m) => m.isUpcoming).toList();
    }

    if (selectedTab == 1) {
      return data.where((m) => m.isLive).toList();
    }

    return data.where((m) => m.isFinished).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090B10),
      appBar: AppBar(
        backgroundColor: const Color(0xFF090B10),
        title: Text(
          widget.league.name,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 6),

          // LEAGUE HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF12161D),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Image.network(
                    widget.league.logo,
                    width: 48,
                    height: 48,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) {
                      return const Icon(
                        Icons.emoji_events,
                        size: 42,
                        color: Color(0xFF16C784),
                      );
                    },
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.league.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.league.country,
                          style: const TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          // TABS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                MatchTab(
                  title: 'Upcoming',
                  selected: selectedTab == 0,
                  onTap: () {
                    setState(() {
                      selectedTab = 0;
                    });
                  },
                ),
                const SizedBox(width: 8),
                MatchTab(
                  title: 'Live',
                  selected: selectedTab == 1,
                  live: true,
                  onTap: () {
                    setState(() {
                      selectedTab = 1;
                    });
                  },
                ),
                const SizedBox(width: 8),
                MatchTab(
                  title: 'Finished',
                  selected: selectedTab == 2,
                  onTap: () {
                    setState(() {
                      selectedTab = 2;
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: FutureBuilder<List<FootballMatch>>(
              future: matches,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return ErrorBox(
                    message: snapshot.error.toString(),
                    onRetry: refresh,
                  );
                }

                final allMatches = snapshot.data ?? [];
                final filtered = filterMatches(allMatches);

                if (filtered.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: refresh,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 130),
                        EmptyBox(
                          message: 'No matches in this section today.',
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                      top: 4,
                      bottom: 20,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return MatchTile(
                        match: filtered[index],
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
// MATCH TABS
// ============================================================

class MatchTab extends StatelessWidget {
  final String title;
  final bool selected;
  final bool live;
  final VoidCallback onTap;

  const MatchTab({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
    this.live = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 6,
          ),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF16C784)
                : const Color(0xFF171B23),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (live)
                Container(
                  width: 7,
                  height: 7,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              Text(
                title,
                style: TextStyle(
                  color: selected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
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
// ALL MATCHES
// ============================================================

class AllMatchesPage extends StatefulWidget {
  const AllMatchesPage({super.key});

  @override
  State<AllMatchesPage> createState() => _AllMatchesPageState();
}

class _AllMatchesPageState extends State<AllMatchesPage> {
  late Future<List<FootballMatch>> matches;

  @override
  void initState() {
    super.initState();
    matches = FootballApi.getTodayFixtures();
  }

  Future<void> refresh() async {
    setState(() {
      matches = FootballApi.getTodayFixtures();
    });

    await matches;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090B10),
      appBar: AppBar(
        title: const Text('All Matches'),
        backgroundColor: const Color(0xFF090B10),
      ),
      body: FutureBuilder<List<FootballMatch>>(
        future: matches,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return ErrorBox(
              message: snapshot.error.toString(),
              onRetry: refresh,
            );
          }

          final data = snapshot.data ?? [];

          if (data.isEmpty) {
            return const EmptyBox(
              message: 'No matches found today.',
            );
          }

          return RefreshIndicator(
            onRefresh: refresh,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return MatchTile(match: data[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// API
// ============================================================

class FootballApi {
  static const String apiKey =
      String.fromEnvironment('API_FOOTBALL_KEY');

  static const String baseUrl =
      'https://v3.football.api-sports.io';

  static Future<List<FootballMatch>> getTodayFixtures() async {
    if (apiKey.isEmpty) {
      throw Exception(
        'API key was not included in this build.',
      );
    }

    final now = DateTime.now();

    final date =
        '${now.year.toString().padLeft(4, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';

    final uri = Uri.parse(
      '$baseUrl/fixtures'
      '?date=$date'
      '&timezone=Africa/Lagos',
    );

    final response = await http.get(
      uri,
      headers: {
        'x-apisports-key': apiKey,
      },
    );

    return _parseResponse(response);
  }

  static Future<List<FootballMatch>> getLeagueFixtures(
    int leagueId,
  ) async {
    if (apiKey.isEmpty) {
      throw Exception(
        'API key was not included in this build.',
      );
    }

    final now = DateTime.now();

    final date =
        '${now.year.toString().padLeft(4, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';

    final uri = Uri.parse(
      '$baseUrl/fixtures'
      '?league=$leagueId'
      '&date=$date'
      '&timezone=Africa/Lagos',
    );

    final response = await http.get(
      uri,
      headers: {
        'x-apisports-key': apiKey,
      },
    );

    return _parseResponse(response);
  }

  static List<FootballMatch> _parseResponse(
    http.Response response,
  ) {
    if (response.statusCode != 200) {
      throw Exception(
        'Football API error: ${response.statusCode}',
      );
    }

    final json = jsonDecode(response.body);

    final errors = json['errors'];

    if (errors is List && errors.isNotEmpty) {
      throw Exception('API error: $errors');
    }

    if (errors is Map && errors.isNotEmpty) {
      throw Exception('API error: $errors');
    }

    final List<dynamic> responseData =
        json['response'] ?? [];

    return responseData
        .map(
          (item) => FootballMatch.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}

// ============================================================
// MATCH MODEL
// ============================================================

class FootballMatch {
  final String league;
  final String homeTeam;
  final String awayTeam;

  final String homeLogo;
  final String awayLogo;

  final String homeScore;
  final String awayScore;

  final String status;
  final int? elapsed;

  final DateTime? kickoff;

  FootballMatch({
    required this.league,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeLogo,
    required this.awayLogo,
    required this.homeScore,
    required this.awayScore,
    required this.status,
    required this.elapsed,
    required this.kickoff,
  });

  factory FootballMatch.fromJson(
    Map<String, dynamic> json,
  ) {
    final fixture =
        json['fixture'] as Map<String, dynamic>? ?? {};

    final teams =
        json['teams'] as Map<String, dynamic>? ?? {};

    final goals =
        json['goals'] as Map<String, dynamic>? ?? {};

    final leagueData =
        json['league'] as Map<String, dynamic>? ?? {};

    final home =
        teams['home'] as Map<String, dynamic>? ?? {};

    final away =
        teams['away'] as Map<String, dynamic>? ?? {};

    final statusData =
        fixture['status'] as Map<String, dynamic>? ?? {};

    DateTime? kickoff;

    final dateValue = fixture['date'];

    if (dateValue is String) {
      kickoff = DateTime.tryParse(dateValue)?.toLocal();
    }

    return FootballMatch(
      league: leagueData['name']?.toString()
