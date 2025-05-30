package kr.or.everyware.everyware.todo.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.todo.mapper.TodoMapper;
import kr.or.everyware.everyware.todo.vo.Todo;

@Service
public class TodoServiceImpl implements TodoService{

	@Inject
	private TodoMapper todoMapper;

	@Override
	public List<Todo> getTodoList(String empId) {
		return todoMapper.getTodoList(empId);
	}

	@Override
	public int addTodo(Todo todo) {
		return todoMapper.addTodo(todo);
	}

	@Override
	public int delTodo(int tdNo) {
		return todoMapper.delTodo(tdNo);
	}

	@Override
	public Todo getOneTodo(int tdNo) {
		return todoMapper.getOneTodo(tdNo);
	}

	@Override
	public ServiceResult editTodo(Todo todo) {
		ServiceResult result = null;
		int status = todoMapper.editTodo(todo);
		if(status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		return result;
	}
	
	@Override
	public int getTotalRecodeCount(String empId) {
		return todoMapper.getTotalRecodeCount(empId);
	}
	
	@Override
	public int getTotalTodoCount(String empId) {
		return todoMapper.getTotalTodoCount(empId);
	}

	@Override
	public int getTotalInProgressCount(String empId) {
		return todoMapper.getTotalInProgressCount(empId);
	}

	@Override
	public int getTotalDoneCount(String empId) {
		return todoMapper.getTotalDoneCount(empId);
	}

}
