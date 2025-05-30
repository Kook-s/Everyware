package kr.or.everyware.everyware.todo.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.todo.service.TodoService;
import kr.or.everyware.everyware.todo.vo.Todo;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/everyware")
public class TodoController {

	@Inject
	private TodoService todoService;
	
	/**
	 * 페이지 이동 goTodo
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('TODO')")
	@GetMapping(value = "/todo")
	public String goTodo() {
		log.info("goTodo()");
		return "everyware/todo/todo";
	}
	
	/**
	 * 목록 getTodoList
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/todo/todoList", produces = "application/json; charset=utf-8")
	public Map<String, Object> getTodoList(
			Authentication authentication
			, Model model){
		log.info("getTodoList()");
		
		// security User
		Todo todo = new Todo();
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String empId = user.getUsername();
		todo.setEmpId(empId);
		
		HashMap<String, Object> todoMap = new HashMap<String, Object>();
		
		// Todo 현황
		int totalRecode = todoService.getTotalRecodeCount(empId);
		int totalToDo = todoService.getTotalTodoCount(empId);
		int totalInProgress = todoService.getTotalInProgressCount(empId);
		int totalDone = todoService.getTotalDoneCount(empId);
		
		List<Todo> dataList = todoService.getTodoList(empId);
		
		todoMap.put("totalRecode", totalRecode);
		todoMap.put("totalToDo", totalToDo);
		todoMap.put("totalInProgress", totalInProgress);
		todoMap.put("totalDone", totalDone);
		todoMap.put("dataList", dataList);
		
//		log.info("totalRecode : " + totalRecode);
		log.info("dataList : " + dataList);
		model.addAttribute("todoActive", "active");
		return todoMap;
	}
	
	/**
	 * 추가 addTodo
	 * @param todo
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/todo/addTodo", produces = "application/json; charset=utf-8")
	public String addTodo(
			@RequestBody Todo todo
			, Model model) {
		log.info("addTodo()");
		
		// security User
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String empId = user.getUsername();
		todo.setEmpId(empId);
		model.addAttribute("todoActive", "active");
		
		log.info("todo : " + todo);
		if(todoService.addTodo(todo) > 0) {
			return "success";
		}else {
		    return "fail";
		}
	}
	
	/**
	 * 삭제 delTodo
	 * @param tdNo
	 * @return
	 */
	@ResponseBody
	@DeleteMapping(value = "/todo/delTodo/{tdNo}", produces = "application/json; charset=utf-8")
	public String delTodo(@PathVariable("tdNo") int tdNo) {
		log.info("delTodo()");
		log.info("tdNo :" + tdNo);
		String resTxt = "";
		
		// security User
//		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		String empId = user.getUsername();
		
		int res = todoService.delTodo(tdNo);
		log.info("res :" + res);
		
		if(res > 0) {
			resTxt = "success";
		}else {
			resTxt = "fail";
		}
		
		return resTxt;
	}
	
	/**
	 * 상세보기 getOneTodo
	 * @param tdNo
	 * @return
	 */
	@ResponseBody
	@GetMapping(value = "/todo/getOneTodo/{tdNo}", produces = "application/json; charset=utf-8")
	public Todo getOneTodo(
			@PathVariable("tdNo") int tdNo
			, Model model) {
		log.info("getOneTodo()");
		
		Todo todo = new Todo();
		todo = todoService.getOneTodo(tdNo);
		log.info("todoDetail : " + todo);
		model.addAttribute("todoActive", "active");
		return todo;
	}
	
	/**
	 * 수정 editTodo
	 * @param todo
	 * @return
	 */
	@ResponseBody
	@PutMapping(value = "/todo/editTodo", produces = "application/json; charset=utf-8")
	public String editTodo(
			@RequestBody Todo todo
			, Model model) {
		log.info("editTodo()");
		model.addAttribute("todoActive", "active");
		String resTxt = "";
		
		ServiceResult result = todoService.editTodo(todo);
		if(result.equals(ServiceResult.OK)) {
			resTxt = "success";
		} else {
			resTxt = "fail";
		}
			
		return resTxt;
	}
	
	
//	메인페이지 투두
	@ResponseBody
	@RequestMapping(value = "/todo/getMainTodo", produces = "application/json; charset=utf-8")
	public List<Todo> getMainTodo() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();	
		
		List<Todo> list = todoService.getTodoList(employee.getEmpId());	
			
		return list;
	}
	
	
	
}
