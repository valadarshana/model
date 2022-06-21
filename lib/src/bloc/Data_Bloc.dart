import 'package:bloc/bloc.dart';
import 'Data_Events.dart';
import 'Data_State.dart';
import '../repository/Data_Repository.dart';

class DataBloc extends Bloc<UsersEvent, UsersState> {
  final DataRepository dataRepository;

  DataBloc({required this.dataRepository}) : super(UsersLoading());

  UsersState get initialState => InitialUsersState();

  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if (event is FetchData) {
      yield UsersLoading();
      try {
        final List<Object> responseData = await dataRepository.getData();
        yield UsersLoaded(responseData: responseData);
      } catch (e) {
        yield UsersError(e);
      }
    }
  }
}