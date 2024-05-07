import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_flutter/common/exceptions.dart';
import 'package:shop_flutter/data/comment.dart';
import 'package:shop_flutter/data/repo/comment_repository.dart';

part 'comment_list_event.dart';
part 'comment_list_state.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  final ICommentRepository repository;
  final int productId;

  CommentListBloc(this.repository, this.productId)
      : super(CommentListLoading()) {
    on<CommentListEvent>((event, emit) async {
      if (event is CommentListStarted) {
        emit(CommentListLoading());
        try {
          final comments = await repository.getAll(productId: productId);
          emit(CommentListSuccess(comments));
        } catch (e) {
          emit(CommentListError(AppException()));
        }
      }
    });
  }
}
