import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  const FiltersScreen(this.saveFilters, this.currentFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isVegetarian = false;
  bool _isVegan = false;
  bool _isLactoseFree = false;

  @override
  void initState() {
    _isGlutenFree = widget.currentFilters['gluten'];
    _isLactoseFree = widget.currentFilters['lactose'];
    _isVegan = widget.currentFilters['vegan'];
    _isVegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your filters'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final _selectedFilters = {
                  'gluten': _isGlutenFree,
                  'vegetarian': _isVegetarian,
                  'vegan': _isVegan,
                  'lactose': _isLactoseFree,
                };
                widget.saveFilters(_selectedFilters);
              }),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              buildSwitchListTile(
                title: 'Gluten-free',
                subtitle: 'Only include gluten-free meals',
                currentValue: _isGlutenFree,
                updateValue: (newValue) {
                  setState(() => _isGlutenFree = newValue);
                },
              ),
              buildSwitchListTile(
                title: 'Lactose-free',
                subtitle: 'Only include lactose-free meals',
                currentValue: _isLactoseFree,
                updateValue: (newValue) {
                  setState(() => _isLactoseFree = newValue);
                },
              ),
              buildSwitchListTile(
                title: 'Vegetarian',
                subtitle: 'Only include vegetarian meals',
                currentValue: _isVegetarian,
                updateValue: (newValue) {
                  setState(() => _isVegetarian = newValue);
                },
              ),
              buildSwitchListTile(
                title: 'Vegan',
                subtitle: 'Only include vegan meals',
                currentValue: _isVegan,
                updateValue: (newValue) {
                  setState(() => _isVegan = newValue);
                },
              ),
            ],
          ))
        ],
      ),
    );
  }

  SwitchListTile buildSwitchListTile(
      {String title,
      String subtitle,
      bool currentValue,
      Function updateValue}) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }
}
