import 'package:flutter/material.dart';

// EXPERIMENT 4(a): Set up navigation between different screens using Navigator.
// Remodeled with a Vibrant & Creative Campus aesthetic featuring dynamic
// gradient hero, quick lab statistics, and interactive experiment module cards.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color _indigo = Color(0xFF4338CA);
  static const Color _violet = Color(0xFF7C3AED);
  static const Color _coral = Color(0xFFF43F5E);
  static const Color _amber = Color(0xFFF59E0B);
  static const Color _navy = Color(0xFF0F172A);
  static const Color _muted = Color(0xFF64748B);
  static const Color _bgSoft = Color(0xFFF8FAFC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgSoft,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_indigo, _coral],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _indigo.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.school, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Campus Connect',
                  style: TextStyle(
                    color: _navy,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  'Student Portal & Lab Navigator',
                  style: TextStyle(
                    color: _muted,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(Icons.notifications_none_rounded, color: _navy),
              tooltip: 'Announcements',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('🎉 All lab experiment modules are active and running!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ---------------- HERO BANNER ----------------
                _buildHeroBanner(context),
                const SizedBox(height: 22),

                // ---------------- QUICK STATS / HIGHLIGHTS ----------------
                _buildHighlightsGrid(),
                const SizedBox(height: 28),

                // ---------------- SECTION HEADER ----------------
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE9FE),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.auto_awesome, color: _violet, size: 18),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Lab Experiments & Demos',
                      style: TextStyle(
                        color: _navy,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFFDE68A)),
                      ),
                      child: const Text(
                        '3 Active Modules',
                        style: TextStyle(
                          color: Color(0xFFB45309),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // ---------------- EXPERIMENT MODULE CARDS ----------------
                _buildModuleCard(
                  context: context,
                  badgeText: 'EXPERIMENT 2 • UI BASICS',
                  badgeColor: const Color(0xFFFFFBEB),
                  badgeTextColor: const Color(0xFFB45309),
                  badgeBorderColor: const Color(0xFFFDE68A),
                  iconGradient: const [Color(0xFFF59E0B), Color(0xFFEA580C)],
                  icon: Icons.widgets_rounded,
                  title: 'Widgets & Layouts Demo',
                  description:
                      'Explore fundamental Flutter building blocks: Text, Image, Container, Row, Column, and Stack layouts.',
                  features: const ['Container & Border', 'Row & Column', 'Stack Overlay', 'Typography'],
                  actionIcon: Icons.widgets,
                  actionLabel: 'Widgets & Layouts Demo',
                  buttonColor: const Color(0xFFEA580C),
                  onPressed: () => Navigator.pushNamed(context, '/widgets'),
                ),
                const SizedBox(height: 16),

                _buildModuleCard(
                  context: context,
                  badgeText: 'EXPERIMENT 3 • ADAPTIVE UI',
                  badgeColor: const Color(0xFFECFEFF),
                  badgeTextColor: const Color(0xFF0E7490),
                  badgeBorderColor: const Color(0xFFA5F3FC),
                  iconGradient: const [Color(0xFF06B6D4), Color(0xFF2563EB)],
                  icon: Icons.devices_rounded,
                  title: 'Responsive UI Demo',
                  description:
                      'Dynamic adaptive layouts using MediaQuery and LayoutBuilder responding seamlessly to mobile, tablet & desktop.',
                  features: ['MediaQuery Breakpoints', 'LayoutBuilder', 'Adaptive Grid', 'Screen Metrics'],
                  actionIcon: Icons.phone_android,
                  actionLabel: 'Responsive UI Demo',
                  buttonColor: const Color(0xFF2563EB),
                  onPressed: () => Navigator.pushNamed(context, '/responsive'),
                ),
                const SizedBox(height: 16),

                _buildModuleCard(
                  context: context,
                  badgeText: 'EXPERIMENT 4 • ROUTING & ARGS',
                  badgeColor: const Color(0xFFFDF2F8),
                  badgeTextColor: const Color(0xFFBE185D),
                  badgeBorderColor: const Color(0xFFFBCFE8),
                  iconGradient: const [Color(0xFF8B5CF6), Color(0xFFF43F5E)],
                  icon: Icons.badge_rounded,
                  title: 'Go to Profile',
                  description:
                      'Pass named route arguments (name: Aarav, year: III) to render an interactive student profile with banner and bio.',
                  features: ['Named Route Push', 'Route Arguments', 'Profile Card', 'Academic Stats'],
                  actionIcon: Icons.person,
                  actionLabel: 'Go to Profile',
                  buttonColor: const Color(0xFF7C3AED),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    '/profile',
                    arguments: {'name': 'Aarav', 'year': 'III'},
                  ),
                ),
                const SizedBox(height: 24),

                // ---------------- CAMPUS TIP / PROMPT ----------------
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x060F172A),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.lightbulb_rounded, color: _amber, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Campus Connect Lab Note',
                              style: TextStyle(
                                color: _navy,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Experiment 4 demonstrates seamless Navigator push transitions and passing structured arguments between routes.',
                              style: TextStyle(
                                color: _muted,
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- HERO BANNER WIDGET ----------------
  Widget _buildHeroBanner(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_indigo, _violet, _coral],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _indigo.withValues(alpha: 0.35),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative background circles for creative aesthetic
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            left: 140,
            bottom: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 600;
                return Flex(
                  direction: isWide ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment:
                      isWide ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: isWide ? 3 : 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.25),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.stars_rounded, color: Color(0xFFFDE047), size: 14),
                                SizedBox(width: 6),
                                Text(
                                  'CAMPUS CONNECT • LAB PORTAL',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'Welcome to Campus Connect',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              height: 1.15,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Your unified academic workbench for exploring Flutter UI widgets, adaptive screen layouts, and student profile navigation.',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _buildPillTag(Icons.school_outlined, 'BTech AI & DS'),
                              _buildPillTag(Icons.code_rounded, 'Flutter 3.47'),
                              _buildPillTag(Icons.verified_outlined, 'Experiments 1-4'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (isWide) const SizedBox(width: 28) else const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.school,
                              size: 38,
                              color: _indigo,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Active Student',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'Semester 5 • 8.7 CGPA',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- HIGHLIGHTS STATS GRID ----------------
  Widget _buildHighlightsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 640;
        final count = isWide ? 4 : 2;
        final itemWidth = (constraints.maxWidth - ((count - 1) * 12)) / count;

        final items = [
          {
            'icon': Icons.science_rounded,
            'color': _amber,
            'bg': const Color(0xFFFEF3C7),
            'value': '4 Labs',
            'label': 'Curriculum',
          },
          {
            'icon': Icons.devices_rounded,
            'color': const Color(0xFF0284C7),
            'bg': const Color(0xFFE0F2FE),
            'value': 'Adaptive',
            'label': 'Responsive UI',
          },
          {
            'icon': Icons.route_rounded,
            'color': _violet,
            'bg': const Color(0xFFEDE9FE),
            'value': 'Navigator',
            'label': 'Named Routes',
          },
          {
            'icon': Icons.grade_rounded,
            'color': _coral,
            'bg': const Color(0xFFFFE4E6),
            'value': '8.7 CGPA',
            'label': 'Academics',
          },
        ];

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: items.map((item) {
            return SizedBox(
              width: itemWidth,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x060F172A),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: item['bg'] as Color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: item['color'] as Color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['value'] as String,
                            style: const TextStyle(
                              color: _navy,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            item['label'] as String,
                            style: const TextStyle(
                              color: _muted,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  // ---------------- EXPERIMENT MODULE CARD ----------------
  Widget _buildModuleCard({
    required BuildContext context,
    required String badgeText,
    required Color badgeColor,
    required Color badgeTextColor,
    required Color badgeBorderColor,
    required List<Color> iconGradient,
    required IconData icon,
    required String title,
    required String description,
    required List<String> features,
    required IconData actionIcon,
    required String actionLabel,
    required Color buttonColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x080F172A),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: iconGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: iconGradient.first.withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: badgeBorderColor),
                      ),
                      child: Text(
                        badgeText,
                        style: TextStyle(
                          color: badgeTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      style: const TextStyle(
                        color: _navy,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              color: _muted,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: features.map((feat) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  feat,
                  style: const TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 18),
          ElevatedButton.icon(
            icon: Icon(actionIcon, size: 18),
            label: Text(actionLabel),
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
