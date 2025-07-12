import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jusicool_ios/core/config/di/dependencies.dart';
import 'package:jusicool_ios/domain/community/usecase/community_usecase.dart';
import 'package:jusicool_ios/presentation/community/state/community_post_list_state.dart';

final communityControllerProvider = 
    StateNotifierProvider<CommunityController, CommunityPostListState>(
      (ref) => CommunityController(di.get<CommunityUsecase>())
    );

class CommunityController extends StateNotifier<CommunityPostListState> {
  final CommunityUsecase _communityUsecase;

  CommunityController(this._communityUsecase) : super(CommunityPostListState()) {
    titleController.addListener(() => _onTitleChanged());
    contentController.addListener(() => _onContentChanged());
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void disposeResources() {
    titleController.dispose();
    contentController.dispose();
  }

  void _onTitleChanged() {
    
  }

  void _onContentChanged() {

  }

  Future<void> fetchCommunityPost(String market) async {
    try{
      state = state.copyWith(isLoading: true, errorMessage: '');
      final posts = await _communityUsecase.fetchCommunity(market);
      state = state.copyWith(
        posts: posts,
        selectedMarket: market,
        isLoading: false,
      );
    } catch(e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString()
      );
    }
  }

  
}