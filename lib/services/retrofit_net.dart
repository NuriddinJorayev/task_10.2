import 'package:dio/dio.dart';
import 'package:last_block/models/user.dart';
import 'package:retrofit/http.dart';
part 'retrofit_net.g.dart';

//https://6265b7fedbee37aff9a83f80.mockapi.io/api/users/
// I  used retrofit package with bloc
@RestApi(baseUrl: "https://6265b7fedbee37aff9a83f80.mockapi.io")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;
  @GET("/api/users/")
  Future<List<User>> getTask();

  @POST("/api/users")
  Future<String> create_task(@Body() User u);

  @DELETE("/api/users/{id}")
  Future<String> Delete_task(@Path() String id);

  @PUT("/api/users/{id}")
  Future<String> Update_task(@Path() String id, @Body() User u);
}
