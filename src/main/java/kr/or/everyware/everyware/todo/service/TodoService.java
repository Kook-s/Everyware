package kr.or.everyware.everyware.todo.service;

import java.util.List;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.todo.vo.Todo;

public interface TodoService {

	public List<Todo> getTodoList(String empId);
	public int addTodo(Todo todo);
	public int delTodo(int tdNo);
	public Todo getOneTodo(int tdNo);
	public ServiceResult editTodo(Todo todo);
	// Todo 현황
	public int getTotalRecodeCount(String empId);
	public int getTotalTodoCount(String empId);
	public int getTotalInProgressCount(String empId);
	public int getTotalDoneCount(String empId);
//
}
