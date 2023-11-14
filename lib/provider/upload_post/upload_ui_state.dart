import 'package:blog_rest_api_with_provider/data/model/blog_upload_response.dart';

abstract class UploadUiState{

}

class UploadFormState extends UploadUiState{

}

class UploadUiLoading extends UploadUiState{
  final int progress;

  UploadUiLoading(this.progress);
}

class UploadUiSuccess extends UploadUiState{
  final BlogUploadResponse blogUploadResponse;

  UploadUiSuccess(this.blogUploadResponse);
}

class UploadUiFailed extends UploadUiState{
  final String errorMessage;

  UploadUiFailed(this.errorMessage);

}