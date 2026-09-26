import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const KickoffKings());
}

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
        onDestinationSelected: (i) {
          setState(() => selected = i);
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
                  style: TextStyle(color: Colors.white60),
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
// LEAGUES
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
// MATCHES - LEAGUE LIST FIRST
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
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: leagues.length,
              itemBuilder: (context, index) {
                final league = leagues[index];

                return Card(
                  color: const Color(0xFF12161D),
                  margin: const EdgeInsets.only(bottom: 10),
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
                    trailing:
                        const Icon(Icons.chevron_right),
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
              child: Text(
                'No matches found for this league today.',
              ),
            );
          }

          final live =
              matches.where((m) => m.isLive).toList();

          final upcoming =
              matches.where((m) => m.isUpcoming).toList();

          final finished =
              matches.where((m) => m.isFinished).toList();

          return RefreshIndicator(
            onRefresh: () async {
              reload();
              await future;
            },
            child: ListView(
              padding: const EdgeInsets.only(bottom: 20),
              children: [
                if (live.isNotEmpty) ...[
                  const StatusHeader(
                    title: 'LIVE',
                    live: true,
                  ),
                  ...live.map(
                    (m) => MatchTile(match: m),
                  ),
                ],
                if (upcoming.isNotEmpty) ...[
                  const StatusHeader(
                    title: 'NOT STARTED',
                  ),
                  ...upcoming.map(
                    (m) => MatchTile(match: m),
                  ),
                ],
                if (finished.isNotEmpty) ...[
                  const StatusHeader(
                    title: 'FINISHED',
                  ),
                  ...finished.map(
                    (m) => MatchTile(match: m),
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
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
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
      crossAxisAlignment:
          right ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (logo.isNotEmpty)
          Image.network(
            logo,
            width: 32,
            height: 32,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.shield, size: 32),
          )
        else
          const Icon(Icons.shield, size: 32),
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
    final h = date.hour.toString().padLeft(2, '0');
    final m = date.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

// ============================================================
// API
// ============================================================

class FootballApi {
  static const key =
      String.fromEnvironment('API_FOOTBALL_KEY');

  static const base =
      'https://v3.football.api-s
