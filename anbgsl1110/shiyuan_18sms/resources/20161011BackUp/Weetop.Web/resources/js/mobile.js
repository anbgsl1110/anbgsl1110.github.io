/*
 * chengd
 * 2015-1-12
 * 移动端JS
 */ 

/* 免费开户的表单验证 */
 $(function(){
	$(".registerform").Validform({
		usePlugin:{
			passwordstrength:{
				minLen:6,//设置密码长度最小值，默认为0;
				maxLen:18//设置密码长度最大值，默认为30;
			}
		},
		tiptype:function(msg,o,cssctl){
			//msg：提示信息;
			//o:{obj:*,type:*,curform:*}, obj指向的是当前验证的表单元素（或表单对象），type指示提示的状态，值为1、2、3、4， 1：正在检测/提交数据，2：通过验证，3：验证失败，4：提示ignore状态, curform为当前form对象;
			//cssctl:内置的提示信息样式控制函数，该函数需传入两个参数：显示提示信息的对象 和 当前提示的状态（既形参o中的type）;
			if(!o.obj.is("form")){//验证表单元素时o.obj为该表单元素，全部验证通过提交表单时o.obj为该表单对象;
				var objtip=o.obj.siblings(".Validform_checktip");
				cssctl(objtip,o.type);
				objtip.text(msg);
			}
		},

		beforeSubmit:function(curform){
			curform.find("input:submit").attr("disabled",true);
			return true;
		},
		datatype:{//传入自定义datatype类型【方式二】;
			"need1":function(gets,obj,curform,regxp){
				var need=1,
					numselected=curform.find("input[name='"+obj.attr("name")+"']:checked").length;
				return  numselected >= need ? true : "没有同意xxx";
			},
			"tel":function(gets,obj,curform,regxp){
				reg = /^0{0,1}(13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9]|19[0-9])[0-9]{8}$/;
				return reg.test(obj.val());
			},
			"name":function(gets,obj,curform,regxp){
				if(obj.val().length>20){
					return false;
				}else{
				reg=/^[\u4e00-\u9fa5]+[.．·]{0,1}[\u4e00-\u9fa5]+$/; 
				return reg.test(obj.val());}
			},
			"yhm":function(gets,obj,curform,regxp){
				var atleast=6,
					atmax=18;
				var getAnsiLength = function(b,ansi) {
					//该方法由网友 雨中的双子座 提供;
					if (!(typeof b == 'string') || !ansi) {
						return b.length;
					}
					var a=b.match(/[^\x00-\x80]/g);
					return b.length+(a?a.length:0);
				};
				var reg = /^[a-zA-Z][a-zA-Z0-9_]*$/;
				var len=getAnsiLength(gets,true);
				if(len<atleast){
					return "用户名不能少于"+atleast+"个字符";
				}else if(len>atmax){
					return "用户名不能超过"+atmax+"个字符";
				}else{
					return reg.test(obj.val());
				}
				return true;
			},
			 "isNull":function(gets,obj,curform,regxp){
				return true;
		   	},
			"bank":function(gets,obj,curform,regxp){
				var reg = /^[0-9]{16,19}$/;
				var a = obj.val().replace(/[ ]/g,""); 
				return reg.test(a);
				},
			"code":function(gets,obj,curform,regxp){
				var reg = /^[0-9]{4}$/;
				return reg.test(obj.val());
			},
			"picCode":function(gets,obj,curform,regxp){
				var reg = /^[a-zA-Z1-9]{4,4}$/;
				return reg.test(obj.val());
			},
			
			"*6-16":function(gets,obj,curform,regxp){
				var atleast=6,
					atmax=16;
				var getAnsiLength = function(b,ansi) {
					//该方法由网友 雨中的双子座 提供;
					if (!(typeof b == 'string') || !ansi) {
						return b.length;
					}
					var a=b.match(/[^\x00-\x80]/g);
					return b.length+(a?a.length:0);
				};
				
 				var len=getAnsiLength(gets,true);
				if(len<atleast){
					return "密码不能少于"+atleast+"位";
				}else if(len>atmax){
					return "密码不能超过"+atmax+"位";
				}
				return true;
			},
			"nn":function(gets,obj,curform,regxp){
				var reg =  /^\s*[\u4e00-\u9fa5]{2,15}\s*$/;  
				
				return reg.test(obj.val());
			},
			"email":function(gets,obj,curform,regxp){
			   reg=/^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
			   
				   return reg.test(obj.val());
		   }, 
			"idcard":function(gets,obj,curform,datatype){
				var Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 ];// 加权因子;
				var ValideCode = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ];// 身份证验证位值，10代表X;
			
				if (gets.length == 18){   
					var a_idCard = gets.split("");// 得到身份证数组   
					if (isValidityBrithBy18IdCard(gets)&&isTrueValidateCodeBy18IdCard(a_idCard)) {   
						return true;   
					}   
					return false;
				}
				return false;
				
				function isTrueValidateCodeBy18IdCard(a_idCard) {   
					var sum = 0; // 声明加权求和变量   
					if (a_idCard[17] == 'X') {   
						a_idCard[17] = 10;// 将最后位为x的验证码替换为10方便后续操作   
					}   
					for ( var i = 0; i < 17; i++) {   
						sum += Wi[i] * a_idCard[i];// 加权求和   
					}   
					valCodePosition = sum % 11;// 得到验证码所位置   
					if (a_idCard[17] == ValideCode[valCodePosition]) {   
						return true;   
					}
					return false;   
				}
				
				function isValidityBrithBy18IdCard(idCard18){   
					var year = idCard18.substring(6,10);   
					var month = idCard18.substring(10,12);   
					var day = idCard18.substring(12,14);   
					var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
					// 这里用getFullYear()获取年份，避免千年虫问题   
					if(temp_date.getFullYear()!=parseFloat(year) || temp_date.getMonth()!=parseFloat(month)-1 || temp_date.getDate()!=parseFloat(day)){   
						return false;   
					}
					return true;   
				}
				
				/*function isValidityBrithBy15IdCard(idCard15){   
					var year =  idCard15.substring(6,8);   
					var month = idCard15.substring(8,10);   
					var day = idCard15.substring(10,12);
					var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
					// 对于老身份证中的你年龄则不需考虑千年虫问题而使用getYear()方法   
					if(temp_date.getYear()!=parseFloat(year) || temp_date.getMonth()!=parseFloat(month)-1 || temp_date.getDate()!=parseFloat(day)){   
						return false;   
					}
					return true;
				}*/
			}
		}
	});
 });


$(function(){  
	 
	$('#mobile').bind('input propertychange', function() {  
		var len = $(this).val().length;
		if(len == 11){
			$(".Validform_checktip").removeClass("Validform_wrong");
		}	   
	});  
	  
});

$(function(){

//获取验证码按钮
	var InterValObj; //timer变量，控制时间
	var count = 59; //间隔函数，1秒执行
	var curCount;//当前剩余秒数
	
	$(".yrtip").hide();
	
	
	$(".code").click(function(){
		if($("#mobile").val() == ""){
			$("#mobile").addClass("Validform_error");
			
			$("#mobile").next(".Validform_checktip").addClass("Validform_wrong").text("请输入您的手机号码");
		}
		//以下可自行修改，上面这段if判断，手机号码id是否为空，若为空，点击获取验证码按钮则出现错误提示信息
		
		if($("#mobile").next("div").hasClass("Validform_right")){
			
			//发送短信
			var mobile = $(this).parents("form").find("input[id=mobile]").val(); 
			var customerName = $(this).parents("form").find("input[id=memberName]").val(); 
			var advInfoId = $(this).parents("form").find("input[name=advInfoId]").val(); 
			var fromPage = $(this).parents("form").find("input[name=fromPage]").val();
			var picCode = $(this).parents("form").find(".picCode").val();
			var _this = $(this);
			$.ajax({
				type: "POST",
				url: ROOT +"/online_getMessageCode.action",
				data: {mobile: mobile,customerName:customerName,fromPage:fromPage,picCode:picCode,advInfoId:advInfoId},
				dataType: "text",
				success: function(data){
	            	if(data!=null){
	            		if(data!=""){
	                		$(".code").parent().prev().find(".Validform_checktip").html(data).addClass("Validform_wrong");
	            		}else{
		            		curCount = count;
							
							_this.val(curCount + "秒后重新验证");
							//$(this).parent().next().find(".Validform_checktip").text("如果收不到短信请拨4006706202");
							_this.parent().find(".Validform_checktip").text("如果收不到短信请拨4006706202");
							_this.siblings(".yrtip").show();
							_this.attr("disabled",true).addClass("code-gray");
							_this.siblings("input").attr("disabled",false).removeClass("code-gray");
									
							InterValObj = window.setInterval(function(){
						    	if (curCount == 0) {                
						        	window.clearInterval(InterValObj);//停止计时器
						            _this.removeAttr("disabled").removeClass("code-gray");//启用按钮
						            _this.val("重新发送验证码");
						        }
						        else {
						            curCount--;
						            _this.val(curCount + "秒后重新验证");
						        }
						    }, 1000); //启动计时器，1秒执行一次
		            	}
	            	}
				}
			});
		}
		
	})
});	
