import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PostService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/posts.json');
  }

  Future<List<Map<String, dynamic>>> readPosts() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        await file.writeAsString(
          jsonEncode([
            {
              'id': 1,
              'title': '커뮤니티는 공동의 관심사, 목표, 가치 혹은 지리적...',
              'content':
                  '커뮤니티는 공동의 관심사, 목표, 가치 혹은 지리적 위치를 공유하는 사람들로 이루어진 집단입니다...',
              'likes': 24,
              'comments': [
                {'name': '홍길동', 'comment': '좋은 글이네요! 감사합니다.'},
                {'name': '홍길동', 'comment': '내용 잘 읽었습니다. 많은 도움이 되었어요.'},
              ],
            },
          ]),
        );
      }
      final contents = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(contents);
      return jsonData.cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error reading posts: $e');
      return [];
    }
  }

  Future<void> writePosts(List<Map<String, dynamic>> posts) async {
    try {
      final file = await _localFile;
      await file.writeAsString(jsonEncode(posts));
    } catch (e) {
      print('Error writing posts: $e');
    }
  }

  Future<void> addPost(String title, String content) async {
    final posts = await readPosts();
    final newPost = {
      'id': posts.isEmpty ? 1 : posts.last['id'] + 1,
      'title': title,
      'content': content,
      'likes': 0,
      'comments': [],
    };
    posts.add(newPost);
    await writePosts(posts);
  }

  Future<void> updatePost(int id, String title, String content) async {
    final posts = await readPosts();
    final index = posts.indexWhere((post) => post['id'] == id);
    if (index != -1) {
      posts[index]['title'] = title;
      posts[index]['content'] = content;
      await writePosts(posts);
    }
  }

  Future<void> deletePost(int id) async {
    final posts = await readPosts();
    posts.removeWhere((post) => post['id'] == id);
    await writePosts(posts);
  }

  Future<void> updateLikes(int id, int likes) async {
    final posts = await readPosts();
    final index = posts.indexWhere((post) => post['id'] == id);
    if (index != -1) {
      posts[index]['likes'] = likes;
      await writePosts(posts);
    }
  }

  Future<void> addComment(int postId, String name, String comment) async {
    final posts = await readPosts();
    final index = posts.indexWhere((post) => post['id'] == postId);
    if (index != -1) {
      final comments = List<Map<String, dynamic>>.from(
        posts[index]['comments'],
      );
      comments.add({'name': name, 'comment': comment});
      posts[index]['comments'] = comments;
      await writePosts(posts);
    }
  }
}
