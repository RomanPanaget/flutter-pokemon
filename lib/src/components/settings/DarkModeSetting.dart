import 'package:flutter/material.dart';
import 'package:flutterpokemon/src/models/ThemeModel.dart';
import 'package:provider/provider.dart';

class DarkModeSetting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DarkModeSetting();
}

class _DarkModeSetting extends State<DarkModeSetting> {
  bool _isDarkMode;
  bool _isAdaptive;

  @override
  void initState() {
    super.initState();
    ThemeModel themeModel = Provider.of<ThemeModel>(context, listen: false);
    _isDarkMode = !themeModel.light;
    _isAdaptive = themeModel.adaptive;
  }

  _setDarkMode(bool v) {
    _isDarkMode = v;
    Provider.of<ThemeModel>(context, listen: false).toggleTheme();
  }

  _setAdaptive(bool v) {
    _isAdaptive = v;
    Provider.of<ThemeModel>(context, listen: false).toggleAdaptive();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
        title: Text(
          "Dark Mode",
          style: TextStyle(fontSize: 18),
        ),
        trailing: Icon(_isAdaptive
            ? Icons.brightness_auto
            : _isDarkMode ? Icons.brightness_2 : Icons.brightness_7),
      ),
      SwitchListTile(
        title: Text("Adaptive dark mode"),
        subtitle: Text(
            "This option automatically synchronizes the app theme with your system global theme."),
        value: _isAdaptive,
        onChanged: (v) => setState(() => _setAdaptive(v)),
      ),
      SwitchListTile(
        title: Text("Dark mode"),
        value: _isDarkMode,
        onChanged:
            _isAdaptive ? null : (v) => setState(() => _setDarkMode(v)),
      ),
      Divider()
    ]);
  }
}
