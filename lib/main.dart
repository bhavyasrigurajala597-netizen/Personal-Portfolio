import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/contact.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/responsive_screen.dart';
import 'screens/widgets_screen.dart';
import 'web_platform/web_platform.dart';

import 'profile_data.dart';

void main() => runApp(const CampusConnectApp());

const blue = Color(0xFF00E5FF);
const indigo = Color(0xFF00F0FF);
const violet = Color(0xFFD946EF);
const navy = Color(0xFFF1F5F9);
const muted = Color(0xFF94A3B8);
const border = Color(0x3300F0FF);
const double cgpaScaleMax = 10.0;
const sections = [
  'Home',
  'About Me',
  'Projects',
  'Contact',
  'Skills',
  'Qualifications'
];
const icons = [
  Icons.home_outlined,
  Icons.person_outline,
  Icons.work_outline,
  Icons.mail_outline,
  Icons.code,
  Icons.school_outlined
];

enum EditorCategory { home, about, contact, skills, qualifications, projects }

class CampusConnectApp extends StatelessWidget {
  const CampusConnectApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Campus Connect',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF090D16),
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF00F0FF),
              secondary: Color(0xFFFFB800),
              surface: Color(0xFF0F172A),
              onSurface: Color(0xFFF1F5F9),
            ),
            fontFamily: 'Arial',
            appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF090D16),
                foregroundColor: Color(0xFFF1F5F9),
                elevation: 0),
            dialogTheme: DialogThemeData(
              backgroundColor: const Color(0xFF0F172A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Color(0x4400F0FF), width: 1.5),
              ),
            ),
            filledButtonTheme: FilledButtonThemeData(
                style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF00F0FF),
                    foregroundColor: const Color(0xFF090D16),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 13),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)))),
            inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0x3300F0FF))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0x3300F0FF))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: Color(0xFF00F0FF), width: 1.5)),
                filled: true,
                fillColor: const Color(0xFF131D33),
                labelStyle: const TextStyle(color: Color(0xFF94A3B8)))),
        home: const PortfolioPage(),
        routes: {
          '/experiments': (context) => const HomeScreen(),
          '/widgets': (context) => const WidgetsScreen(),
          '/responsive': (context) => const ResponsiveScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/contact_screen': (context) => const ContactScreen(),
        },
      );
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});
  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _pages = PageController();
  ProfileData _profile = ProfileData.initial();
  int _step = 0;
  bool _loading = true;
  static const _storageKey = 'campus_connect_profile_v1';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final raw = loadFromStorage(_storageKey);
      if (raw != null) {
        final decoded = jsonDecode(raw) as Map<String, dynamic>;
        _profile = ProfileData.fromJson(decoded);
      }
    } catch (_) {
      /* Keep the empty starter profile if stored data is invalid. */
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _save(ProfileData data) async {
    saveToStorage(_storageKey, jsonEncode(data.toJson()));
    if (mounted) setState(() => _profile = data);
  }

  void _go(int index) {
    final i = index.clamp(0, 5);
    setState(() => _step = i);
    _pages.animateToPage(i,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic);
  }

  Future<void> _edit(EditorCategory category) async {
    final saved = await showDialog<bool>(
        context: context,
        builder: (_) => ProfileEditor(
            initial: _profile, category: category, onSave: _save));
    if (saved == true && mounted) _toast('Changes saved on this browser.');
  }

  void _toast(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      _header(),
      Expanded(
          child: PageView(
              controller: _pages,
              onPageChanged: (i) => setState(() => _step = i),
              children: [
            _home(),
            _about(),
            _projects(),
            _contact(),
            _skills(),
            _qualifications(),
          ])),
    ])));
  }

  Widget _header() => Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
      decoration: const BoxDecoration(
          color: Color(0xFF090D16),
          border: Border(bottom: BorderSide(color: Color(0x2A00F0FF)))),
      child: Center(
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1080),
              child: Column(children: [
                Row(children: [
                  Avatar(
                      image: _profile.profileImage,
                      name: _profile.name,
                      size: 48),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                            _profile.name.isEmpty
                                ? 'Your name goes here'
                                : _profile.name,
                            style: const TextStyle(
                                color: navy,
                                fontWeight: FontWeight.w800,
                                fontSize: 18)),
                        Text(
                            _profile.headline.isEmpty
                                ? 'Add a professional headline in Edit Profile'
                                : _profile.headline,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: muted, fontSize: 12))
                      ])),
                ]),
                const SizedBox(height: 13),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                            sections.length,
                            (i) => Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: _navPill(i))))),
              ]))));
  Widget _navPill(int i) => TextButton.icon(
      onPressed: () => _go(i),
      style: TextButton.styleFrom(
          backgroundColor: _step == i ? const Color(0x3300F0FF) : const Color(0xFF131D33),
          foregroundColor: _step == i ? const Color(0xFF00F0FF) : muted,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          side: BorderSide(
              color: _step == i ? const Color(0xFF00F0FF) : const Color(0x2200F0FF),
              width: 1),
          shape: const StadiumBorder()),
      icon: Icon(icons[i], size: 16),
      label: Text(sections[i]));

  Widget _page(List<Widget> content) => LayoutBuilder(
      builder: (context, box) => SingleChildScrollView(
          child: Center(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1080),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(22, 26, 22, 12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ...content,
                            const SizedBox(height: 28),
                            _footer()
                          ]))))));

  Widget _home() => _page([
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 38),
            decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/banner.jpg'),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Color(0xE6090D1A), BlendMode.darken),
                ),
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: const Color(0x6600F0FF), width: 1.5),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x3300F0FF),
                      blurRadius: 32,
                      offset: Offset(0, 10))
                ]),
            child: Stack(
              children: [
                Positioned(
                  right: -25,
                  top: -25,
                  child: Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD946EF).withValues(alpha: 0.16),
                    ),
                  ),
                ),
                Positioned(
                  left: 200,
                  bottom: -35,
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF00F0FF).withValues(alpha: 0.12),
                    ),
                  ),
                ),
                LayoutBuilder(builder: (context, c) {
                  final wide = c.maxWidth >= 700;
                  final name =
                      _profile.name.isEmpty ? 'My Portfolio' : _profile.name;
                  return Flex(
                      direction: wide ? Axis.horizontal : Axis.vertical,
                      crossAxisAlignment: wide
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.stretch,
                      children: [
                        ExpandedIf(
                            condition: wide,
                            child: Column(
                                crossAxisAlignment: wide
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: const Color(0x2600F0FF),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: const Color(0x6600F0FF)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(Icons.stars_rounded,
                                            color: Color(0xFF00F0FF), size: 14),
                                        SizedBox(width: 6),
                                        Flexible(
                                          child: Text(
                                            'CAMPUS CONNECT  /  PERSONAL PORTFOLIO',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Color(0xFF00F0FF),
                                              fontSize: 10.5,
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Text('Hello, $name!',
                                      textAlign: wide
                                          ? TextAlign.left
                                          : TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 38,
                                          height: 1.1,
                                          letterSpacing: -0.5,
                                          fontWeight: FontWeight.w900)),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0x2610B981),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: const Color(0x5510B981)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 7,
                                          height: 7,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF10B981),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 7),
                                        Flexible(
                                          child: Text(
                                            _profile.headline.isEmpty
                                                ? 'Active Student • Developer'
                                                : _profile.headline,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Color(0xFFF1F5F9),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Text(_profile.about,
                                      textAlign: wide
                                          ? TextAlign.left
                                          : TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.5,
                                          height: 1.6)),
                                  const SizedBox(height: 22),
                                  Wrap(
                                      alignment: wide
                                          ? WrapAlignment.start
                                          : WrapAlignment.center,
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: [
                                        _action('Explore My Portfolio',
                                            Icons.arrow_forward, () => _go(1),
                                            primary: true),
                                        _action('View Projects',
                                            Icons.work_outline, () => _go(2)),
                                        _action('Contact Me',
                                            Icons.mail_outline, () => _go(3)),
                                      ])
                                ])),
                        if (wide)
                          const SizedBox(width: 36)
                        else
                          const SizedBox(height: 28),
                        Column(mainAxisSize: MainAxisSize.min, children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF00F0FF),
                                  Color(0xFFD946EF),
                                  Color(0xFFFFB800),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF00F0FF)
                                      .withValues(alpha: 0.45),
                                  blurRadius: 24,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Avatar(
                                image: _profile.profileImage,
                                name: _profile.name,
                                size: wide ? 204 : 170,
                                hero: true),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: wide ? 270 : 300,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xB30F172A),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0x4400F0FF),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x22000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.flag_rounded,
                                    color: Color(0xFFFFB800), size: 18),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(_profile.careerGoal,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.5,
                                          height: 1.5,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                        ])
                      ]);
                }),
              ],
            )),
        const SizedBox(height: 24),
        _homeCampusStats(),
        const SizedBox(height: 24),
        Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF131D33), Color(0xFF1E1035)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0x55D946EF)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x26D946EF),
                    blurRadius: 20,
                    offset: Offset(0, 6),
                  ),
                ]),
            child: LayoutBuilder(
                builder: (context, c) => Flex(
                        direction:
                            c.maxWidth < 560 ? Axis.vertical : Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0x22D946EF),
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0x55D946EF)),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x22D946EF),
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.rocket_launch_rounded,
                                color: violet, size: 28),
                          ),
                          const SizedBox(width: 16, height: 16),
                          ExpandedIf(
                              condition: c.maxWidth >= 560,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("Let's Connect",
                                        style: TextStyle(
                                            color: navy,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 22)),
                                    SizedBox(height: 6),
                                    Text(
                                        'Interested in collaborating or discussing software development projects?',
                                        style: TextStyle(
                                            color: muted, height: 1.5, fontSize: 14)),
                                  ])),
                          if (c.maxWidth < 560)
                            const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Let's Connect",
                                      style: TextStyle(
                                          color: navy,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 22)),
                                  SizedBox(height: 6),
                                  Text(
                                      'Interested in collaborating or discussing software development projects?',
                                      style:
                                          TextStyle(color: muted, height: 1.5, fontSize: 14)),
                                ]),
                          if (c.maxWidth >= 560)
                            const SizedBox(width: 20)
                          else
                            const SizedBox(height: 18),
                          FilledButton.icon(
                              onPressed: () => _go(3),
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF00F0FF),
                                foregroundColor: const Color(0xFF090D16),
                                textStyle: const TextStyle(fontWeight: FontWeight.w800),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              icon: const Icon(Icons.mail_outline),
                              label: const Text('Contact Me'))
                        ]))),
      ]);

  Widget _homeCampusStats() => LayoutBuilder(builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 640;
        final count = isWide ? 4 : 2;
        final itemWidth = (constraints.maxWidth - ((count - 1) * 12)) / count;
        final stats = [
          {
            'icon': Icons.school_rounded,
            'color': const Color(0xFF00F0FF),
            'bg': const Color(0x2200F0FF),
            'val': _profile.currentYear.isEmpty
                ? '3rd Year'
                : _profile.currentYear,
            'label': 'Academic Year',
          },
          {
            'icon': Icons.grade_rounded,
            'color': const Color(0xFFFFB800),
            'bg': const Color(0x22FFB800),
            'val':
                '${_profile.degreeCurrentCgpa.isEmpty ? '8.7' : _profile.degreeCurrentCgpa} CGPA',
            'label': 'Academic Score',
          },
          {
            'icon': Icons.rocket_launch_rounded,
            'color': const Color(0xFFD946EF),
            'bg': const Color(0x22D946EF),
            'val': '${_profile.projects.length} Projects',
            'label': 'Showcased Works',
          },
          {
            'icon': Icons.terminal_rounded,
            'color': const Color(0xFF10B981),
            'bg': const Color(0x2210B981),
            'val': '${_profile.skills.length} Skills',
            'label': 'Core Stack',
          },
        ];
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: stats
              .map((st) => SizedBox(
                    width: itemWidth,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: _cardDecoration(),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: st['bg'] as Color,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(st['icon'] as IconData,
                                color: st['color'] as Color, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  st['val'] as String,
                                  style: const TextStyle(
                                    color: navy,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14.5,
                                  ),
                                ),
                                Text(
                                  st['label'] as String,
                                  style: const TextStyle(
                                    color: muted,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        );
      });

  Widget _about() => _page([
        _heading('About Me', 'Personal details and what I am working toward',
            Icons.person_outline),
        const SizedBox(height: 14),
        Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
                onPressed: () => _edit(EditorCategory.about),
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit Personal Information'))),
        const SizedBox(height: 12),
        _sectionCard('Personal Information', Icons.person_outline, [
          _info('Full name', _profile.name),
          _info('Professional headline', _profile.headline),
          _info('Degree and specialization', _profile.degree),
          _info('College or university', _profile.college),
          _info('Current academic year', _profile.currentYear),
          _info('Biography', _profile.about),
          _info('Career goal', _profile.careerGoal),
          _info('Location', _profile.location),
          _info('Personal interests', _profile.interests.join(', ')),
        ]),
      ]);

  Widget _projects() => _page([
        _heading('Projects', 'Things I have been building', Icons.work_outline),
        const SizedBox(height: 14),
        Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
                onPressed: () => _edit(EditorCategory.projects),
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Manage Projects'))),
        const SizedBox(height: 12),
        if (_profile.projects.isEmpty)
          _empty('No projects yet. Add one to get started.', Icons.work_outline,
              () => _edit(EditorCategory.projects))
        else
          _projectGrid(_profile.projects
              .map((project) => ProjectCard(project: project))
              .toList()),
      ]);

  Widget _info(String label, String value) => value.trim().isEmpty
      ? const SizedBox.shrink()
      : Padding(
          padding: const EdgeInsets.only(bottom: 9),
          child: LayoutBuilder(builder: (context, box) {
            final labelWidget = Text(label,
                style:
                    const TextStyle(color: muted, fontWeight: FontWeight.w600));
            final valueWidget = Text(value,
                style:
                    const TextStyle(color: navy, fontWeight: FontWeight.w600));
            return box.maxWidth < 460
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [labelWidget, valueWidget])
                : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(width: 190, child: labelWidget),
                    Expanded(child: valueWidget)
                  ]);
          }));
  Widget _sectionCard(String title, IconData icon, List<Widget> rows) =>
      _panel(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(icon, color: violet),
          const SizedBox(width: 9),
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w800, fontSize: 17, color: navy))
        ]),
        const SizedBox(height: 14),
        ...rows
      ]));

  Widget _contact() => _page([
        _heading("Let's Connect", 'Contact details appear when you add them',
            Icons.mail_outline),
        const SizedBox(height: 14),
        if ([
          _profile.email,
          _profile.phone,
          _profile.github,
          _profile.linkedin,
          _profile.location,
          ..._profile.otherLinks.map((e) => e.url)
        ].every((e) => e.trim().isEmpty))
          _empty('Add an email, phone number, or professional profile link.',
              Icons.contact_mail_outlined, () => _edit(EditorCategory.contact))
        else
          Wrap(spacing: 12, runSpacing: 12, children: [
            if (_profile.email.trim().isNotEmpty)
              ContactCard(
                  icon: Icons.email_outlined,
                  title: 'Email',
                  value: _profile.email,
                  action: 'Send email',
                  onPressed: () =>
                      _launch(Uri(scheme: 'mailto', path: _profile.email))),
            if (_profile.phone.trim().isNotEmpty)
              ContactCard(
                  icon: Icons.phone_outlined,
                  title: 'Phone',
                  value: _profile.phone,
                  action: 'Call',
                  onPressed: () =>
                      _launch(Uri(scheme: 'tel', path: _profile.phone))),
            if (_validWebUrl(_profile.github))
              ContactCard(
                  icon: Icons.code,
                  title: 'GitHub',
                  value: _profile.github,
                  action: 'Open profile',
                  onPressed: () => _launchWeb(_profile.github)),
            if (_validWebUrl(_profile.linkedin))
              ContactCard(
                  icon: Icons.work_outline,
                  title: 'LinkedIn',
                  value: _profile.linkedin,
                  action: 'Open profile',
                  onPressed: () => _launchWeb(_profile.linkedin)),
            ..._profile.otherLinks.where((e) => _validWebUrl(e.url)).map(
                (link) => ContactCard(
                    icon: Icons.link,
                    title: link.label,
                    value: link.url,
                    action: 'Open link',
                    onPressed: () => _launchWeb(link.url)))
          ]),
        _info('Location', _profile.location),
        if (_profile.email.trim().isNotEmpty) ...[
          const SizedBox(height: 14),
          OutlinedButton.icon(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: _profile.email));
                _toast('Email copied to clipboard.');
              },
              icon: const Icon(Icons.copy),
              label: const Text('Copy Email'))
        ],
        const SizedBox(height: 16),
        Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
                onPressed: () => _edit(EditorCategory.contact),
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit contact details'))),
      ]);

  Widget _skills() => _page([
        _heading('My Skills', 'Skills and tools I work with', Icons.code),
        const SizedBox(height: 14),
        if (_profile.skills.isEmpty)
          _empty('Your skills will appear here. Add a skill using Edit Skills.',
              Icons.bolt, () => _edit(EditorCategory.skills))
        else
          Wrap(
              spacing: 9,
              runSpacing: 9,
              children: _profile.skills.map((s) => Tag(s.name)).toList()),
        Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
                onPressed: () => _edit(EditorCategory.skills),
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit skills')))
      ]);

  Widget _academicCard(
          String title, String institution, List<String> details) =>
      Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(18),
          decoration: _cardDecoration(),
          child: Row(children: [
            const Icon(Icons.school_outlined, color: blue, size: 28),
            const SizedBox(width: 14),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(title,
                      style: const TextStyle(
                          color: navy,
                          fontWeight: FontWeight.w800,
                          fontSize: 16)),
                  if (institution.isNotEmpty)
                    Text(institution, style: const TextStyle(color: muted)),
                  ...details.where((d) => d.isNotEmpty).map((d) => Text(d,
                      style: const TextStyle(color: muted, fontSize: 12)))
                ]))
          ]));

  Widget _qualifications() {
    final hasSchool =
        _profile.schoolName.isNotEmpty || _profile.schoolPercentage.isNotEmpty;
    final hasIntermediate = _profile.intermediateCollegeName.isNotEmpty ||
        _profile.intermediatePercentage.isNotEmpty;
    final hasDegree = _profile.degreeInstitutionName.isNotEmpty ||
        _profile.degreeAcademicStatus.isNotEmpty ||
        _profile.degreeCurrentYear.isNotEmpty ||
        _profile.degreeCurrentCgpa.isNotEmpty ||
        _profile.degreeFinalCgpa.isNotEmpty;
    return _page([
      _heading('My Qualifications',
          'School, intermediate, and degree education', Icons.school_outlined),
      const SizedBox(height: 14),
      if (!hasSchool && !hasIntermediate && !hasDegree)
        _empty('Add your academic details to build your qualifications.',
            Icons.school_outlined, () => _edit(EditorCategory.qualifications)),
      if (hasSchool)
        _academicCard('School Education', _profile.schoolName, [
          _profile.schoolPercentage.isEmpty
              ? ''
              : 'Percentage: ${_profile.schoolPercentage}%'
        ]),
      if (hasIntermediate)
        _academicCard(
            'Intermediate Education', _profile.intermediateCollegeName, [
          _profile.intermediatePercentage.isEmpty
              ? ''
              : 'Percentage: ${_profile.intermediatePercentage}%'
        ]),
      if (hasDegree)
        _academicCard('Degree Education', _profile.degreeInstitutionName, [
          _profile.degreeAcademicStatus,
          if (_profile.degreeAcademicStatus == 'Pursuing' &&
              _profile.degreeCurrentYear.isNotEmpty)
            'Current year: ${_profile.degreeCurrentYear}',
          if (_profile.degreeAcademicStatus == 'Pursuing' &&
              _profile.degreeCurrentCgpa.isNotEmpty)
            'Current CGPA: ${_profile.degreeCurrentCgpa}',
          if (_profile.degreeAcademicStatus == 'Passed Out' &&
              _profile.degreeFinalCgpa.isNotEmpty)
            'Final CGPA: ${_profile.degreeFinalCgpa}',
        ]),
      const SizedBox(height: 10),
      Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
              onPressed: () => _edit(EditorCategory.qualifications),
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Edit qualifications')))
    ]);
  }

  Widget _footer() => Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration:
          const BoxDecoration(border: Border(top: BorderSide(color: border))),
      child:
          Wrap(alignment: WrapAlignment.spaceBetween, runSpacing: 8, children: [
        Text('© 2026 Campus Connect',
            style: const TextStyle(color: muted, fontSize: 12)),
        Text('Designed by ${_profile.name.isEmpty ? 'you' : _profile.name}',
            style: const TextStyle(color: muted, fontSize: 12)),
        const Text('Always learning. Always building.',
            style: TextStyle(color: muted, fontSize: 12)),
        if (_validWebUrl(_profile.github))
          LinkButton(label: 'GitHub', icon: Icons.code, url: _profile.github),
        if (_validWebUrl(_profile.linkedin))
          LinkButton(
              label: 'LinkedIn',
              icon: Icons.work_outline,
              url: _profile.linkedin)
      ]));

  Widget _heading(String title, String subtitle, IconData icon) =>
      Row(children: [
        Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: const Color(0x2200F0FF),
                border: Border.all(color: const Color(0x4400F0FF)),
                borderRadius: BorderRadius.circular(13)),
            child: Icon(icon, color: blue)),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 23, fontWeight: FontWeight.w800, color: navy)),
          Text(subtitle, style: const TextStyle(color: muted, fontSize: 13))
        ]))
      ]);
  Widget _panel(Widget child) => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: child);
  Widget _empty(String message, IconData icon, VoidCallback edit) =>
      _panel(Column(children: [
        Icon(icon, color: violet, size: 32),
        const SizedBox(height: 8),
        Text(message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: muted, height: 1.4)),
        const SizedBox(height: 10),
        OutlinedButton.icon(
            onPressed: edit,
            icon: const Icon(Icons.add),
            label: const Text('Edit Profile'))
      ]));
  Widget _projectGrid(List<Widget> children) => LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 900
              ? 3
              : constraints.maxWidth >= 600
                  ? 2
                  : 1;
          const gap = 14.0;
          final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: children
                .map((child) => SizedBox(width: width, child: child))
                .toList(),
          );
        },
      );
  Widget _action(String text, IconData icon, VoidCallback fn,
          {bool primary = false}) =>
      FilledButton.icon(
          onPressed: fn,
          icon: Icon(icon, size: 17),
          label: Text(text),
          style: FilledButton.styleFrom(
              backgroundColor:
                  primary ? const Color(0xFF00F0FF) : const Color(0x1F00F0FF),
              foregroundColor:
                  primary ? const Color(0xFF090D16) : const Color(0xFFF1F5F9),
              side: primary
                  ? null
                  : const BorderSide(color: Color(0x4D00F0FF), width: 1),
              textStyle: TextStyle(
                  fontWeight: primary ? FontWeight.w800 : FontWeight.w600),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))));
  Future<void> _launchWeb(String value) {
    final uri = Uri.tryParse(value);
    if (uri == null ||
        !{'http', 'https'}.contains(uri.scheme) ||
        uri.host.isEmpty) {
      _toast('Enter a valid http or https link in Edit Profile.');
      return Future.value();
    }
    return _launch(uri);
  }

  Future<void> _launch(Uri uri) async => _openExternal(uri);

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }
}

class ExpandedIf extends StatelessWidget {
  const ExpandedIf(
      {super.key, required this.condition, required this.child, this.flex = 1});
  final bool condition;
  final Widget child;
  final int flex;
  @override
  Widget build(BuildContext context) =>
      condition ? Expanded(flex: flex, child: child) : child;
}

class Avatar extends StatelessWidget {
  const Avatar(
      {super.key,
      required this.image,
      required this.name,
      required this.size,
      this.hero = false});
  final String image, name;
  final double size;
  final bool hero;
  @override
  Widget build(BuildContext context) {
    final initials = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();
    final source = image.isEmpty ? 'assets/images/profile.jpg' : image;
    final isRemote =
        source.startsWith('https://') || source.startsWith('http://');
    final imageWidget = isRemote
        ? Image.network(source,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _fallback(initials))
        : Image.asset(source,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _fallback(initials));
    return Container(
        width: size,
        height: size,
        padding: hero ? const EdgeInsets.all(4) : EdgeInsets.zero,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF131D33),
            gradient: hero
                ? const LinearGradient(
                    colors: [Color(0xFF00F0FF), Color(0xFFD946EF)])
                : null,
            boxShadow: hero
                ? const [
                    BoxShadow(
                        color: Color(0x5500F0FF),
                        blurRadius: 24,
                        offset: Offset(0, 8))
                  ]
                : null),
        child: ClipOval(child: SizedBox.expand(child: imageWidget)));
  }

  Widget _fallback(String initials) => Center(
      child: Text(initials.isEmpty ? 'CC' : initials,
          style: TextStyle(
              color: indigo,
              fontSize: size * .34,
              fontWeight: FontWeight.w800)));
}

class Tag extends StatelessWidget {
  const Tag(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: const Color(0x1A00F0FF),
          border: Border.all(color: const Color(0x4D00F0FF)),
          borderRadius: BorderRadius.circular(24)),
      child: Text(text,
          style: const TextStyle(
              color: Color(0xFF00F0FF), fontWeight: FontWeight.w600, fontSize: 12)));
}

BoxDecoration _cardDecoration() => BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
        boxShadow: const [
          BoxShadow(
              color: Color(0x33000000), blurRadius: 16, offset: Offset(0, 6))
        ]);

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});
  final ProjectData project;
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                  color: const Color(0x26D946EF),
                  border: Border.all(color: const Color(0x44D946EF)),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.terminal, color: violet)),
          const SizedBox(width: 10),
          Expanded(
              child: Text(project.name,
                  style: const TextStyle(
                      color: navy, fontWeight: FontWeight.w800, fontSize: 16)))
        ]),
        const SizedBox(height: 10),
        Text(project.description,
            style: const TextStyle(color: muted, height: 1.5, fontSize: 13)),
        const SizedBox(height: 10),
        Wrap(
            spacing: 5,
            runSpacing: 5,
            children: project.technologies.map((e) => Tag(e)).toList()),
        if (_validWebUrl(project.repository)) ...[
          const SizedBox(height: 8),
          LinkButton(label: 'GitHub', icon: Icons.code, url: project.repository)
        ]
      ]));
}

bool _validWebUrl(String value) {
  final u = Uri.tryParse(value.trim());
  return u != null && {'http', 'https'}.contains(u.scheme) && u.host.isNotEmpty;
}

class ContactCard extends StatelessWidget {
  const ContactCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.value,
      this.action,
      this.onPressed});
  final IconData icon;
  final String title, value;
  final String? action;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) => Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(children: [
        Icon(icon, color: blue),
        const SizedBox(width: 12),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(color: navy, fontWeight: FontWeight.w700)),
          Text(value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: muted, fontSize: 12)),
          if (action != null)
            TextButton(onPressed: onPressed, child: Text(action!))
        ]))
      ]));
}

class EducationCard extends StatelessWidget {
  const EducationCard({super.key, required this.education});
  final EducationData education;
  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Row(children: [
        const Icon(Icons.school_outlined, color: blue, size: 28),
        const SizedBox(width: 14),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(education.qualification,
              style: const TextStyle(
                  color: navy, fontWeight: FontWeight.w800, fontSize: 16)),
          if (education.institution.isNotEmpty)
            Text(education.institution, style: const TextStyle(color: muted)),
          if (education.specialization.isNotEmpty)
            Text(education.specialization,
                style: const TextStyle(color: muted, fontSize: 12)),
          if (education.startYear.isNotEmpty || education.endYear.isNotEmpty)
            Text(
                '${education.startYear}${education.startYear.isNotEmpty && education.endYear.isNotEmpty ? ' - ' : ''}${education.endYear}',
                style: const TextStyle(color: muted, fontSize: 12)),
          if (education.status.isNotEmpty)
            Text(education.status,
                style: const TextStyle(
                    color: blue, fontWeight: FontWeight.w600, fontSize: 12)),
          if (education.achievements.isNotEmpty)
            Text(education.achievements,
                style: const TextStyle(color: muted, fontSize: 12))
        ]))
      ]));
}

class LinkButton extends StatelessWidget {
  const LinkButton(
      {super.key, required this.label, required this.icon, required this.url});
  final String label, url;
  final IconData icon;
  @override
  Widget build(BuildContext context) => TextButton.icon(
      onPressed: () {
        final uri = Uri.tryParse(url);
        if (uri != null &&
            {'http', 'https'}.contains(uri.scheme) &&
            uri.host.isNotEmpty) {
          _openExternal(uri);
        }
      },
      icon: Icon(icon, size: 16),
      label: Text(label));
}

void _openExternal(Uri uri) {
  openExternalUrl(uri);
}

/// Shared modal shell. Each category builds only its own controls and mutates
/// a draft cloned from the current profile, preserving every other category.
class ProfileEditor extends StatefulWidget {
  const ProfileEditor(
      {super.key,
      required this.initial,
      required this.category,
      required this.onSave});
  final ProfileData initial;
  final EditorCategory category;
  final Future<void> Function(ProfileData) onSave;
  @override
  State<ProfileEditor> createState() => _ProfileEditorState();
}

class _ProfileEditorState extends State<ProfileEditor> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  late ProfileData _draft;
  bool _saving = false;
  String _academicStatus = '';
  String? _error;

  @override
  void initState() {
    super.initState();
    _draft = ProfileData.fromJson(widget.initial.toJson());
    _academicStatus = _draft.degreeAcademicStatus;
    final values = <String, String>{
      'welcomeHeading': _draft.welcomeHeading,
      'introTagline': _draft.introTagline,
      'heroDescription': _draft.heroDescription,
      'name': _draft.name,
      'headline': _draft.headline,
      'degree': _draft.degree,
      'college': _draft.college,
      'currentYear': _draft.currentYear,
      'about': _draft.about,
      'careerGoal': _draft.careerGoal,
      'location': _draft.location,
      'interests': _draft.interests.join(', '),
      'email': _draft.email,
      'phone': _draft.phone,
      'github': _draft.github,
      'linkedin': _draft.linkedin,
      'schoolName': _draft.schoolName,
      'schoolPercentage': _draft.schoolPercentage,
      'intermediateCollegeName': _draft.intermediateCollegeName,
      'intermediatePercentage': _draft.intermediatePercentage,
      'degreeInstitutionName': _draft.degreeInstitutionName,
      'degreeCurrentYear': _draft.degreeCurrentYear,
      'degreeCurrentCgpa': _draft.degreeCurrentCgpa,
      'degreeFinalCgpa': _draft.degreeFinalCgpa,
    };
    for (final entry in values.entries) {
      _controllers[entry.key] = TextEditingController(text: entry.value);
    }
  }

  String _v(String key) => _controllers[key]!.text.trim();
  Widget _field(String key, String label,
          {int lines = 1,
          String? Function(String?)? validator,
          String? hint}) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
              controller: _controllers[key],
              maxLines: lines,
              decoration: InputDecoration(labelText: label, hintText: hint),
              validator: validator));
  String? _urlValidator(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final uri = Uri.tryParse(value.trim());
    return uri != null &&
            {'http', 'https'}.contains(uri.scheme) &&
            uri.host.isNotEmpty
        ? null
        : 'Enter a full http or https URL.';
  }

  String? _emailValidator(String? value) => value == null ||
          value.trim().isEmpty ||
          RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value.trim())
      ? null
      : 'Enter a valid email address.';

  String get _title => switch (widget.category) {
        EditorCategory.home => 'Edit Home',
        EditorCategory.about => 'Edit About',
        EditorCategory.contact => 'Edit Contact',
        EditorCategory.skills => 'Manage Skills',
        EditorCategory.qualifications => 'Manage Qualifications',
        EditorCategory.projects => 'Manage Projects'
      };

  @override
  Widget build(BuildContext context) => Dialog(
        insetPadding: const EdgeInsets.all(14),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680, maxHeight: 850),
          child: Form(
            key: _formKey,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
                child: Row(children: [
                  Expanded(
                      child: Text(_title,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: navy))),
                  IconButton(
                      tooltip: 'Close editor',
                      onPressed: _saving ? null : () => Navigator.pop(context),
                      icon: const Icon(Icons.close)),
                ]),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    ..._categoryFields(),
                    if (_error != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(_error!,
                            style: const TextStyle(color: Colors.red)),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child:
                    Wrap(alignment: WrapAlignment.end, spacing: 8, children: [
                  TextButton(
                      onPressed: _saving ? null : () => Navigator.pop(context),
                      child: const Text('Cancel')),
                  FilledButton.icon(
                      onPressed: _saving ? null : _save,
                      icon: _saving
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.save_outlined),
                      label: const Text('Save Changes')),
                ]),
              ),
            ]),
          ),
        ),
      );

  List<Widget> _categoryFields() => switch (widget.category) {
        EditorCategory.home => _homeFields(),
        EditorCategory.about => _aboutFields(),
        EditorCategory.contact => _contactFields(),
        EditorCategory.skills => _skillsFields(),
        EditorCategory.qualifications => _educationFields(),
        EditorCategory.projects => _projectsFields(),
      };

  List<Widget> _homeFields() => [
        _field('welcomeHeading', 'Welcome heading',
            hint: 'Welcome to My Portfolio'),
        _field('name', 'Full name'),
        _field('headline', 'Professional headline'),
        _field('introTagline', 'Short introductory tagline', lines: 2),
        _field('heroDescription', 'Introductory content', lines: 3),
        const _EditorLabel('Home actions'),
        SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Explore My Skills'),
            value: _draft.showHeroSkills,
            onChanged: (v) => setState(() => _draft.showHeroSkills = v)),
        SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Contact Me'),
            value: _draft.showHeroContact,
            onChanged: (v) => setState(() => _draft.showHeroContact = v)),
        SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Edit My Profile'),
            value: _draft.showHeroEdit,
            onChanged: (v) => setState(() => _draft.showHeroEdit = v)),
      ];

  List<Widget> _aboutFields() => [
        const _EditorLabel('Personal Information'),
        _field('name', 'Full Name'),
        _field('headline', 'Professional Headline'),
        _field('degree', 'Degree and Specialization'),
        _field('college', 'College or University Name'),
        _field('currentYear', 'Current Academic Year'),
        _field('careerGoal', 'Career Goal', lines: 2),
        _field('location', 'Location (optional)'),
        _field('interests', 'Personal Interests (optional)',
            hint: 'Separate interests with commas'),
      ];

  List<Widget> _contactFields() => [
        _field('email', 'Email address', validator: _emailValidator),
        _field('phone', 'Phone number (optional)'),
        _field('github', 'GitHub URL (optional)', validator: _urlValidator),
        _field('linkedin', 'LinkedIn URL (optional)', validator: _urlValidator),
        const _EditorLabel('Other professional links'),
        ..._draft.otherLinks.asMap().entries.map((e) => _manageRow(
            '${e.value.label} • ${e.value.url}',
            () => _editLink(e.key),
            () => _deleteItem('Delete this link?',
                () => setState(() => _draft.otherLinks.removeAt(e.key))))),
        OutlinedButton.icon(
            onPressed: () => _editLink(null),
            icon: const Icon(Icons.add),
            label: const Text('Add Link')),
        const SizedBox(height: 10),
        const Text('Empty contact fields stay hidden from your portfolio.',
            style: TextStyle(color: muted, fontSize: 12)),
      ];

  List<Widget> _skillsFields() => [
        ..._draft.skills.asMap().entries.map((e) => _manageRow(
            e.value.name,
            () => _editSkill(e.key),
            () => _deleteItem('Delete ${e.value.name}?',
                () => setState(() => _draft.skills.removeAt(e.key))))),
        if (_draft.skills.isEmpty)
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('No skills yet. Add one to get started.',
                  style: TextStyle(color: muted))),
        OutlinedButton.icon(
            onPressed: () => _editSkill(null),
            icon: const Icon(Icons.add),
            label: const Text('Add Skill')),
      ];

  String? _rangeValidator(String? value, String label, double max) {
    if (value == null || value.trim().isEmpty) return null;
    final number = double.tryParse(value.trim());
    if (number == null || number < 0 || number > max) {
      return 'Enter a value from 0 to $max.';
    }
    return null;
  }

  List<Widget> _educationFields() => [
        const _EditorLabel('School Education'),
        _field('schoolName', 'School Name'),
        _field('schoolPercentage', 'Percentage',
            validator: (v) => _rangeValidator(v, 'Percentage', 100)),
        const _EditorLabel('Intermediate Education'),
        _field('intermediateCollegeName', 'Intermediate College Name'),
        _field('intermediatePercentage', 'Percentage',
            validator: (v) => _rangeValidator(v, 'Percentage', 100)),
        const _EditorLabel('Degree Education'),
        _field('degreeInstitutionName', 'Degree Institution Name'),
        Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: DropdownButtonFormField<String>(
                initialValue: _academicStatus.isEmpty ? null : _academicStatus,
                decoration: const InputDecoration(labelText: 'Academic Status'),
                items: const [
                  DropdownMenuItem(value: 'Pursuing', child: Text('Pursuing')),
                  DropdownMenuItem(
                      value: 'Passed Out', child: Text('Passed Out'))
                ],
                onChanged: (value) =>
                    setState(() => _academicStatus = value ?? ''))),
        if (_academicStatus == 'Pursuing') ...[
          _field('degreeCurrentYear', 'Current Year of Study',
              validator: (v) => v == null || v.trim().isNotEmpty
                  ? null
                  : 'Required while pursuing.'),
          _field('degreeCurrentCgpa', 'Current CGPA (scale 0 to $cgpaScaleMax)',
              validator: (v) => _rangeValidator(v, 'CGPA', cgpaScaleMax)),
        ],
        if (_academicStatus == 'Passed Out')
          _field('degreeFinalCgpa', 'Final CGPA (scale 0 to $cgpaScaleMax)',
              validator: (v) => _rangeValidator(v, 'CGPA', cgpaScaleMax)),
      ];

  List<Widget> _projectsFields() => [
        const _EditorLabel('Project Name'),
        ..._draft.projects.asMap().entries.map((e) => _manageRow(
            e.value.name,
            () => _editProject(e.key),
            () => _deleteItem('Delete ${e.value.name}?',
                () => setState(() => _draft.projects.removeAt(e.key))))),
        if (_draft.projects.isEmpty)
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('No projects yet. Add one to get started.',
                  style: TextStyle(color: muted))),
        OutlinedButton.icon(
            onPressed: () => _editProject(null),
            icon: const Icon(Icons.add),
            label: const Text('Add Project')),
      ];

  Widget _manageRow(String title, VoidCallback edit, VoidCallback delete) =>
      Card(
          color: const Color(0xFF131D33),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0x3300F0FF))),
          child: ListTile(
              title: Text(title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: navy)),
              trailing: Wrap(spacing: 0, children: [
                IconButton(
                    tooltip: 'Edit',
                    onPressed: edit,
                    icon: const Icon(Icons.edit_outlined, color: blue)),
                IconButton(
                    tooltip: 'Delete',
                    onPressed: delete,
                    icon: const Icon(Icons.delete_outline,
                        color: Colors.redAccent))
              ])));
  Future<void> _editSkill(int? index) async {
    final result = await showDialog<SkillData>(
        context: context,
        builder: (_) =>
            SkillForm(initial: index == null ? null : _draft.skills[index]));
    if (result != null && mounted) {
      final duplicate = _draft.skills.asMap().entries.any((entry) =>
          entry.key != index &&
          entry.value.name.trim().toLowerCase() ==
              result.name.trim().toLowerCase());
      if (duplicate) {
        setState(() => _error = 'A skill with that name already exists.');
        return;
      }
      setState(() {
        _error = null;
        if (index == null) {
          _draft.skills.add(SkillData(name: result.name.trim()));
        } else {
          _draft.skills[index] = SkillData(name: result.name.trim());
        }
      });
    }
  }

  Future<void> _editProject(int? index) async {
    final result = await showDialog<ProjectData>(
        context: context,
        builder: (_) => ProjectForm(
            initial: index == null ? null : _draft.projects[index]));
    if (result != null && mounted) {
      setState(() {
        if (index == null) {
          _draft.projects.add(result);
        } else {
          _draft.projects[index] = result;
        }
      });
    }
  }

  Future<void> _editLink(int? index) async {
    final result = await showDialog<ProfessionalLink>(
        context: context,
        builder: (_) =>
            LinkForm(initial: index == null ? null : _draft.otherLinks[index]));
    if (result != null && mounted) {
      setState(() {
        if (index == null) {
          _draft.otherLinks.add(result);
        } else {
          _draft.otherLinks[index] = result;
        }
      });
    }
  }

  Future<void> _deleteItem(String title, VoidCallback onDelete) async {
    final yes = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
                title: Text(title),
                content:
                    const Text('This item will be removed from this category.'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancel')),
                  FilledButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Delete'))
                ]));
    if (yes == true && mounted) onDelete();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    switch (widget.category) {
      case EditorCategory.home:
        _draft.welcomeHeading = _v('welcomeHeading');
        _draft.name = _v('name');
        _draft.headline = _v('headline');
        _draft.introTagline = _v('introTagline');
        _draft.heroDescription = _v('heroDescription');
        break;
      case EditorCategory.about:
        _draft.name = _v('name');
        _draft.headline = _v('headline');
        _draft.degree = _v('degree');
        _draft.college = _v('college');
        _draft.currentYear = _v('currentYear');
        _draft.degreeInstitutionName = _draft.college;
        if (_draft.degreeAcademicStatus == 'Pursuing') {
          _draft.degreeCurrentYear = _draft.currentYear;
        }
        _draft.careerGoal = _v('careerGoal');
        _draft.location = _v('location');
        _draft.interests = _v('interests')
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
        break;
      case EditorCategory.contact:
        _draft.email = _v('email');
        _draft.phone = _v('phone');
        _draft.github = _v('github');
        _draft.linkedin = _v('linkedin');
        break;
      case EditorCategory.skills:
        _draft.skills =
            _draft.skills.map((s) => SkillData(name: s.name.trim())).toList();
        break;
      case EditorCategory.qualifications:
        _draft.schoolName = _v('schoolName');
        _draft.schoolPercentage = _v('schoolPercentage');
        _draft.intermediateCollegeName = _v('intermediateCollegeName');
        _draft.intermediatePercentage = _v('intermediatePercentage');
        _draft.degreeInstitutionName = _v('degreeInstitutionName');
        _draft.college = _draft.degreeInstitutionName;
        _draft.degreeAcademicStatus = _academicStatus;
        _draft.degreeCurrentYear =
            _academicStatus == 'Pursuing' ? _v('degreeCurrentYear') : '';
        _draft.currentYear = _draft.degreeCurrentYear;
        _draft.degreeCurrentCgpa =
            _academicStatus == 'Pursuing' ? _v('degreeCurrentCgpa') : '';
        _draft.degreeFinalCgpa =
            _academicStatus == 'Passed Out' ? _v('degreeFinalCgpa') : '';
        break;
      case EditorCategory.projects:
        break;
    }
    try {
      await widget.onSave(_draft);
      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error =
              'Could not save changes. Your edits are still here; please try again.';
        });
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }
}

class _EditorLabel extends StatelessWidget {
  const _EditorLabel(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 5),
      child: Text(text,
          style: const TextStyle(fontWeight: FontWeight.w800, color: indigo)));
}

class SkillForm extends StatefulWidget {
  const SkillForm({super.key, this.initial});
  final SkillData? initial;
  @override
  State<SkillForm> createState() => _SkillFormState();
}

class _SkillFormState extends State<SkillForm> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _name;
  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.initial?.name ?? '');
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
          title: Text(widget.initial == null ? 'Add Skill' : 'Edit Skill'),
          content: SizedBox(
              width: 420,
              child: Form(
                  key: _key,
                  child: TextFormField(
                      controller: _name,
                      autofocus: true,
                      decoration:
                          const InputDecoration(labelText: 'Skill Name'),
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                              ? 'Enter a skill name.'
                              : null))),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () {
                  if (!_key.currentState!.validate()) return;
                  Navigator.pop(context, SkillData(name: _name.text.trim()));
                },
                child: const Text('Save'))
          ]);
  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }
}

class ProjectForm extends StatefulWidget {
  const ProjectForm({super.key, this.initial});
  final ProjectData? initial;
  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final _key = GlobalKey<FormState>();
  late final List<TextEditingController> _c;
  @override
  void initState() {
    super.initState();
    final p = widget.initial;
    _c = [
      TextEditingController(text: p?.name ?? ''),
      TextEditingController(text: p?.description ?? ''),
      TextEditingController(text: p?.technologies.join(', ') ?? ''),
      TextEditingController(text: p?.repository ?? '')
    ];
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
          title: Text(widget.initial == null ? 'Add Project' : 'Edit Project'),
          content: SizedBox(
              width: 460,
              child: Form(
                  key: _key,
                  child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                    _f(0, 'Project Name', true),
                    _f(1, 'Project Description', false, 3),
                    _f(2, 'Technology Stack (comma separated)'),
                    _f(3, 'GitHub Repository URL (optional)')
                  ])))),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () {
                  if (!_key.currentState!.validate()) return;
                  Navigator.pop(
                      context,
                      ProjectData(
                          name: _c[0].text.trim(),
                          description: _c[1].text.trim(),
                          technologies: _list(_c[2].text),
                          repository: _c[3].text.trim()));
                },
                child: const Text('Save'))
          ]);
  String? _url(String? v) {
    if (v == null || v.trim().isEmpty) return null;
    final u = Uri.tryParse(v.trim());
    return u != null &&
            {'http', 'https'}.contains(u.scheme) &&
            u.host.isNotEmpty
        ? null
        : 'Enter a full http or https URL.';
  }

  Widget _f(int i, String label, [bool required = false, int lines = 1]) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: TextFormField(
              controller: _c[i],
              maxLines: lines,
              decoration: InputDecoration(labelText: label),
              validator: (v) {
                if (required && (v == null || v.trim().isEmpty)) {
                  return 'Required';
                }
                if (i == 3) return _url(v);
                return null;
              }));
  List<String> _list(String s) =>
      s.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  @override
  void dispose() {
    for (final c in _c) {
      c.dispose();
    }
    super.dispose();
  }
}

class EducationForm extends StatefulWidget {
  const EducationForm({super.key, this.initial});
  final EducationData? initial;
  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  final _key = GlobalKey<FormState>();
  late final List<TextEditingController> _c;
  @override
  void initState() {
    super.initState();
    final e = widget.initial;
    _c = [
      TextEditingController(text: e?.qualification ?? ''),
      TextEditingController(text: e?.specialization ?? ''),
      TextEditingController(text: e?.institution ?? ''),
      TextEditingController(text: e?.startYear ?? ''),
      TextEditingController(text: e?.endYear ?? ''),
      TextEditingController(text: e?.status ?? ''),
      TextEditingController(text: e?.achievements ?? '')
    ];
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
          title: Text(widget.initial == null
              ? 'Add Qualification'
              : 'Edit Qualification'),
          content: SizedBox(
              width: 440,
              child: Form(
                  key: _key,
                  child: SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                    _f(0, 'Qualification or degree', true),
                    _f(1, 'Specialization'),
                    _f(2, 'Institution name'),
                    _f(3, 'Start year'),
                    _f(4, 'End / expected graduation year'),
                    _f(5, 'Current status'),
                    _f(6, 'Marks or achievements', false, 2)
                  ])))),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () {
                  if (!_key.currentState!.validate()) return;
                  Navigator.pop(
                      context,
                      EducationData(
                          qualification: _c[0].text.trim(),
                          specialization: _c[1].text.trim(),
                          institution: _c[2].text.trim(),
                          startYear: _c[3].text.trim(),
                          endYear: _c[4].text.trim(),
                          status: _c[5].text.trim(),
                          achievements: _c[6].text.trim()));
                },
                child: const Text('Save'))
          ]);
  Widget _f(int i, String label,
          [bool required = false, int lines = 1]) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: TextFormField(
              controller: _c[i],
              maxLines: lines,
              decoration: InputDecoration(labelText: label),
              validator: (v) => required && (v == null || v.trim().isEmpty)
                  ? 'Required'
                  : null));
  @override
  void dispose() {
    for (final c in _c) {
      c.dispose();
    }
    super.dispose();
  }
}

class LinkForm extends StatefulWidget {
  const LinkForm({super.key, this.initial});
  final ProfessionalLink? initial;
  @override
  State<LinkForm> createState() => _LinkFormState();
}

class _LinkFormState extends State<LinkForm> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _label, _url;
  @override
  void initState() {
    super.initState();
    _label = TextEditingController(text: widget.initial?.label ?? '');
    _url = TextEditingController(text: widget.initial?.url ?? '');
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
          title: Text(widget.initial == null ? 'Add Link' : 'Edit Link'),
          content: Form(
              key: _key,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(
                    controller: _label,
                    decoration: const InputDecoration(labelText: 'Link label'),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Required' : null),
                TextFormField(
                    controller: _url,
                    decoration: const InputDecoration(labelText: 'URL'),
                    validator: (v) {
                      final u = Uri.tryParse(v ?? '');
                      return u != null &&
                              {'http', 'https'}.contains(u.scheme) &&
                              u.host.isNotEmpty
                          ? null
                          : 'Enter a full http or https URL.';
                    })
              ])),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    Navigator.pop(
                        context,
                        ProfessionalLink(
                            label: _label.text.trim(), url: _url.text.trim()));
                  }
                },
                child: const Text('Save'))
          ]);
  @override
  void dispose() {
    _label.dispose();
    _url.dispose();
    super.dispose();
  }
}
