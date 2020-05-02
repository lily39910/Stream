<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정 만들기</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta name="viewport" content="width=device-width,initial-scale=1"> -->
<!-- 크롬 툴바 색상 변경(tab 부분 색상 변경) -->
<meta name="theme-color" content="#171a21">
<!-- 홈페이지 탭 부분 로고 -->
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/default/icon.ico" type="image/x-icon">

<!-- 사이트 링크 시 보이는 정보? -->
<!-- <meta property="og:site" content="Stream"> -->

<!-- 대표 url주소를 검색엔진에 알려주는 역할 -->
<!-- <link rel="canonical" href="/main.do"> -->

<link href="${pageContext.request.contextPath}/resources/css/joinstream.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/motiva_sans.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_global.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/buttons.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/store.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/login2.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"/>
<!-- 다른 라이브러리와 충돌 방지를 위해 사용 -->
<script type="text/javascript">/* $J =  */jQuery.noConflict();</script>


<script>
	$(document).ready(function(){
		//아이디 확인
		function idCheck(){
			if($('#accountname').val() == ''){
				$('#accountname_availability').html('아이디를 입력하세요');
				$('#accountname_availability').css('color', 'rgb(255, 123, 0)');
				$('#accountname').css('border-color', 'rgb(255, 153, 0)');
			}
			else {
				$.ajax({
					url: '/StreamAjax/joinIdOverlapCheck',					
					type: 'get',
					dataType: 'text',
					data: 'id_overlap_chk=' + $('#accountname').val(), //서블릿으로 넘어가는 parameter 값
					success: function(data){
						if(data == 0){
							//중복되는 아이디 없음
							$('#accountname_availability').html('사용 가능한 아이디입니다.');
							$('#accountname_availability').css('color', 'rgb(108, 137, 66)');
							$('#accountname').css('border-color', '');
							$('#chk_id').val('possible');
						} else {
							//중복되는 아이디 있음
							$('#accountname_availability').html('사용 중인 아이디입니다.');
							$('#accountname_availability').css('color', 'rgb(255, 123, 0)');
							$('#accountname').css('border-color', 'rgb(255, 153, 0)');
							$('#chk_id').val('impossible');
						}
					},
					error: function(){
						//alert('fail!');
					}
				});
			}
		}
		
		
		/*회원 정보 중복 체크 ajax*/
		$('#accountname').keyup(function(){
			idCheck();
		}); //중복 확인
		
		
		/*비밀번호*/
		$('#password').keyup(function(){
			$('#password_tag').removeClass('error visible');
			$('#password').css('border-color', '');
			
			//3초 뒤 이벤트 발생
			setTimeout(function() {
				if($('#password').val().length < 8){ //글자 수 체크
					$('#password_tag').addClass('error visible');
					$('#password_tag').html('비밀번호는 최소한 8자 이상이어야 합니다.');
					$('#password').css('border-color', 'rgb(255, 153, 0)');
				}
			}, 2000);
		});
		$('#password').keydown(function(){
			$('#password_tag').removeClass('error visible');
			$('#password').css('border-color', '');
		});
		
		/*비밀번호 확인*/
		$('#reenter_password').keyup(function(){
			$('#reenter_tag').removeClass('error visible');
			$('#reenter_password').css('border-color', '');
				//3초 뒤 이벤트 발생
			setTimeout(function() {
				if($('#reenter_password').val() !== $('#password').val()){
					$('#reenter_tag').addClass('error visible');
					$('#reenter_tag').html('비밀번호가 맞지 않습니다.');
					$('#reenter_password').css('border-color', 'rgb(255, 153, 0)');
				}
			}, 2000);
		});
		$('#reenter_password').keydown(function(){
			$('#reenter_tag').removeClass('error visible');
			$('#reenter_password').css('border-color', '');
		});
		
		
		/*이메일 양식 체크*/
		$('#email').keyup(function(){
			$('#email').css('border-color', '');
			
	        setTimeout(function() {
				// 정규식 - 이메일 유효성 검사
		        var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
				
		        // 이메일 유효성 검사
		        if($('#email').val().match(regEmail) != null){
		        	var existEmail = true;
		        }
		        else {
		        	var existEmail = false;		        	
		        }

				if(!existEmail) {
					$('#email').css('border-color', 'rgb(255, 153, 0)');
					$('#email_chk').val('impossible');
				}
				else {
					$('#email_chk').val('possible');
				}
			}, 3000);
		});
		$('#email').keydown(function(){
			$('#email').css('border-color', '');
			$('#email_chk').val('impossible');
		});
		
		
		
		/*이메일 체크*/
		$('#reenter_email').keyup(function(){
			$('#reenter_email').css('border-color', '');
				//3초 뒤 이벤트 발생
			setTimeout(function() {
				if($('#reenter_email').val() !== $('#email').val()){
					$('#reenter_email').css('border-color', 'rgb(255, 153, 0)');
					$('#reenter_email_chk').val('impossible');
				}
				else {
					$('#reenter_email_chk').val('possible');
				}
			}, 2000);
		});
		$('#reenter_email').keydown(function(){
			$('#reenter_email').css('border-color', '');
			$('#reenter_email_chk').val('impossible');
		});
		
		
		
		/*가입버튼*/
		$('#createAccountButton').on('click', function(){
			$('#error_display').css('display','block');
			$('#error_display').html('아래 표시된 오류를 확인하세요.');
			
			if(
				($('#chk_id').val() == 'impossible') || 
				($('#password_tag').hasClass('error visible')) || 
				($('#reenter_tag').hasClass('error visible')) || 
				($('#email_chk').val() == 'impossible') ||
				($('#reenter_email_chk').val() == 'impossible')
			){
				
				var checkContext = 5;
				
				for(checkContext; checkContext >= 0; checkContext --){
					if(checkContext == 5){
						if($('#chk_id').val() == 'impossible'){
							$('#accountname').css('border-color', 'rgb(255, 153, 0)');
						}
					}
					else if(checkContext == 4){
						if($('#password_tag').hasClass('error visible') || $('#password').val() == ''){
							$('#password').css('border-color', 'rgb(255, 153, 0)');
						}
					}
					else if(checkContext == 3){
						if($('#reenter_tag').hasClass('error visible') || $('#reenter_password').val() == ''){
							$('#reenter_password').css('border-color', 'rgb(255, 153, 0)');
						}
					}
					else if(checkContext == 2){
						if($('#email_chk').val() == 'impossible'){
							$('#email').css('border-color', 'rgb(255, 153, 0)');
						}
					}
					else if(checkContext == 1){
						if($('#reenter_email_chk').val() == 'impossible'){
							$('#reenter_email').css('border-color', 'rgb(255, 153, 0)');
						}
					}
					else if(checkContext == 0){
						if($('#i_agree_check').is(":checked") == false){
							/* alert('동의서를 확인 후 체크해주세요.'); */
						}
					}
					$('html, body').animate({scrollTop : 0}, 150);
				}
			}
			else if($('#i_agree_check').is(":checked") == false){
					alert('동의서를 확인 후 체크해주세요.');
			}
			else {
				$('#error_display').css('display','none');
				$('#error_display').html('');
				
				$('#create_account').attr('action', 'join_ok.do').submit();
				alert('회원가입이 완료되었습니다\n로그인 페이지로 이동합니다.');
			}
		});
		
		/*
			$('#폼아이디') 
			.attr('action','주소') 
			.submit();
		*/
		
		/* 
		function createAccount(){
			$("create_account").on("submit", function(event) {
				event.preventDefault();
			});
		} 
		*/
	});
	
</script>

</head>
<html>
<body class="v6 login">
	<script>
		//InitJoinSteamJS("https://store.steampowered.com/"); //이게 뭐임?
	</script>

	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/contentTopMenu.jsp"/>
	
	
	<div class="page_content">

		<div class="page_title_area game_title_area">
			<div class="breadcrumbs">
				<div class="blockbg">
					<a href="main.do">홈</a>
				</div>
				<div style="clear: left;"></div>
			</div>
			<div class="game_name">
				<div class="blockbg">계정 만들기</div>
				<div style="clear: left;"></div>
			</div>
		</div>


		<!-- 회원가입 양식 -->
		<div class="leftcol">
			<div id="error_display" style="background-image: none; background-color: rgba(0, 0, 0, 0.5); display: none;"></div>

			<div class="checkout_content_box" id="cart_area">
				<form id="create_account" name="create_account" method="POST">
					<input type="hidden" name="lt" id="lt" value="0" />
					<div id="account_form_box">
						<div class="join_form">
							<div class="form_row">
								<div class="form_area">
									<label for="accountname">Stream 계정 이름 만들기</label>
									<input type="text" maxlength="64" name="id" id="accountname"/>
								</div>
								<div class="form_notes">
									<br>
									<span class="input_note">
										<a>사용 가능 여부 확인</a>
									</span> &nbsp;&nbsp;
									<span id="accountname_availability" style=""></span>
									<input type="hidden" id="chk_id" value="impossible">
								</div>
								<div style="clear: left;"></div>
							</div>
							
							<!-- 아이디 추천 -->
							<!-- 
							<div id="form_row_choose_suggested_name" class="form_row"
								style="display: none;">
								<div class="form_area">
									<label for="choose_accountname">사용 가능한 계정 이름</label><br>
									<select id="choose_accountname" name="choose_accountname" size="3" onchange="UpdateAccountName( this.value );">
										<option id="suggested_name_1"></option>
										<option id="suggested_name_2"></option>
										<option id="suggested_name_3"></option>
									</select>
								</div>
								<div class="form_notes">
									<br>
									<span class="choose_accountname_description">이중 하나를 선택하거나 다른 이름으로 다시 시도해 보세요.</span>
								</div>
								<div style="clear: left;"></div>
							</div>
							 -->
							
							<div class="rule"></div>
							<div class="form_row">
								<div class="form_area">
									<label for="password">비밀번호 선택</label>
									<input type="password" maxlength="64" name="pwd" id="password" autocomplete="off" />
								</div>
								<div class="form_notes">
									<div id="password_tag" class="password_tag">&nbsp;</div>
								</div>
								<div style="clear: left;"></div>
							</div>
							<div class="form_row">
								<div class="form_area">
									<label class="reenter_row" for="reenter_password">비밀번호 확인</label>
									<input type="password" maxlength="64" name="reenter_password" id="reenter_password" autocomplete="off" />
								</div>
								<div class="form_notes">
									<br>
									<div id="reenter_tag" class="password_tag">&nbsp;</div>
								</div>
								<div style="clear: left;"></div>
							</div>
							<div class="rule"></div>
							<div class="form_row">
								<div class="form_area">
									<label for="email">현재 메일 주소</label>
									<input type="text" maxlength="255" name="email" id="email" /> <br>
									<input type="hidden" id="email_chk" value="impossible">
									<label class="reenter_row" for="reenter_email">메일 주소를 다시 입력하세요.</label> 
									<input type="text" maxlength="255" name="reenter_email" id="reenter_email" />
									<input type="hidden" id="reenter_email_chk" value="impossible">
								</div>
								<div class="form_notes">
									<br>
									<p>메일 주소는 구매 확인과 Stream 계정 관리를 위해 사용될 것입니다.</p>
									<br>
									<p>Stream에서 이 계정으로 확인 메일을 보낼 것입니다. 이메일 상의 링크를 사용해서 Stream 계정을 등록할때 사용했던 메일 주소를 인증해 주세요.</p>
								</div>
								<div style="clear: left;"></div>
							</div>
							<div class="rule"></div>
							
							<!-- 
							<div class="form_row">
								<input type="hidden" id="captchagid" name="captchagid"
									value="1549673013952588202" />
								<div class="form_area">
									<img id="captchaImg"
										src="https://store.steampowered.com/login/rendercaptcha?gid=1549673013952588202"
										border="0" /> <br>
									<br> <label for="captcha_text">위에 있는 문자들을 입력해주세요.</label>

									<input type="text" name="captcha_text" id="captcha_text" />
								</div>
								<div class="form_notes" style="padding-top: 10px;">
									<label for="captcha_text"> <a id="captchaRefreshLink"
										href="javascript:RefreshCaptcha()">새로고침</a> <a
										href="javascript:RefreshCaptcha()"
										style="text-decoration: none;"> <img
											id="captchaRefreshImg"
											src="https://steamstore-a.akamaihd.net/public/shared/images/ico_captcha_refresh.gif"
											border="0" />
									</a>
									</label>
								</div>
								<div style="clear: left;"></div>
							</div>
							<div class="rule"></div>
							-->


							

							<div class="form_row">
								<p id="instructions">아래 동의서를 읽고 페이지 하단에 있는 확인란을 선택하여 이에 동의합니다. 계속하려면 이 동의서의 모든 조항에 동의해야 합니다.</p>
								<br>
								<div class="ssa_box">
									<!-- 동의서 내용 -->
									<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/etc/consent.jsp"/>
								</div>
								<div id="ssa_agree">
									<input type="hidden" name="action" value="submit_agreement">
									<input type="checkbox" name="i_agree_check" id="i_agree_check">
									<label for="i_agree_check" id="label_agree">동의하며 13세 이상임을 확인합니다.</label>
								</div>
								<div id="priv_and_sub">
									<a id="createAccountButton" class="btnv6_blue_hoverfade btn_medium" style="float: right;">
										<!-- <span>계속하기</span> -->
										<span>계정 만들기</span>
									</a>

									<div id="privacy_link">
										<a>개인정보 보호정책</a>
									</div>

									<div style="clear: right;"></div>
								</div>
								<div id="ssa_submit"></div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		<!-- end 회원가입 양식 -->


		<!-- 필요없는 듯.. 이메일 이미 보낸 경우 체크 -->
		<!-- 
		<div id="email_verification_dialog" class="email_verification_container" style="display: none;">

			<div class="email_verification_header_container">
				<div class="email_verification_header">
					Please verify <span class="insert_verification_email"></span>
				</div>
				<div class="email_verification_subheader">Stream에서 보낸 이메일에 있는
					링크를 클릭하여 Stream 계정을 활성화하세요.</div>

				<div class="LoadingWrapper">
					<div class="LoadingThrobber">
						<div class="Bar Bar1"></div>
						<div class="Bar Bar2"></div>
						<div class="Bar Bar3"></div>
					</div>
					<div class="LoadingText">Waiting for email verification...</div>
				</div>

			</div>
			<div class="email_verification_troubleshooting">
				<div>If you haven't gotten our email please try the below
					troubleshooting steps:</div>
				<ul>
					<li>Double check that your email "<span
						class="insert_verification_email"></span>" is accurate and doesn't
						contain any typos.
					</li>
					<li>Please check both your spam and trash folder for an email
						from "streampowered.com". Sometimes emails can be incorrectly
						identified as spam by your email provider.</li>
					<li>Wait a few minutes. Sometimes email servers are slow and
						can take a bit of time to receive an email.</li>
				</ul>
				<div>
					일부 이메일 서비스 제공 업체는 Stream 이메일을 지원하지 않습니다. 저희가 보내드리는 이메일이 계속해서 수신되지
					않는다면, Stream에 다른 이메일 주소를 사용할 것을 권장합니다. 이메일 주소를 변경하려면 <span
						class="email_verification_changeemail" onclick="ChangeEmail();">여기를
						클릭</span>하세요.
				</div>
			</div>
		</div>
		-->
		
		

		<!-- Right Column -->
		<!-- Stream 가입 장점(Right Column) -->
		<div class="rightcol">
			<div class="block">
				<div class="block_content block_content_inner login">
					<h2>Stream 서비스의 장점</h2>
					<ul id="why_list">
						<li>시중에 나온 게임을 구매하고 다운로드할 수 있습니다.</li>
						<li>Stream 커뮤니티에 참여하세요.</li>
						<li>게임 도중 친구와 대화하세요.</li>
						<li>Stream이 지원하는 모든 플랫폼에서 게임을 플레이하세요.</li>
						<li>멀티 플레이어 게임, 토너먼트, 또는 LAN 파티를 예약하세요.</li>
						<li>자동 게임 업데이트 등 다양한 서비스를 받아보세요!</li>
					</ul>
					<br />
					<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/v6/default/why_join_preview.png"/>" width="265" height="176" border="0">
					<br>
					<br>
					<span id="join_sys_req_title">시스템 요구 사항</span>
					<div id="join_sys_req">
						Windows XP, Vista 또는 7<br>512MB RAM<br>1Ghz 이상의 프로세서<br>
						<br>Intel 프로세서가 장착된 Mac, OS X 버전 10.7 (Lion) 또는 그 이상.<br>2버튼
						마우스를 강력히 권장<br>
						<br>1GB 하드 디스크 공간 (권장)<br>인터넷 연결 (광대역 권장)
					</div>
					<br>
					<br>
				</div>
				<br> <a href="about.do">Stream에 대해 자세히 알아보세요.</a>
			</div>
		</div>
		<!-- end Stream 가입 장점(Right Column) -->


		<br clear="all">
	</div>
	<!-- End Main Background -->

	<!-- Footer -->
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp"/>
	<!-- End Footer -->
</body>
</html>
</html>