import 'package:flutter/material.dart';

void main() => runApp(const KickoffKingsApp());

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
        onDestinationSelected: (i) => setState(() => index = i),
        backgroundColor: const Color(0xFF10131A),
        indicatorColor: const Color(0xFF164B3A),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.sports_soccer_outlined), selectedIcon: Icon(Icons.sports_soccer), label: 'Matches'),
          NavigationDestination(icon: Icon(Icons.article_outlined), selectedIcon: Icon(Icons.article), label: 'News'),
          NavigationDestination(icon: Icon(Icons.swap_horiz), label: 'Transfers'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

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
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900, letterSpacing: 1.2),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
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
          const SliverToBoxAdapter(child: SectionTitle('Top Story')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: NewsHero(
                title: 'Football’s biggest stories, all in one place',
                subtitle: 'Breaking news • Transfers • Matches',
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SectionTitle('Latest News')),
          SliverList(
            delegate: SliverChildListDelegate([
              NewsTile(title: 'Transfer window heats up as clubs prepare new moves', category: 'TRANSFERS'),
              NewsTile(title: 'Champions League fixtures and key talking points', category: 'CHAMPIONS LEAGUE'),
              NewsTile(title: 'Premier League teams prepare for the weekend', category: 'PREMIER LEAGUE'),
            ]),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 22, 20, 12),
    child: Text(text, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
  );
}

class CategoryChip extends StatelessWidget {
  final String text;
  final bool active;
  const CategoryChip(this.text, {super.key, this.active = false});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: 8),
    child: Chip(
      label: Text(text),
      backgroundColor: active ? const Color(0xFF16C784) : const Color(0xFF171B23),
      labelStyle: TextStyle(fontWeight: FontWeight.w600, color: active ? Colors.black : Colors.white),
      side: BorderSide.none,
    ),
  );
}

class NewsHero extends StatelessWidget {
  final String title, subtitle;
  const NewsHero({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) => Container(
    height: 210,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(22),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF173B31), Color(0xFF10151B)],
      ),
    ),
    child: Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle, style: const TextStyle(color: Color(0xFF16C784), fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
        ],
      ),
    ),
  );
}

class NewsTile extends StatelessWidget {
  final String title, category;
  const NewsTile({super.key, required this.title, required this.category});

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    leading: Container(
      width: 78, height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFF202632),
      ),
      child: const Icon(Icons.image_outlined, color: Colors.white54),
    ),
    title: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700)),
    subtitle: Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(category, style: const TextStyle(color: Color(0xFF16C784), fontSize: 11, fontWeight: FontWeight.bold)),
    ),
  );
}

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Matches', icon: Icons.sports_soccer, message: 'Live scores, fixtures and results will appear here.');
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'News', icon: Icons.article, message: 'Your football news feed will appear here.');
}

class TransfersPage extends StatelessWidget {
  const TransfersPage({super.key});
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Transfers', icon: Icons.swap_horiz, message: 'Transfer news and rumours will appear here.');
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => const SimplePage(title: 'Profile', icon: Icons.person, message: 'Follow clubs and players and manage notifications.');
}

class SimplePage extends StatelessWidget {
  final String title, message;
  final IconData icon;
  const SimplePage({super.key, required this.title, required this.icon, required this.message});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 60, color: const Color(0xFF16C784)),
          const SizedBox(height: 18),
          Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white60)),
        ]),
      ),
    ),
  );
}
