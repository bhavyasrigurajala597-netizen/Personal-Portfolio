/// Central profile model and starter configuration for Campus Connect.
/// Enter personal details through Edit Profile, or change the defaults here.
class ProfileData {
  factory ProfileData.initial() => ProfileData(
        name: 'Bhavya Sri Gurajala',
        headline: 'BTech Artificial Intelligence & Data Science',
        degree: 'BTech Artificial Intelligence & Data Science',
        college: 'Malineni Lakshmaiah Womens Engineering College',
        currentYear: '3rd Year',
        location: 'Andhra Pradesh',
        profileImage: 'assets/images/profile.jpg',
        about:
            "I'm a Computer Science student learning programming and building projects with AI tools.",
        careerGoal:
            'Get a paid software development internship and build useful real-world projects.',
        email: 'bhavyasrigurajala597@gmail.com',
        phone: '9123456789',
        github: 'https://github.com/bhavyasrigurajala597-netizen',
        linkedin: 'https://www.linkedin.com/in/bhavya-sri-gurajala-37a653350/',
        schoolName: 'Mahaveer School',
        schoolPercentage: '80.5',
        intermediateCollegeName: 'Sri Vikas Junior College',
        intermediatePercentage: '96.2',
        degreeInstitutionName: 'Malineni Lakshmaiah Womens Engineering College',
        degreeAcademicStatus: 'Pursuing',
        degreeCurrentYear: '3rd Year',
        degreeCurrentCgpa: '8.7',
        interests: const [
          'AI',
          'Software Development',
          'Building Useful Projects'
        ],
        skills: [
          'C basics',
          'Python fundamentals',
          'HTML',
          'CSS',
          'JavaScript',
          'Flutter',
          'Dart',
          'Git',
          'GitHub'
        ].map((name) => SkillData(name: name)).toList(),
        projects: [
          ProjectData(name: 'AI Travel Planner'),
          ProjectData(name: 'AI Expense Tracker')
        ],
      );

  ProfileData({
    this.name = '',
    this.headline = '',
    this.degree = '',
    this.college = '',
    this.currentYear = '',
    this.location = '',
    this.profileImage = '',
    this.about = '',
    this.careerGoal = '',
    this.email = '',
    this.phone = '',
    this.github = '',
    this.linkedin = '',
    this.schoolName = '',
    this.schoolPercentage = '',
    this.intermediateCollegeName = '',
    this.intermediatePercentage = '',
    this.degreeInstitutionName = '',
    this.degreeAcademicStatus = '',
    this.degreeCurrentYear = '',
    this.degreeCurrentCgpa = '',
    this.degreeFinalCgpa = '',
    this.welcomeHeading = '',
    this.introTagline = '',
    this.heroDescription = '',
    this.featuredProjects = const [],
    this.featuredSkills = const [],
    this.filterFeaturedProjects = false,
    this.filterFeaturedSkills = false,
    this.showHeroSkills = true,
    this.showHeroProjects = true,
    this.showHeroContact = true,
    this.showHeroEdit = true,
    this.interests = const [],
    this.otherLinks = const [],
    this.skills = const [],
    this.projects = const [],
    this.education = const [],
  });

  String name, headline, degree, college, currentYear, location, profileImage;
  String about, careerGoal, email, phone, github, linkedin;
  String schoolName,
      schoolPercentage,
      intermediateCollegeName,
      intermediatePercentage;
  String degreeInstitutionName,
      degreeAcademicStatus,
      degreeCurrentYear,
      degreeCurrentCgpa,
      degreeFinalCgpa;
  String welcomeHeading, introTagline, heroDescription;
  bool showHeroSkills, showHeroProjects, showHeroContact, showHeroEdit;
  bool filterFeaturedProjects, filterFeaturedSkills;
  List<String> featuredProjects, featuredSkills;
  List<String> interests;
  List<ProfessionalLink> otherLinks;
  List<SkillData> skills;
  List<ProjectData> projects;
  List<EducationData> education;

  Map<String, dynamic> toJson() => {
        'name': name,
        'headline': headline,
        'degree': degree,
        'college': college,
        'currentYear': currentYear,
        'location': location,
        'profileImage': profileImage,
        'about': about,
        'careerGoal': careerGoal,
        'email': email,
        'phone': phone,
        'github': github,
        'linkedin': linkedin,
        'schoolName': schoolName,
        'schoolPercentage': schoolPercentage,
        'intermediateCollegeName': intermediateCollegeName,
        'intermediatePercentage': intermediatePercentage,
        'degreeInstitutionName': degreeInstitutionName,
        'degreeAcademicStatus': degreeAcademicStatus,
        'degreeCurrentYear': degreeCurrentYear,
        'degreeCurrentCgpa': degreeCurrentCgpa,
        'degreeFinalCgpa': degreeFinalCgpa,
        'welcomeHeading': welcomeHeading,
        'introTagline': introTagline,
        'heroDescription': heroDescription,
        'featuredProjects': featuredProjects,
        'featuredSkills': featuredSkills,
        'filterFeaturedProjects': filterFeaturedProjects,
        'filterFeaturedSkills': filterFeaturedSkills,
        'showHeroSkills': showHeroSkills,
        'showHeroProjects': showHeroProjects,
        'showHeroContact': showHeroContact,
        'showHeroEdit': showHeroEdit,
        'interests': interests,
        'otherLinks': otherLinks.map((e) => e.toJson()).toList(),
        'skills': skills.map((e) => e.toJson()).toList(),
        'projects': projects.map((e) => e.toJson()).toList(),
        'education': education.map((e) => e.toJson()).toList(),
      };

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        name: _str(json, 'name'),
        headline: _str(json, 'headline'),
        degree: _str(json, 'degree'),
        college: _str(json, 'college'),
        currentYear: _str(json, 'currentYear'),
        location: _str(json, 'location'),
        profileImage: _str(json, 'profileImage'),
        about: _str(json, 'about'),
        careerGoal: _str(json, 'careerGoal'),
        email: _str(json, 'email'),
        phone: _str(json, 'phone'),
        github: _str(json, 'github'),
        linkedin: _str(json, 'linkedin'),
        schoolName:
            _str(json, 'schoolName', _legacyInstitution(json, 'school')),
        schoolPercentage: _str(json, 'schoolPercentage'),
        intermediateCollegeName: _str(json, 'intermediateCollegeName',
            _legacyInstitution(json, 'intermediate')),
        intermediatePercentage: _str(json, 'intermediatePercentage'),
        degreeInstitutionName: _str(
            json, 'degreeInstitutionName', _legacyInstitution(json, 'degree')),
        degreeAcademicStatus:
            _str(json, 'degreeAcademicStatus', _legacyDegreeStatus(json)),
        degreeCurrentYear:
            _str(json, 'degreeCurrentYear', _str(json, 'currentYear')),
        degreeCurrentCgpa: _str(json, 'degreeCurrentCgpa'),
        degreeFinalCgpa: _str(json, 'degreeFinalCgpa'),
        welcomeHeading: _str(json, 'welcomeHeading'),
        introTagline: _str(json, 'introTagline'),
        heroDescription: _str(json, 'heroDescription'),
        featuredProjects: _strings(json['featuredProjects']),
        featuredSkills: _strings(json['featuredSkills']),
        filterFeaturedProjects: json['filterFeaturedProjects'] is bool
            ? json['filterFeaturedProjects'] as bool
            : false,
        filterFeaturedSkills: json['filterFeaturedSkills'] is bool
            ? json['filterFeaturedSkills'] as bool
            : false,
        showHeroSkills: json['showHeroSkills'] is bool
            ? json['showHeroSkills'] as bool
            : true,
        showHeroProjects: json['showHeroProjects'] is bool
            ? json['showHeroProjects'] as bool
            : true,
        showHeroContact: json['showHeroContact'] is bool
            ? json['showHeroContact'] as bool
            : true,
        showHeroEdit:
            json['showHeroEdit'] is bool ? json['showHeroEdit'] as bool : true,
        interests: _strings(json['interests']),
        otherLinks: _objects(json['otherLinks'])
            .map(ProfessionalLink.fromJson)
            .toList(),
        skills: _objects(json['skills']).map(SkillData.fromJson).toList(),
        projects: _objects(json['projects']).map(ProjectData.fromJson).toList(),
        education:
            _objects(json['education']).map(EducationData.fromJson).toList(),
      );


}

class SkillData {
  SkillData({this.name = ''});
  String name;
  Map<String, dynamic> toJson() => {'name': name};
  factory SkillData.fromJson(Map<String, dynamic> j) =>
      SkillData(name: _str(j, 'name'));
}

class ProjectData {
  ProjectData(
      {this.name = '',
      this.description = '',
      this.technologies = const [],
      this.repository = ''});
  String name, description, repository;
  List<String> technologies;
  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'technologies': technologies,
        'repository': repository
      };
  factory ProjectData.fromJson(Map<String, dynamic> j) => ProjectData(
      name: _str(j, 'name'),
      description: _str(j, 'description'),
      technologies: _strings(j['technologies']),
      repository: _str(j, 'repository'));
}

class EducationData {
  EducationData(
      {this.qualification = '',
      this.institution = '',
      this.specialization = '',
      this.startYear = '',
      this.endYear = '',
      this.status = '',
      this.achievements = ''});
  String qualification,
      institution,
      specialization,
      startYear,
      endYear,
      status,
      achievements;
  Map<String, dynamic> toJson() => {
        'qualification': qualification,
        'institution': institution,
        'specialization': specialization,
        'startYear': startYear,
        'endYear': endYear,
        'status': status,
        'achievements': achievements
      };
  factory EducationData.fromJson(Map<String, dynamic> j) => EducationData(
      qualification: _str(j, 'qualification'),
      institution: _str(j, 'institution'),
      specialization: _str(j, 'specialization'),
      startYear: _str(j, 'startYear'),
      endYear: _str(j, 'endYear'),
      status: _str(j, 'status'),
      achievements: _str(j, 'achievements'));
}

class ProfessionalLink {
  ProfessionalLink({this.label = '', this.url = ''});
  String label, url;
  Map<String, dynamic> toJson() => {'label': label, 'url': url};
  factory ProfessionalLink.fromJson(Map<String, dynamic> j) =>
      ProfessionalLink(label: _str(j, 'label'), url: _str(j, 'url'));
}

String _str(Map<String, dynamic> j, String key, [String fallback = '']) =>
    j[key] is String ? j[key] as String : fallback;
String _legacyInstitution(Map<String, dynamic> json, String type) {
  final records = _objects(json['education']);
  for (final record in records) {
    final title = _str(record, 'qualification').toLowerCase();
    final matches = switch (type) {
      'school' => title.contains('school'),
      'intermediate' => title.contains('intermediate'),
      _ => title.contains('degree') || title.contains('undergraduate'),
    };
    if (matches) return _str(record, 'institution');
  }
  return '';
}

String _legacyDegreeStatus(Map<String, dynamic> json) {
  for (final record in _objects(json['education'])) {
    final title = _str(record, 'qualification').toLowerCase();
    if (title.contains('degree') || title.contains('undergraduate')) {
      final status = _str(record, 'status').toLowerCase();
      if (status.contains('pursu')) return 'Pursuing';
      if (status.contains('passed')) return 'Passed Out';
    }
  }
  return '';
}

List<String> _strings(dynamic value) =>
    value is List ? value.whereType<String>().toList() : [];
List<Map<String, dynamic>> _objects(dynamic value) => value is List
    ? value.whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList()
    : [];
