# Campus Connect

Responsive Flutter Web portfolio with Home, About, Contact, Skills, and Qualifications sections. Profile information is empty by default so the site does not claim personal details that have not been entered.

## Run locally

Open PowerShell in the folder containing `pubspec.yaml`:

```powershell
cd C:\Users\bhavy\Downloads\campus_connect
flutter pub get
flutter run -d chrome
```

## Add your information

Use the **Edit Profile** button in the header to open the editor for the currently selected section, or use that section's Edit button. Home edits the welcome text, name, and headline. About edits only the profile image URL and biography. Contact accepts email, phone, GitHub, LinkedIn, and optional professional links. Skills contain names only. Qualifications use School, Intermediate, and Degree groups; percentage values are validated from 0 to 100, and CGPA uses a configurable 0 to 10 scale.

Each page opens its own editor: **Edit Home**, **Edit About**, **Edit Contact**, **Manage Skills**, or **Manage Qualifications**. Home has a separate **Manage Projects** action; project data remains editable without appearing as a Home snapshot. Skills and projects can be added, edited, or deleted. Other professional links can be added or removed from Contact.

The editor validates email and web URLs. Save stores the profile in this browser's local storage; it does not sync to other browsers or devices. Existing saved skill names are retained and converted to name-only entries when saved from Manage Skills. The editor is not protected by authentication, so anyone who can access the page can edit the profile.

For source-based editing, the centralized data model and empty starter profile are in `lib/profile_data.dart`; the UI and editor are in `lib/main.dart`.

## Build and deploy

```powershell
flutter build web
```

Deploy `build/web` to a static host such as Vercel or GitHub Pages. For a GitHub Pages project site, include its repository path:

```powershell
flutter build web --base-href /REPOSITORY_NAME/
```

Replace `REPOSITORY_NAME` with the Pages repository name. A root domain can use the default base path.
