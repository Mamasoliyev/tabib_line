import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabib_line/service/cache_helper.dart';
import 'package:tabib_line/view_model/theme_provider.dart';
import 'package:tabib_line/view_model/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String? _uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchUser(_uid!);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    if (_uid == null) {
      return Scaffold(
        body: Center(
          child: Text('User not logged in', style: textTheme.bodyMedium),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('My Profile'), centerTitle: true),
      body: userProvider.isLoading
          ? Center(child: CircularProgressIndicator(color: colorScheme.primary))
          : userProvider.user == null
          ? Center(child: Text("User not found"))
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: ListView(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: colorScheme.primary.withOpacity(0.2),
                      child: userProvider.user!.name.isNotEmpty
                          ? Text(
                              userProvider.user!.name[0].toUpperCase(),
                              style: textTheme.headlineLarge?.copyWith(
                                color: colorScheme.primary,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              size: 60,
                              color: colorScheme.primary,
                            ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Center(
                    child: Text(
                      userProvider.user!.name,
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      userProvider.user!.email,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onBackground.withOpacity(0.7),
                      ),
                    ),
                  ),
                  if (userProvider.user!.phone != null &&
                      userProvider.user!.phone!.isNotEmpty)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          userProvider.user!.phone!,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onBackground.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  Divider(height: 40),
                  ListTile(
                    title: Text("Edit Profile"),
                    trailing: IconButton(
                      onPressed: () {
                        editName(context, userProvider);
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ),
                  ListTile(
                    title: Text("language".tr()),
                    trailing: DropdownButtonHideUnderline(
                      child: DropdownButton<Locale>(
                        value: context.locale,
                        icon: Icon(Icons.language, color: Colors.black),
                        items: [
                          DropdownMenuItem(
                            value: Locale('uz'),
                            child: Text("UZ"),
                          ),
                          DropdownMenuItem(
                            value: Locale('ru'),
                            child: Text("RU"),
                          ),
                          DropdownMenuItem(
                            value: Locale('en'),
                            child: Text("EN"),
                          ),
                        ],
                        onChanged: (Locale? value) async {
                          if (value == null) return;
                          await context.setLocale(value);
                          await CacheHelper.cacheLan(value);
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("App Theme".tr()),
                    trailing: DropdownButton<ThemeMode>(
                      value: themeProvider.themeMode,
                      onChanged: (ThemeMode? newMode) {
                        if (newMode != null) {
                          themeProvider.setThemeMode(newMode);
                        }
                      },
                      items: [
                        DropdownMenuItem(
                          value: ThemeMode.system,
                          child: Text("System"),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.light,
                          child: Text("Light"),
                        ),
                        DropdownMenuItem(
                          value: ThemeMode.dark,
                          child: Text("Dark"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(context, 'log_in');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    icon: Icon(Icons.logout),
                    label: Text(
                      "Log Out",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void editName(BuildContext context, UserProvider userProvider) {
    final TextEditingController _nameController = TextEditingController(
      text: userProvider.user?.name ?? "",
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Name"),
        content: TextField(
          controller: _nameController,
          decoration: InputDecoration(hintText: "Enter new name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final newName = _nameController.text.trim();
              if (newName.isNotEmpty && userProvider.user != null) {
                await userProvider.updateUser(
                  uid: userProvider.user!.uid,
                  name: newName,
                );
              }
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
