import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'detail_beasiswa_screen.dart';
import 'admin_main_nav_screen.dart';
import 'main_nav_screen.dart';

class SearchScreen extends StatefulWidget {
  final bool isAdmin;

  const SearchScreen({
    super.key,
    this.isAdmin = false,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  String keyword = '';

  final List<String> recentSearches = [];

  final List<Map<String, String>> recentData = [
    {
      'title': 'Universitas Lambung Mangkurat',
      'desc':
          'Beasiswa diberikan kepada mahasiswa aktif S1 dengan ketentuan semester yang menyesuaikan jenis beasiswa.',
      'detail':
          'Universitas Lambung Mangkurat menyediakan berbagai program bantuan pendidikan untuk mahasiswa aktif yang memenuhi syarat administrasi dan akademik.',
      'region': 'Kalsel',
      'imageUrl': '',
    },
    {
      'title': 'Universitas Muhammadiyah',
      'desc':
          'Universitas ini menyediakan beberapa jenis beasiswa, seperti KIP Kuliah dan beasiswa prestasi.',
      'detail':
          'Beasiswa ini diberikan untuk membantu mahasiswa yang memenuhi syarat akademik maupun administrasi.',
      'region': 'Kalteng',
      'imageUrl': '',
    },
    {
      'title': 'Universitas Palangkaraya',
      'desc': 'Kampus ini menyediakan informasi beasiswa untuk mahasiswanya.',
      'detail':
          'Biasanya mencakup beasiswa pemerintah, prestasi, dan bantuan pendidikan.',
      'region': 'Kalteng',
      'imageUrl': '',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void goToHome() {
    if (widget.isAdmin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const AdminMainNavScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const MainNavScreen(),
        ),
      );
    }
  }

  void openDetail(Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailBeasiswaScreen(
          title: '${data['title'] ?? ''}',
          desc: '${data['desc'] ?? ''}',
          detail: '${data['detail'] ?? ''}',
          region: '${data['region'] ?? ''}',
          imageUrl: '${data['imageUrl'] ?? ''}',
        ),
      ),
    );
  }

  void addRecentSearch(String value) {
    final text = value.trim();

    if (text.isEmpty) return;

    recentSearches.removeWhere(
      (item) => item.toLowerCase() == text.toLowerCase(),
    );

    recentSearches.insert(0, text);

    if (recentSearches.length > 5) {
      recentSearches.removeLast();
    }
  }

  void useRecentSearch(String text) {
    searchController.text = text;

    setState(() {
      keyword = text.toLowerCase().trim();
      addRecentSearch(text);
    });
  }

  List<Map<String, String>> getFilteredRecent() {
    if (keyword.isEmpty) return recentData;

    return recentData.where((item) {
      final title = item['title']!.toLowerCase();
      final desc = item['desc']!.toLowerCase();
      final region = item['region']!.toLowerCase();

      return title.contains(keyword) ||
          desc.contains(keyword) ||
          region.contains(keyword);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final data = getFilteredRecent();

    return Scaffold(
      backgroundColor: const Color(0xFFEFFFF6),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF72C386),
              Color(0xFFEFFFF6),
              Colors.white,
            ],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 18, 24, 0),
                child: Row(
                  children: [
                    Container(
                      width: 41,
                      height: 41,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: goToHome,
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 22,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          controller: searchController,
                          autofocus: true,
                          onChanged: (value) {
                            setState(() {
                              keyword = value.toLowerCase().trim();
                              addRecentSearch(value);
                            });
                          },
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.search,
                              size: 28,
                              color: Colors.black,
                            ),
                            hintText: 'Search',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FFFB),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(38),
                      topRight: Radius.circular(38),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recent',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 16),

                        if (recentSearches.isEmpty)
                          const Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: Text(
                              'Belum ada pencarian',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          )
                        else
                          Column(
                            children: recentSearches.map((item) {
                              return _recentItem(item);
                            }).toList(),
                          ),

                        const SizedBox(height: 16),

                        if (data.isEmpty)
                          const Center(
                            child: Text('Data tidak ditemukan'),
                          )
                        else
                          Column(
                            children: data.map((item) {
                              return _searchCard(item);
                            }).toList(),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recentItem(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 19),
    child: Row(
      children: [
        const Icon(
          Icons.access_time_rounded,
          size: 24,
        ),

        const SizedBox(width: 13),

        Expanded(
          child: GestureDetector(
            onTap: () => useRecentSearch(title),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
            setState(() {
              recentSearches.remove(title);
            });
          },
          child: const Icon(
            Icons.close_rounded,
            size: 20,
            color: Colors.black54,
          ),
        ),
      ],
    ),
  );
}

  Widget _searchCard(Map<String, String> item) {
    return GestureDetector(
      onTap: () => openDetail(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.20),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 88,
              color: const Color(0xFFE8F5EC),
              child: item['imageUrl']!.isNotEmpty
                  ? Image.network(
                      item['imageUrl']!,
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.image_outlined,
                      size: 35,
                      color: Colors.black38,
                    ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 88,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['desc'] ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        height: 1.1,
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.bookmark,
                        size: 20,
                        color: Colors.yellow.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}