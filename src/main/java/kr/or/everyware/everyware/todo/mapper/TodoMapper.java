package kr.or.everyware.everyware.todo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.todo.vo.Todo;

@Mapper
public interface TodoMapper {

	public List<Todo> getTodoList(String empId);
	public int addTodo(Todo todo);
	public int delTodo(int tdNo);
	public Todo getOneTodo(int tdNo);
	public int editTodo(Todo todo);
	// 
	public int getTotalRecodeCount(String empId);
	public int getTotalTodoCount(String empId);
	public int getTotalInProgressCount(String empId);
	public int getTotalDoneCount(String empId);

}
