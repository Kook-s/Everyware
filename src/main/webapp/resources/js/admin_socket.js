window.onload=function(){
	wsOpen()
}
function wsOpen(){	
ws = new WebSocket("ws://"+location.host+"/chatting");
	console.log("소켓 온")
}
