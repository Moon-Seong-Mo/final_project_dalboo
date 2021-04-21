<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달보드레 | 회원가입</title>
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/base.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/footer.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/common/content.css">
<link rel="stylesheet" type="text/css" href="${ contextPath }/resources/css/member/join.css">
<link rel="shortcut icon" href="${ contextPath }/favicon.ico">
<style>
span.ok {
	color: rgb(41, 128, 185);
}

span.error {
	color:rgb(255, 117, 117);
}
.see {
	margin-left: 50px;
	color: gray;
	cursor: pointer;
}

.noSee {
	width:70%;
	height: 100px;
	overflow: auto;
	display: none;
	border: 1px solid gray;
	border-radius: 5px;
	margin-top: 20px;
	margin-bottom: 20px;
}
.agreeFont{
	font-size:14px;
	color:gray;
}
</style>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/nav.jsp"%>
		<div id="content">
			<div id="join">
				<h1>회원 가입</h1>
				<form action="join.me" method="post" id="joinForm">

					<table>
						<tr>
							<th width="300px;">아 이 디*</th>
							<td width="300px;">
								<input type="text" class="username_input" name="id" id="userId" size="32" maxlength="20" onKeyup="this.value=this.value.replace(/[^a-z0-9]/gi,'');" placeholder="아이디를 입력해주세요" required>
							</td>
							<td>
								<span class="id ok">사용 가능한 아이디 입니다.</span> 
								<span class="id error">이미 사용중인 아이디 입니다.</span> 
								<span class="id check">아이디는 최소한 5자 이상이여야합니다.</span> 
								<input type="hidden" name="idDuplicateCheck" id="idDuplicateCheck" value="0">
							</td>
						</tr>


						<tr>
							<th>비밀번호 *</th>
							<td><input type="password" size="32" maxlength="20" name="pwd" id="pwd" placeholder="비밀번호를 입력해주세요" required></td>
							<td rowspan="2"><label id="pwResult"></label></td>
						</tr>

						<tr>
							<th>비밀번호 재확인*</th>
							<td><input type="password" size="32" maxlength="20" name="pwd2" id="pwd2" placeholder="비밀번호를 한번 더  입력해주세요" required></td>
						</tr>

						<tr>
							<th>닉네임*</th>
							<td><input size="32" maxlength="20" name="nickName" id="nickname" placeholder="닉네임을 입력해주세요" required></td>
						</tr>

						<tr>
							<th>이메일*</th>
							<td><input size="32" name="email" id="email" placeholder="이메일을 입력해주세요" required></td>
						</tr>

						<tr>
							<th>이름</th>
							<td><input size="32" name="name" id="name" placeholder="이름을 입력해주세요" required></td>
						</tr>


						<tr>
							<th>휴대폰 번호</th>
							<td>
			                 	<div>
		                     		<input type="text" maxlength="4" size="5" name="phone1" id="phone1"  onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="010" required >
		                     		-
		                     		<input type="text" maxlength="4" size="5" name="phone2" id="phone2"  onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required>
				                     -
				                    <input type="text" maxlength="4" size="5" name="phone3" id="phone3"  onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" required>
		                  		</div>							
							</td>
						</tr>

					</table>

					<div id="agree">
						<div>
							<input type="checkbox" name="all" id="all">&nbsp;&nbsp;&nbsp;<b>약관 전체 동의</b>
						</div><br>
						<div>
							<input type="checkbox" name="terms" class="chk" id="reqChk">&nbsp;&nbsp;&nbsp;개인정보 수집 동의 <label style="color:rgb(255, 117, 117)">(필수)</label>
							<label class="see" style="margin-left:185px;" id="see1">약관 보기</label>
							<div id="noSee1" class="noSee">
								<span class="agreeFont">
									<font color="rgb(127, 127, 127);">개인정보 수집 동의</font><br>
									달보드레은 「개인정보보호법」 제15조제1항제1호, 제17조제1항제1호, 제23조제1호, 제24조제1항 제1호에 따라
									아래와 같이 개인정보의 수집. 이용에 관하여 귀하의 동의를 얻고자 합니다.<br>
									
									달보드레은 이용자의 사전 동의 없이는 이용자의 개인정보를 함부로 공개하지 않으며, 수집된 정보는 아래와 같이 이용하고 있습니다.
									이용자가 제공한 모든 정보는 아래의 목적에 필요한 용도 이외로는 사용되지 않으며 이용 목적이 변경될 시에는 이를 알리고 동의를 구할 것입니다.
									
									개인정보의 수집 및 이용 동의
									1. 개인정보의 수집 및 이용 목적
									가. 서비스 제공에 관한 업무 이행 - 컨텐츠 제공, 특정 맞춤 서비스 제공(마이페이지, 뉴스레터 등), 기업 애로상담
									나. 회원관리
									- 회원제 서비스 이용 및 제한적 본인 확인제에 따른 본인확인, 개인식별, 가입의사 확인, 가입 및 가입횟수 제한, 추후 법정 대리인 본인확인, 분쟁 조정을 위한 기록보존, 불만처리 등 민원처리, 공지사항 전달
									
									2. 수집하는 개인정보의 항목
									<개인회원 가입>
									필수항목 : 아이디, 비밀번호, 이름, 핸드폰번호, 이메일, 암호화된 이용자 확인값(CI)
									선택항목 : 이메일 수신여부, 문자수신여부, 웹진구독여부
									<기업회원 가입>
									필수항목 : 아이디, 비밀번호, 담당자 이름, 담당자 전화번호, 핸드폰번호, 이메일, (법인기업의 경우 법인등록번호), 기업정보(회사명, 대표자명, 사업자등록번호, 회사전화번호, 주소, 지역, 대표업종), 암호화된 이용자 확인값(CI)
									선택항목 : 팩스번호, 홈페이지주소, 회사이메일주소, 창업일자, 부업종, 매출액, 수출액, 상시근로자 수, 주요생산품명, 이메일 수신여부, 문자수신여부, 이메일 수신여부, 문자수신여부, 웹진구독여부
									<자동수집>
									IP주소, 쿠키, 서비스 이용기록, 방문기록 등
									
									3. 개인정보의 보유 및 이용기간
									달보드레은 원칙적으로 보유기간의 경과, 개인정보의 수집 및 이용목적의 달성 등 그 개인정보가 불필요하게 되었을 때에는 지체 없이 파기합니다. 다만, 다른 법령에 따라 보존하여야 하는 경우에는 그러하지 않을 수 있습니다. 불필요하게 되었을 때에는 지체 없이 해당 개인정보를 파기합니다.
									
									회원정보
									-탈퇴 후 지체없이 파기
									
									4. 동의거부권 및 불이익
									정보주체는 개인정보 수집에 동의를 거부할 권리가 있습니다. 다만, 필수 항목에 대한 동의를 거부할 시 저희가 제공하는 서비스를 이용할 수 없습니다.								
								<br>
								</span>
							</div>
						</div>
						<br>
						<div>
							<input type="checkbox" name="terms" id="select" class="chk">&nbsp;&nbsp;&nbsp;마케팅 활용 및 광고성 정보 수신 동의 (선택) 
							<label class="see" id="see2">약관 보기</label>
							<div id="noSee2" class="noSee">
								<span class="agreeFont">
									<font color="rgb(127, 127, 127);">마케팅/홍보의 수집의 이용 동의</font><br>
									1. 개인정보의 수집 및 이용 목적
									신규 서비스 개발 및 마케팅ㆍ광고에의 활용
									- 신규 서비스 개발, 이벤트 및 광고성 정보 제공 및 참여기회 제공, 접속 빈도 등 회원의 서비스 이용에 대한 통계
									2. 수집하는 개인정보의 항목
									필수항목 : 이름
									선택항목 : 이메일, 연락처(휴대전화번호, 유선전화번호 중 1개 선택)
									3. 개인정보의 보유 및 이용기간
									이용목적의 달성 후 지체없이 파기
									4. 동의거부권 및 불이익
									개인정보의 마케팅/홍보의 수집 및 이용 동의를 거부하시더라도 회원 가입 시 제한은 없습니다. 다만, 마케팅 활용 서비스 안내 및 참여에 제한이 있을 수 있습니다.
								<br>
								</span>
							</div>
						</div>
						<input type="hidden" name="mCheck" id="mCheck" value=""><br><br>
					</div>

					<div>
						<button type="submit" id="cancel" style="background: lightgray">취소</button>
                    	<button type="submit" onclick="return validate();" id="insertmember" >가입 완료</button>
					</div>

				</form>
			</div>
		</div>
	</div>

	<script>
	$(document).ready(function(){
		$("#see1").click(function(){
			$("#noSee1").toggle();
		});
		$("#see2").click(function(){
			$("#noSee2").toggle();
		});
	});
	
	var isPwChecked = false;// pw 유효성 확인을 했는지 확인
	var isPwEquals = false;// pw 유효성 확인을 했는지 확인
	
	//전체 체크
	$("#all").click(function(){
		if($('#all').is(":checked")){
			$(".chk").prop("checked", true);
		} else{
			$(".chk").prop("checked", false);
		}
	});

	$(".chk").click(function(){
		if($(".chk:checked").length == 2){
			$("#all").prop("checked", true);
		} else {
			$('#all').prop("checked", false);
		}
	});	
	
	
	//아이디 중복체크
	$(function(){
		$('#userId').on('keyup', function(){
			var userId = $(this).val().trim();
			
			if(userId.length < 5){
				$('.id.error').hide();
				$('.id.ok').hide();
				$('.id.check').show();
				$('#idDuplicateCheck').val(0); //중복확인이되면 value(1)으로 넘어감
				
				return;
			}
			$.ajax({
				url : 'dupid.me',
				data : {id: userId},
				success:function(data){
					if(data =='true'){
						$('.id.error').hide();
						$('.id.check').hide();
						$('.id.ok').show();
						$('#idDuplicateCheck').val(1);
					} else{
						$('.id.error').show();
						$('.id.ok').hide();
						$('.id.check').hide();
						$('#idDuplicateCheck').val(0);
					}
				}
			});
		});
	});

	
	//비밀번호 유효성검사
	$('#pwd').keyup(function(){
		var pwd = $("#pwd").val();
		var pwd2 = $("#pwd2").val();
			
		var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
		
		if(pwd2.length == 0 || !isPwChecked){
			if(false === reg.test(pwd)) {
				$('#pwResult').text('비밀번호는 8자 이상/대문자/소문자/숫자/특수문자 모두 포함해야 합니다.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			}else if(/(\w)\1\1\1/.test(pwd)){
				$('#pwResult').text('같은 문자를 4번 이상 사용하실 수 없습니다.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			 }else if(pwd.search(/\s/) != -1){
				$('#pwResult').text('비밀번호는 공백 없이 입력해주세요.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			 }else {
				$('#pwResult').text('비밀번호가 동일하지 않습니다.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = true;
			 }
		}else{
			if(false === reg.test(pwd2)) {
				$('#pwResult').text('비밀번호는 8자 이상/대문자/소문자/숫자/특수문자 모두 포함해야 합니다.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			}else if(/(\w)\1\1\1/.test(pwd2)){
				$('#pwResult').text('같은 문자를 4번 이상 사용하실 수 없습니다.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			 }else if(pwd2.search(/\s/) != -1){
				$('#pwResult').text('비밀번호는 공백 없이 입력해주세요.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			 }else if(pwd != pwd2){
				$('#pwResult').text('비밀번호가 동일하지 않습니다.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = true;
				isPwEquals = false;
			}else{
				$('#pwResult').text('비밀번호 사용 가능합니다.');
				$('#pwResult').css({'color':'rgb(41, 128, 185)', 'float':'left', 'display':'inline-block'});
				isPwChecked = true;
				isPwEquals = true;
			}
		}
	});
	$('#pwd2').keyup(function(){
		var pwd = $("#pwd").val();
		var pwd2 = $("#pwd2").val();
			
		var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;
		var hangulcheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		if(pwd.length == 0 || !isPwChecked){
			if(false === reg.test(pwd2)) {
				$('#pwResult').text('비밀번호는 8자 이상/대문자/소문자/숫자/특수문자 모두 포함해야 합니다.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			}else if(/(\w)\1\1\1/.test(pwd2)){
				$('#pwResult').text('같은 문자를 4번 이상 사용하실 수 없습니다.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			 }else if(pwd2.search(/\s/) != -1){
				$('#pwResult').text('비밀번호는 공백 없이 입력해주세요.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			 }else if(hangulcheck.test(pwd2)){
				$('#pwResult').text('비밀번호에 한글을 사용할 수 없습니다.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			 }else {
				$('#pwResult').text('비밀번호가 동일하지 않습니다.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = true;
			 }
		}else{
			if(false === reg.test(pwd)) {
				$('#pwResult').text('비밀번호는 8자 이상/대문자/소문자/숫자/특수문자 모두 포함해야 합니다.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			}else if(/(\w)\1\1\1/.test(pwd)){
				$('#pwResult').text('같은 문자를 4번 이상 사용하실 수 없습니다.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			}else if(pwd.search(/\s/) != -1){
				$('#pwResult').text('비밀번호는 공백 없이 입력해주세요.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			}else if(hangulcheck.test(pwd)){
				$('#pwResult').text('비밀번호에 한글을 사용할 수 없습니다.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = false;
			}else if(pwd != pwd2){
				$('#pwResult').text('비밀번호가 동일하지 않습니다.');
				$('#pwResult').css({'color':'rgb(255, 117, 117)', 'float':'left', 'display':'inline-block'});
				isPwChecked = true;
				isPwEquals = false;
			}else{
				$('#pwResult').text('비밀번호 사용 가능합니다.');
				$('#pwResult').css({'color':'rgb(41, 128, 185)', 'float':'left', 'display':'inline-block'});
				isPwChecked = true;
				isPwEquals = true;
			}
		}
	});	
		
	
	
	function validate(){
		if($('#idDuplicateCheck').val() == 0) {
			alert('사용 가능한 아이디를 입력해주세요.');
			$('#userId').focus();
			return false;
		}else if(isPwChecked == false){
			alert("패스워드가 유효하지 않습니다.");
			return false;
		} else if(isPwEquals == false){
			alert("패스워트가 동일하지 않습니다.");
			return false;			
		}else if($("#reqChk").is(":checked") == false){
			alert("필수항목에 체크를 해주세요");
			return false;
		} else{
			$('#joinForm').submit(); 
		}
	}
	
	</script>


	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>