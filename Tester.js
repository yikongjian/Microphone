	
	Namespace={ Unit:{} }; //命名空间模拟
	
	Namespace.Unit.IndexOf=function(str,el,fromIndex){ //JavaScript 1.6以下Array.indexOf函数的模拟、增强
		
		for(var i=fromIndex || 0; i<str.length ; i++){
			if(str[i]===el) 
				return i
		}
		return -1
	}
	
	
	Namespace.Init=function(){ //PageLoad 初始化对象。
		this.html5=false;
		this.Loaded=[];
		
		this.Detect();//检测特性
	}
	
	
	Namespace.TesterTips=function(type,msg){
		//window.getUserMedia or Flash error message callback
	}
	
	Namespace.Detect=function(){

		if( !(navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia)) //chrome特性检测
			return;	
		if( !(window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame) )
			return;
		var dom=document.getElementById('flash')
		dom.innerHTML='<canvas id="analyser" width="1024" height="500"></canvas>'
		this.html5=true;		
	}
	
	Namespace.require=function(arr,callback){ //简单的动态脚本异步Lazy加载器实现。
		
		//该函数使用案例:
        /*Namespace.require(['js/audiodisplay.js','js/recorderjs/recorder.js','js/main.js'],function(){
     		if(Namespace.Loaded.length===3){
     			initAudio();
     		}
     	})*/
		
		var body=document.body			
		
		for(var i=0;i<arr.length;i++){
			var scriptNode=document.createElement('script');
			scriptNode.onload=function(i){
				//同时script节点的onload函数只在chrome、FireFox、Opera或者IE9+浏览器才支持。IE6/7/8支持onreadystatechange事件，
				//因为只有在chrome下才启用html5 模式以及canvas功能，故不在此屏蔽兼容了。
				return function(){
					Namespace.Loaded.push(arr[i].toString());
					if(callback!==undefined){
						callback();
					}					
				}
			}(i)
			scriptNode.src=arr[i]
			body.appendChild(scriptNode)
		}		
	}
	
	





