import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counterpage_sma/model/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<TodoEventAdd>((event, emit) {
      final currenState = state;
      if (currenState is TodoLoaded) {
        final List<Todo> updatedTodos = List.from(currenState.todos);
        updatedTodos.add(
          Todo(title: event.title, isCompleted: false, date: event.date),
        );
        emit(
          TodoLoaded(
            todos: updatedTodos,
            selectedDate: currenState.selectedDate,
          ),
        );
      }
    });

    on<TodoSelecDate>((event, emit) {
      final currenState = state;
      if (currenState is TodoLoaded) {
        emit(TodoLoaded(todos: currenState.todos, selectedDate: event.date));
      }
    });

    on<TodoEventComplete>((event, emit) {
      final currenState = state;
      if (currenState is TodoLoaded) {
        final List<Todo> updatedTodos = List.from(currenState.todos);
        if (event.index >= 0 && event.index < updatedTodos.length) {
          updatedTodos[event.index] = Todo(
            title: updatedTodos[event.index].title,
            isCompleted: updatedTodos[event.index].isCompleted == true,
            // isCompleted; !updatedTodos[event.index].isCompleted,
            date: updatedTodos[event.index].date,
          );
          emit(
            TodoLoaded(
              todos: updatedTodos,
              selectedDate: currenState.selectedDate,
            ),
          );
        }
      }
    });
  }
}
