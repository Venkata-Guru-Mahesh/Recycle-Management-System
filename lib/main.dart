import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;

void main() {
  runApp(const EcoApp());
}

class EcoApp extends StatelessWidget {
  const EcoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco Awareness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

// ================= MAIN =================

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  final screens = const [
    HomePage(),
    SegregationPage(),
    RecyclePage(),
    CompostPage(),
    TipsPage(),
    CentersPage(),
  ];

  void changeTab(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: changeTab,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.delete), label: "Segregation"),
          NavigationDestination(icon: Icon(Icons.recycling), label: "Recycle"),
          NavigationDestination(icon: Icon(Icons.eco), label: "Compost"),
          NavigationDestination(icon: Icon(Icons.lightbulb), label: "Tips"),
          NavigationDestination(
            icon: Icon(Icons.location_on),
            label: "Centers",
          ),
        ],
      ),
    );
  }
}

// ================= HOME =================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void navigate(BuildContext context, int index) {
    final state = context.findAncestorStateOfType<_MainScreenState>();
    state?.changeTab(index);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(title: const Text("Eco Awareness")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.count(
          crossAxisCount: isDesktop ? 4 : 3,
          childAspectRatio: 1.1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            EcoCard("Segregation", Icons.delete, () => navigate(context, 1)),
            EcoCard("Recycle", Icons.recycling, () => navigate(context, 2)),
            EcoCard("Compost", Icons.eco, () => navigate(context, 3)),
            EcoCard("Tips", Icons.lightbulb, () => navigate(context, 4)),
          ],
        ),
      ),
    );
  }
}

class EcoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const EcoCard(this.title, this.icon, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 26, color: Colors.green),
              const SizedBox(height: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= SEGREGATION =================

class SegregationPage extends StatelessWidget {
  const SegregationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Waste Segregation Guide")),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          WasteCard(
            "Wet Waste",
            "Includes food waste like vegetables, fruits, leftover food, tea leaves.\n\n"
                "👉 This waste decomposes naturally and can be used for composting.\n\n"
                "✔ Do: Keep in green bins, use for compost\n"
                "❌ Don’t: Mix with plastic or dry waste",
            Colors.green,
          ),
          WasteCard(
            "Dry Waste",
            "Includes plastic, paper, cardboard, packaging materials.\n\n"
                "👉 These materials can be recycled if properly separated.\n\n"
                "✔ Do: Clean and dry before disposal\n"
                "❌ Don’t: Mix with wet waste",
            Colors.blue,
          ),
          WasteCard(
            "Glass Waste",
            "Includes bottles, jars, broken glass items.\n\n"
                "👉 Glass is 100% recyclable.\n\n"
                "✔ Do: Separate safely\n"
                "❌ Don’t: Throw with general waste",
            Colors.orange,
          ),
          WasteCard(
            "Metal Waste",
            "Includes cans, foil, containers.\n\n"
                "👉 Metals are highly recyclable.\n\n"
                "✔ Do: Clean before recycling\n"
                "❌ Don’t: Mix with organic waste",
            Colors.grey,
          ),
        ],
      ),
    );
  }
}

class WasteCard extends StatelessWidget {
  final String title, desc;
  final Color color;

  const WasteCard(this.title, this.desc, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.2),
                  child: Icon(Icons.delete, color: color),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(desc),
          ],
        ),
      ),
    );
  }
}

// ================= RECYCLE =================

class RecyclePage extends StatelessWidget {
  const RecyclePage({super.key});

  final List<Map<String, String>> videos = const [
    {
      "title": "Plastic Recycling Explained",
      "url": "https://www.youtube.com/watch?v=7l0XHhP6Kp4",
    },
    {
      "title": "Waste Segregation in India",
      "url": "https://www.youtube.com/watch?v=2s8oG9Zb8Qw",
    },
    {
      "title": "Home Composting Guide",
      "url": "https://www.youtube.com/watch?v=1r7g9T3R2gk",
    },
    {
      "title": "Recycling Awareness",
      "url": "https://www.youtube.com/watch?v=OasbYWF4_S8",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recycling Videos")),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: videos.length,
        itemBuilder: (_, i) {
          final video = videos[i];

          return Card(
            child: ListTile(
              leading: const Icon(Icons.play_circle, color: Colors.red),
              title: Text(video["title"]!),
              subtitle: const Text("Tap to watch awareness video"),
              onTap: () {
                html.window.open(video["url"]!, "_blank");
              },
            ),
          );
        },
      ),
    );
  }
}

// ================= COMPOST =================

class CompostPage extends StatelessWidget {
  const CompostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      "Collect kitchen waste",
      "Add dry leaves",
      "Maintain moisture",
      "Turn regularly",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Composting")),
      body: ListView.builder(
        itemCount: steps.length,
        itemBuilder: (_, i) => ListTile(
          leading: const Icon(Icons.eco, color: Colors.green),
          title: Text(steps[i]),
        ),
      ),
    );
  }
}

// ================= TIPS =================

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tips = [
      "Use cloth bags",
      "Avoid plastic",
      "Reuse bottles",
      "Buy eco products",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Eco Tips")),
      body: ListView.builder(
        itemCount: tips.length,
        itemBuilder: (_, i) => ListTile(
          leading: const Icon(Icons.lightbulb),
          title: Text(tips[i]),
        ),
      ),
    );
  }
}

// ================= CENTERS =================

class CentersPage extends StatelessWidget {
  const CentersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final centers = [
      {"name": "Green Center", "place": "Chennai", "phone": "9876543210"},
      {"name": "Eco Hub", "place": "Bangalore", "phone": "9123456780"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Recycling Centers")),
      body: ListView.builder(
        itemCount: centers.length,
        itemBuilder: (_, i) => ListTile(
          leading: const Icon(Icons.location_on),
          title: Text(centers[i]["name"]!),
          subtitle: Text("${centers[i]["place"]} - ${centers[i]["phone"]}"),
        ),
      ),
    );
  }
}
