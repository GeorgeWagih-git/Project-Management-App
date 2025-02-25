import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class InlineSearchBar extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _InlineSearchBarState createState() => _InlineSearchBarState();
}

class _InlineSearchBarState extends State<InlineSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  List<String> searchTerms = [
    'Mobile App Wireframe',
    'Read Estate App Design',
    'Dashboard & App Design',
    'Complete Flutter project',
    'Fix bugs in the app',
    'Design new UI',
    'Write documentation',
    'Test the application',
    'Deploy to production',
  ];
  List<String> filteredTerms = [];

  void _showOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(10),
            child: filteredTerms.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredTerms.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredTerms[index]),
                        onTap: () {
                          _controller.text = filteredTerms[index];
                          _hideOverlay();
                        },
                      );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("No Results"),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && _controller.text.isNotEmpty) {
        _showOverlay();
      } else {
        _hideOverlay();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          style: TextStyle(color: Colors.white),
          controller: _controller,
          focusNode: _focusNode,
          onChanged: (query) {
            setState(() {
              filteredTerms = searchTerms
                  .where((term) =>
                      term.toLowerCase().contains(query.toLowerCase()))
                  .toList();
              if (query.isNotEmpty) {
                _showOverlay();
              } else {
                _hideOverlay();
              }
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xff455A64),
            hintText: 'Search Project',
            hintStyle: TextStyle(color: Color(0xff6F8793)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixIcon: Icon(Icons.search, color: Color(0xff6F8793)),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      _hideOverlay();
                      setState(() {});
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> searchTerms = const [
    'Apple',
    'Banana',
    'Pear',
    'Watermelons',
    'Oranges',
    'BlueBerries',
    'StrawBerries',
    'Raspberries',
  ];

  // وظيفة للحصول على النتائج المطابقة
  List<String> _getMatchQuery(List<String> searchTerms, String query) {
    return searchTerms
        .where((fruit) => fruit.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // وظيفة لبناء قائمة النتائج
  Widget _buildResultsList(
      BuildContext context, List<String> results, Function(String) onItemTap) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            onItemTap(result);
          },
        );
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = ''; // مسح النص الموجود في حقل البحث
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, ''); // إغلاق البحث
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final matchQuery =
        _getMatchQuery(searchTerms, query); // الحصول على النتائج المطابقة
    return _buildResultsList(context, matchQuery, (result) {
      close(context, result); // إغلاق البحث وإرجاع النتيجة
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final matchQuery =
        _getMatchQuery(searchTerms, query); // الحصول على الاقتراحات المطابقة

    if (query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search, size: 50, color: Colors.grey),
            const SizedBox(height: 10),
            Text(
              'اكتب للبحث...',
              style: TextStyle(color: Colors.grey[600], fontSize: 18),
            ),
          ],
        ),
      );
    }

    if (matchQuery.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 50, color: Colors.grey),
            const SizedBox(height: 10),
            Text(
              'لا توجد نتائج لـ "$query"',
              style: TextStyle(color: Colors.grey[600], fontSize: 18),
            ),
          ],
        ),
      );
    }

    return _buildResultsList(context, matchQuery, (result) {
      close(context, result); // إغلاق البحث وإرجاع النتيجة
    });
  }
}

// وظيفة للحصول على النتائج المطابقة

import 'package:flutter/material.dart';

// ignore: unused_element
List<String> _getMatchQuery(List<String> searchTerms, String query) {
  return searchTerms
      .where((fruit) => fruit.toLowerCase().contains(query.toLowerCase()))
      .toList();
}

// وظيفة لبناء قائمة النتائج
// ignore: unused_element
Widget _buildResultsList(
    BuildContext context, List<String> results, Function(String) onItemTap) {
  return ListView.builder(
    itemCount: results.length,
    itemBuilder: (context, index) {
      final result = results[index];
      return ListTile(
        title: Text(result),
        onTap: () {
          onItemTap(result);
        },
      );
    },
  );
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> searchTerms = [
    'Apple',
    'Banana',
    'Pear',
    'Watermelons',
    'Oranges',
    'BlueBerries',
    'StrawBerries',
    'Raspberries',
  ];

  // وظيفة للحصول على النتائج المطابقة
  List<String> _getMatchQuery(List<String> searchTerms, String query) {
    return searchTerms
        .where((fruit) => fruit.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // وظيفة لبناء قائمة النتائج
  Widget _buildResultsList(
      BuildContext context, List<String> results, Function(String) onItemTap) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            onItemTap(result);
          },
        );
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = ''; // مسح النص الموجود في حقل البحث
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final matchQuery =
        _getMatchQuery(searchTerms, query); // الحصول على النتائج المطابقة
    return _buildResultsList(context, matchQuery, (result) {
      close(context, result); // إغلاق البحث وإرجاع النتيجة
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final matchQuery =
        _getMatchQuery(searchTerms, query); // الحصول على الاقتراحات المطابقة

    if (query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search, size: 50, color: Colors.grey),
            const SizedBox(height: 10),
            Text(
              'اكتب للبحث...',
              style: TextStyle(color: Colors.grey[600], fontSize: 18),
            ),
          ],
        ),
      );
    }

    if (matchQuery.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 50, color: Colors.grey),
            const SizedBox(height: 10),
            Text(
              'لا توجد نتائج لـ "$query"',
              style: TextStyle(color: Colors.grey[600], fontSize: 18),
            ),
          ],
        ),
      );
    }

    return _buildResultsList(context, matchQuery, (result) {
      close(context, result); // إغلاق البحث وإرجاع النتيجة
    });
  }
}*/

/*import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Apple',
    'Banana',
    'Pear',
    'Watermelons',
    'Oranges',
    'BlueBerries',
    'StrawBerries',
    'Raspberries',
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
      itemCount: matchQuery.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
      itemCount: query.length,
    );
  }
}*/
