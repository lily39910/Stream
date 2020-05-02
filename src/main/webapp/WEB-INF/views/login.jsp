<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
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


<link href="${pageContext.request.contextPath}/resources/css/motiva_sans.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/shared_global.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/store.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/cart.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/browse.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/login2.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/buttons.css" rel="stylesheet" type="text/css">


<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"/>
<!-- 다른 라이브러리와 충돌 방지를 위해 사용 -->
<script type="text/javascript">/* $J =  */jQuery.noConflict();</script>
<script>
	$(document).ready(function(){
		$('button[type=submit]').on('click', function(){
			
			if($('#input_username').val() === '' || $('#input_password').val() === ''){
				if($("#error_display").css("display") == "none"){
					$('#error_display').html('아이디와 비밀번호를 입력해주세요.');
					$("#error_display").show(300);
				}
				else {
					$('#error_display').html('아이디와 비밀번호를 입력해주세요.');
				}
				$('html, body').animate({scrollTop : 0}, 150);
			}
			else {
				$('#login_btn_signin').css('display', 'none');
				$('#login_btn_wait').css('display', 'block');
				setTimeout(function() {
					$.ajax({
						url: '/StreamAjax/loginOk',
						type: 'post',
						dataType: 'text',
						data: $('#login_form').serialize(),
						success: function(data){
							if(data === ''){
								//입력하신 계정 이름이나 비밀번호가 올바르지 않습니다.
								$('#login_btn_signin').css('display', 'block');
								$('#login_btn_wait').css('display', 'none');
								if($("#error_display").css("display") == "none"){
									$('#error_display').html('입력하신 계정 이름이나 비밀번호가 올바르지 않습니다.');
									$("#error_display").show(300);
								}
								else {
									$('#error_display').html('입력하신 계정 이름이나 비밀번호가 올바르지 않습니다.');
								}
								$('html, body').animate({scrollTop : 0}, 150);
								$('#input_password').val('');
								$('#input_password').focus();
							}
							else {
								$(location).attr('href', 'main.do');
							}
						},
						error: function(){
							alert('error');
						}
					});
				}, 1500);
				
			}
		});
	});
</script>
</head>
<html>
<body class="v6 login">
	<!-- header -->
	<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp" />
	<!-- end header -->

	<div class="page_header_ctn search">

		<!-- contentTopMenu -->
		<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/contentTopMenu.jsp" />
		<!-- end contentTopMenu -->

		<div class="page_content">

			<!-- Center Column -->
			<div id="error_display" class="checkout_error" style="display: none; color: rgb(204, 51, 0);"></div>

			<div class="leftcol">
				<div class="checkout_content_box">
					<div class="loginbox">
						<div class="loginbox_left">
							<h2>로그인</h2>
							<p>Stream 계정으로 로그인</p>
							<br>
							<form name="login" method="POST" id="login_form" style="display: none;">
								<div class="login_row">
									<div class="input_title">Stream 계정 이름</div>
									<input class="text_input" type="text" name="id" id="input_username" value="">
								</div>
								<div class="login_row">
									<div class="input_title">비밀번호</div>
									<input class="text_input" type="password" name="pwd" id="input_password" autocomplete="off" />
								</div>
								<%-- 
								<div class="login_row" id="captcha_entry" style="display: none;">
									<div id="captcha_image_row">
										<img style="float: left;" id="captchaImg" src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/default/blank.gif"/>" border="0" width="206" height="40"/>
										<div id="captchaRefresh">
											<span class="linkspan" id="captchaRefreshLink">새로고침</span>
										</div>
										<div style="clear: left;"></div>
									</div>
									<br>
									<div class="input_title">위에 있는 문자들을 입력해주세요.</div>
									<input class="text_input" id="input_captcha" type="text" name="captcha_text">
								</div> 
								--%>
								<div style="display: none;">
									<input type="submit">
								</div>
							</form>

							<noscript>
								<p>이 사이트를 이용하려면 Javascript를 활성화해야 합니다.</p>
							</noscript>
							<script>
								document.getElementById('login_form').style.display = 'block';
							</script>
						</div>
						<div class="loginbox_sep"></div>
						<div class="loginbox_right">
							<h2>만들기</h2>
							<p>새 무료 계정</p>
							<br>
							<p>자유롭게 참가하고 쉽게 이용할 수 있습니다.Stream 계정을 만들어 PC 그리고 Mac 게이머들을 위한
								선두적인 디지털 솔루션인 Stream을 이용해 보세요.</p>
						</div>
						<div style="clear: left;"></div>
						<div class="loginbox_left btn_ctn">
							<div id="login_btn_signin">
								<button type="submit" class="btnv6_blue_hoverfade  btn_medium">
									<span>로그인</span>
								</button>
							</div>
							<div id="login_btn_wait" style="display: none;">
								<img src="<c:url value="${pageContext.request.contextPath}/resources/public/shared/images/login/throbber.gif"/>">
							</div>
						</div>
						<div class="loginbox_right">
							<a href="join.do" class="btnv6_blue_hoverfade btn_medium"> 
								<span>Stream 가입</span>
							</a>
						</div>
						<div style="clear: left;"></div>
					</div>
				</div>
				<br> <a
					href="#" id="link_forgot_password"> 비밀번호를 잊으셨나요? </a>

			</div>
			<!-- End Center Column -->

			
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
					</div>
					<br>
					<a href="about.do">Stream에 대해 자세히 알아보세요.</a>
				</div>
			</div>
			<!-- End Right Column -->

			<div style="clear: both;"></div>

		</div>

	</div>
	<!-- End Main Background -->



	<!-- 필요 없는듯..? -->
	<!-- 
	<div id="loginModals">
		<div class="login_modal loginAuthCodeModal" style="display: none">
			<form data-ajax="false">
				<div class="auth_message_area">
					<div id="auth_icon" class="auth_icon auth_icon_key"></div>
					<div class="auth_messages" id="auth_messages">
						<div class="auth_message" id="auth_message_entercode"
							style="display: none;">
							<div class="auth_modal_h1">안녕하세요!</div>
							<p>새 브라우저 또는 새 컴퓨터에서 Stream에 로그인하려 하시는 것 같군요. 아니면 오랜만에
								접속하셨거나...</p>
						</div>
						<div class="auth_message" id="auth_message_checkspam"
							style="display: none;">
							<div class="auth_modal_h1">스팸함에 있지 않을까요?</div>
							<p>스팸 메일함을 확인해 보셨습니까? 받은 메일함에 Stream 고객지원에서 보낸 메일이 없다면 스팸 메일함을
								확인해 보십시오.</p>
						</div>
						<div class="auth_message" id="auth_message_success"
							style="display: none;">
							<div class="auth_modal_h1">성공!</div>
							<p>이제 이 브라우저 또는 이 컴퓨터에서 귀하의 Stream 계정을 사용할 수 있습니다.</p>
						</div>
						<div class="auth_message" id="auth_message_incorrectcode"
							style="display: none;">
							<div class="auth_modal_h1">오, 이런!</div>
							<p>
								죄송하지만, <br>입력하신 코드가 틀린 것 같네요...
							</p>
						</div>
						<div class="auth_message" id="auth_message_help"
							style="display: none;">
							<div class="auth_modal_h1">도와드릴게요!</div>
							<p>문제를 겪게 해 드려 죄송합니다. Stream 계정에 접속이 불가능하심을 확인하였으며, 도움을 드리려
								노력하고 있습니다.</p>
						</div>
					</div>
				</div>
				<div id="auth_details_messages" class="auth_details_messages">
					<div class="auth_details" id="auth_details_entercode"
						style="display: none;">
						추가적인 보안 절차로서, 귀하의 메일 주소( <span
							id="emailauth_entercode_emaildomain"></span> )로 발송된 코드를 입력해 이
						브라우저로부터의 접근을 허가해 주세요.
					</div>
					<div class="auth_details" id="auth_details_success"
						style="display: none;">공용 컴퓨터라면 브라우저를 종료할 때 Stream에서 꼭 로그아웃
						해주세요.</div>
					<div class="auth_details" id="auth_details_help"
						style="display: none;">Stream 고객지원에 문의하셔서 저희 직원의 도움을 받으십시오.
						귀하의 계정 접근과 관련된 정당한 요청은 저희가 가장 중요하게 다루는 사안입니다.</div>
				</div>
				<div class="authcode_entry_area">
					<div id="authcode_entry">
						<div class="authcode_entry_box">
							<input class="authcode_entry_input authcode_placeholder"
								id="authcode" type="text" value="" placeholder="여기에 코드를 입력해주세요">

						</div>
					</div>
					<div id="authcode_help_supportlink">
						<a
							href="https://support.steampowered.com/kb_article.php?ref=4020-ALZM-5519"
							data-ajax="false" data-externallink="1">계정 로그인 관련 문제에 대해
							Stream 고객지원에 지원 요청하기</a>
					</div>
				</div>
				<div class="modal_buttons" id="auth_buttonsets">
					<div class="auth_buttonset" id="auth_buttonset_entercode"
						style="display: none;">
						<div data-modalstate="submit" class="auth_button leftbtn">
							<div class="auth_button_h3">제출</div>
							<div class="auth_button_h5">승인 코드</div>
						</div>
						<div data-modalstate="checkspam" class="auth_button">
							<div class="auth_button_h3">무슨 메일이요?</div>
							<div class="auth_button_h5">Stream 고객지원에서 아무런 메일도 받지
								못했는데요...</div>
						</div>
						<div style="clear: left;"></div>
					</div>
					<div class="auth_buttonset" id="auth_buttonset_checkspam"
						style="display: none;">
						<div data-modalstate="submit" class="auth_button leftbtn">
							<div class="auth_button_h3">찾았습니다!</div>
							<div class="auth_button_h5">그리고 위에 승인 코드를 입력했습니다</div>
						</div>
						<div data-modalstate="help" class="auth_button">
							<div class="auth_button_h3">여전히 안 보여요...</div>
							<div class="auth_button_h5">Stream 고객지원에서 아무런 메일도 받지
								못했습니다...</div>
						</div>
						<div style="clear: left;"></div>
					</div>
					<div class="auth_buttonset" id="auth_buttonset_success"
						style="display: none;">
						<div class="auth_button auth_button_spacer"></div>
						<a data-modalstate="complete" class="auth_button"
							id="success_continue_btn" href="javascript:void(0);">
							<div class="auth_button_h3">Stream으로!</div>
							<div class="auth_button_h5">
								&nbsp;<br>&nbsp;
							</div>
						</a>
						<div style="clear: left;"></div>
					</div>
					<div class="auth_buttonset" id="auth_buttonset_incorrectcode"
						style="display: none;">
						<div data-modalstate="submit" class="auth_button leftbtn">
							<div class="auth_button_h3">다시 해 볼게요</div>
							<div class="auth_button_h5">그리고 위에 승인 코드를 다시 입력했습니다</div>
						</div>
						<div data-modalstate="help" class="auth_button">
							<div class="auth_button_h3">도와주세요</div>
							<div class="auth_button_h5">Stream 고객지원의 도움이 필요할 것 같습니다...</div>
						</div>
						<div style="clear: left;"></div>
					</div>
					<div class="auth_buttonset" id="auth_buttonset_waiting"
						style="display: none;"></div>
				</div>
				<div style="" id="auth_details_computer_name"
					class="auth_details_messages">
					Stream Guard가 활성화된 기기 목록에서 지금 접속하신 브라우저를 금방 알아볼 수 있도록, 이 브라우저의 이름이나
					애칭을 입력하세요. 최소 6자 이상이어야 합니다.
					<div id="friendly_name_box" class="friendly_name_box">
						<input class="authcode_entry_input authcode_placeholder"
							id="friendlyname" type="text" placeholder="이름이나 애칭을 입력하세요">
					</div>
				</div>
				<div style="display: none;">
					<input type="submit">
				</div>
			</form>
		</div>

		<div class="login_modal loginIPTModal" style="display: none">
			<div class="auth_message_area">
				<div class="auth_icon ipt_icon"></div>
				<div class="auth_messages">
					<div class="auth_message">
						<div class="auth_modal_h1">죄송합니다</div>
						<p>추가적인 인증 없이는 이 컴퓨터에서 계정에 접근할 수 없습니다.</p>
					</div>
				</div>
			</div>
			<div class="auth_details_messages">
				<div class="auth_details">Stream 고객 지원에 문의하시면 저희 직원 중 한 명이 귀하를
					도와드릴 것입니다. 저희는 계정 접속에 대한 정당한 요청을 제일 먼저 처리할 수 있도록 노력하고 있습니다.</div>
			</div>
			<div class="authcode_entry_area"></div>
			<div class="modal_buttons">
				<div class="auth_buttonset">
					<a
						href="https://support.steampowered.com/kb_article.php?ref=9400-IPAX-9398&auth=e39b5c227cffc8ae65414aba013e5fef"
						class="auth_button leftbtn" data-ajax="false"
						data-externallink="1">
						<div class="auth_button_h3">더 알아보기</div>
						<div class="auth_button_h5">Intel&reg; Identity Protection
							Technology에 대해서</div>
					</a> <a href="https://support.steampowered.com" class="auth_button"
						data-ajax="false" data-externallink="1">
						<div class="auth_button_h3">도와주세요</div>
						<div class="auth_button_h5">Stream 고객지원의 도움이 필요한 것 같습니다...</div>
					</a>
					<div style="clear: left;"></div>
				</div>
			</div>
		</div>



		<div class="login_modal loginTwoFactorCodeModal" style="display: none">
			<form>
				<div class="twofactorauth_message_area">
					<div id="login_twofactorauth_icon" class="auth_icon auth_icon_key">
					</div>
					<div class="twofactorauth_messages"
						id="login_twofactorauth_messages">
						<div class="twofactorauth_message"
							id="login_twofactorauth_message_entercode" style="display: none;">
							<div class="auth_modal_h1">
								안녕하세요 <span
									id="login_twofactorauth_message_entercode_accountname"></span>!
							</div>
							<p>이 계정은 현재 Stream Guard 모바일 인증을 사용 중입니다.</p>
						</div>
						<div class="twofactorauth_message"
							id="login_twofactorauth_message_incorrectcode"
							style="display: none;">
							<div class="auth_modal_h1">어이쿠!</div>
							<p>
								죄송합니다만, <br>틀렸습니다...
							</p>
						</div>
						<div class="twofactorauth_message"
							id="login_twofactorauth_message_selfhelp" style="display: none;">
							<div class="auth_modal_h1">도와드리겠습니다!</div>
							<p>불편을 드려 죄송합니다. 귀하에게 Stream 계정이 소중한 것을 알기에, 올바른 사용자만이 접속할 수
								있도록 최선을 다하고 있습니다.</p>
						</div>
						<div class="twofactorauth_message"
							id="login_twofactorauth_message_selfhelp_sms_remove"
							style="display: none;">
							<div class="auth_modal_h1">계정의 진짜 주인인지 확인</div>
							<p>
								<span id="login_twofactorauth_selfhelp_sms_remove_last_digits"></span>로
								끝나는 전화 번호로 계정 복구 코드가 전송될 것입니다. 알맞은 코드를 입력하셨다면 계정에 등록된 모바일 인증기가
								제거되며 Stream Guard 코드를 등록된 이메일 주소로 받게 됩니다.
							</p>
						</div>
						<div class="twofactorauth_message"
							id="login_twofactorauth_message_selfhelp_sms_remove_entercode"
							style="display: none;">
							<div class="auth_modal_h1">계정의 진짜 주인인지 확인</div>
							<p>
								<span
									id="login_twofactorauth_selfhelp_sms_remove_entercode_last_digits"></span>로
								끝나는 휴대 전화 번호로 확인 코드가 담긴 문자 메시지를 전송했습니다. 아래에 받으신 코드를 입력해 계정에 등록된
								모바일 인증기를 제거하실 수 있습니다.
							</p>
						</div>
						<div class="twofactorauth_message"
							id="login_twofactorauth_message_selfhelp_sms_remove_incorrectcode"
							style="display: none;">
							<div class="auth_modal_h1">어이쿠!</div>
							<p>
								죄송합니다만, <br>틀렸습니다...
							</p>
						</div>
						<div class="twofactorauth_message"
							id="login_twofactorauth_message_selfhelp_twofactor_removed"
							style="display: none;">
							<div class="auth_modal_h1">성공!</div>
							<p>계정에 등록된 모바일 인증기가 제거되었습니다. 다음에 로그인을 할 때에는 등록된 이메일로 저회가 보낸
								Stream Guard 코드를 입력하셔야 합니다.</p>
						</div>
						<div class="twofactorauth_message"
							id="login_twofactorauth_message_selfhelp_twofactor_replaced"
							style="display: none;">
							<div class="auth_modal_h1">성공!</div>
							<p>이제부터 이 장치에서 모바일 인증기 코드를 받을 수 있습니다. 이전에 등록했던 인증기나 장치로는 더 이상
								인증기 코드를 받을 수 없습니다.</p>
						</div>
						<div class="twofactorauth_message"
							id="login_twofactorauth_message_selfhelp_nosms"
							style="display: none;">
							<div class="auth_modal_h1">복구 코드가 기억나시나요?</div>
							<p>Stream 계정에 등록된 전화 번호가 없기 때문에 문자 메시지로 귀하가 계정의 주인임을 증명할 수
								없습니다. 인증기를 설정할 때 받으신 복구 코드가 기억나시나요? 복구 코드는 R로 시작합니다.</p>
						</div>
						<div class="twofactorauth_message"
							id="login_twofactorauth_message_selfhelp_rcode"
							style="display: none;">
							<div class="auth_modal_h1">복구 코드를 입력하세요</div>
							<p>아래 상자에 복구 코드를 입력해주세요. 복구 코드는 R로 시작합니다.</p>
						</div>
						<div class="twofactorauth_message"
							id="login_twofactorauth_message_selfhelp_rcode_incorrectcode"
							style="display: none;">
							<div class="auth_modal_h1">어이쿠!</div>
							<p>
								죄송합니다만, <br>틀렸습니다...
							</p>
						</div>
						<div class="twofactorauth_message"
							id="login_twofactorauth_message_selfhelp_rcode_incorrectcode_exhausted"
							style="display: none;">
							<div class="auth_modal_h1">어이쿠!</div>
							<p>
								죄송합니다만, <br>틀렸습니다...
							</p>
						</div>
						<div class="twofactorauth_message"
							id="login_twofactorauth_message_selfhelp_rcode_message"
							style="display: none;">
							<div class="auth_modal_h1">어이쿠!</div>
							<p>
								죄송합니다만, <br>틀렸습니다...
							</p>
						</div>
						<div class="twofactorauth_message"
							id="login_twofactorauth_message_selfhelp_couldnthelp"
							style="display: none;">
							<div class="auth_modal_h1">도와드리겠습니다!</div>
							<p>사용하던 모바일 기기, 계정에 등록된 휴대전화 번호, Stream 인증기를 추가했을 때 받은 복구 코드를
								모두 잃어버렸을 경우에는 Stream 지원에 도움을 요청하세요.</p>
						</div>
						<div class="twofactorauth_message"
							id="login_twofactorauth_message_help" style="display: none;">
							<div class="auth_modal_h1">도와드리겠습니다!</div>
							<p>불편을 드려 죄송합니다. 귀하에게 Stream 계정이 소중한 것을 알기에, 올바른 사용자만이 접속할 수
								있도록 최선을 다하고 있습니다.</p>
						</div>
						<div class="twofactorauth_message"
							id="login_twofactorauth_message_selfhelp_failure"
							style="display: none;">
							<div class="auth_modal_h1">죄송합니다!</div>
							<p>귀하의 요청을 처리하는 중 오류가 발생했습니다.</p>
						</div>
					</div>
				</div>
				<div id="login_twofactorauth_details_messages"
					class="twofactorauth_details_messages">
					<div class="twofactorauth_details"
						id="login_twofactorauth_details_entercode" style="display: none;">
						Stream 모바일 앱에 현재 표시되어 있는 코드를 입력하시기 바랍니다.</div>
					<div class="twofactorauth_details"
						id="login_twofactorauth_details_selfhelp" style="display: none;">
						휴대 전화를 잃어버렸거나 Stream 앱을 삭제해 코드를 더 이상 받을 수 없는 경우에는 계정에 등록된 인증기를
						제거하셔도 좋습니다. 하지만 이는 계정의 보안을 약하게 만들기 때문에 곧바로 새로운 인증기를 등록해 주시는 것이
						좋습니다.</div>
					<div class="twofactorauth_details"
						id="login_twofactorauth_details_help" style="display: none;">
						Stream 고객지원에 문의해 저희 직원의 도움을 받으시기 바랍니다.</div>
					<div class="twofactorauth_details"
						id="login_twofactorauth_details_selfhelp_failure"
						style="display: none;"></div>
					<div class="twofactorauth_details"
						id="login_twofactorauth_details_selfhelp_rcode_incorrectcode"
						style="display: none;"></div>
					<div class="twofactorauth_details"
						id="login_twofactorauth_details_selfhelp_rcode_incorrectcode_exhausted"
						style="display: none;"></div>
				</div>
				<div class="twofactorauthcode_entry_area">
					<div id="login_twofactor_authcode_entry">
						<div class="twofactorauthcode_entry_box">
							<input class="twofactorauthcode_entry_input authcode_placeholder"
								id="twofactorcode_entry" type="text" placeholder="여기에 코드를 입력하세요"
								autocomplete="off">
						</div>
					</div>
					<div id="login_twofactor_authcode_help_supportlink">
						<a
							href="https://support.steampowered.com/kb_article.php?ref=4020-ALZM-5519">
							Stream 고객지원에 연락하여 계정 접속에 대한 지원 요청 </a>
					</div>
				</div>
				<div class="modal_buttons" id="login_twofactorauth_buttonsets">
					<div class="auth_buttonset"
						id="login_twofactorauth_buttonset_entercode"
						style="display: none;">
						<div type="submit" class="auth_button leftbtn"
							data-modalstate="submit">
							<div class="auth_button_h3">제출</div>
							<div class="auth_button_h5">나의 인증 코드</div>
						</div>
						<div class="auth_button" data-modalstate="selfhelp">
							<div class="auth_button_h3">도와주세요</div>
							<div class="auth_button_h5">내 모바일 인증기 코드를 더 이상 확인할 수 없습니다.</div>
						</div>
						<div style="clear: left;"></div>
					</div>
					<div class="auth_buttonset"
						id="login_twofactorauth_buttonset_incorrectcode"
						style="display: none;">
						<div class="auth_button leftbtn" data-modalstate="submit">
							<div class="auth_button_h3">다시 시도하고 싶습니다</div>
							<div class="auth_button_h5">그리고 위에 내 인증 코드를 다시 입력했습니다</div>
						</div>
						<div class="auth_button" data-modalstate="selfhelp">
							<div class="auth_button_h3">도와주세요</div>
							<div class="auth_button_h5">Stream 고객지원의 도움을 받아야겠어요...</div>
						</div>
						<div style="clear: left;"></div>
					</div>
					<div class="auth_buttonset"
						id="login_twofactorauth_buttonset_selfhelp" style="display: none;">
						<div class="auth_button leftbtn"
							data-modalstate="selfhelp_sms_remove_start">
							<div class="auth_button_h3" style="font-size: 16px;">인증기 제거</div>
							<div class="auth_button_h5">그리고 이메일로 코드 받기</div>
						</div>
						<div class="auth_button"
							data-modalstate="selfhelp_sms_reset_start">
							<div class="auth_button_h3">이 장치 사용</div>
							<div class="auth_button_h5">그리고 이 앱에서 인증기 코드 받기</div>
						</div>
					</div>
					<div class="auth_buttonset"
						id="login_twofactorauth_buttonset_selfhelp_sms_remove"
						style="display: none;">
						<div class="auth_button leftbtn"
							data-modalstate="selfhelp_sms_remove_sendcode">
							<div class="auth_button_h3">예!</div>
							<div class="auth_button_h5">문자를 보내주세요</div>
						</div>
						<div class="auth_button" data-modalstate="selfhelp_nosms">
							<div class="auth_button_h3">안됩니다.</div>
							<div class="auth_button_h5">그 전화번호를 더 이상 쓰지 않기 때문입니다.</div>
						</div>
					</div>
					<div class="auth_buttonset"
						id="login_twofactorauth_buttonset_selfhelp_sms_remove_entercode"
						style="display: none;">
						<div class="auth_button leftbtn"
							data-modalstate="selfhelp_sms_remove_checkcode">
							<div class="auth_button_h3">제출</div>
							<div class="auth_button_h5">위에 코드를 입력했습니다</div>
						</div>
						<div class="auth_button" data-modalstate="selfhelp_nosms">
							<div class="auth_button_h3">도움이 필요합니다</div>
							<div class="auth_button_h5">문자 메시지를 받지 못했습니다.</div>
						</div>
					</div>
					<div class="auth_buttonset"
						id="login_twofactorauth_buttonset_selfhelp_sms_remove_incorrectcode"
						style="display: none;">
						<div class="auth_button leftbtn"
							data-modalstate="selfhelp_sms_remove_checkcode">
							<div class="auth_button_h3">제출</div>
							<div class="auth_button_h5">코드를 재입력했습니다. 다시 시도해주세요.</div>
						</div>
						<div class="auth_button" data-modalstate="selfhelp_nosms">
							<div class="auth_button_h3">도움이 필요합니다</div>
							<div class="auth_button_h5">문자 메시지를 받지 못했습니다.</div>
						</div>
					</div>
					<div class="auth_buttonset"
						id="login_twofactorauth_buttonset_selfhelp_twofactor_removed"
						style="display: none;">
						<div class="auth_button leftbtn"
							data-modalstate="selfhelp_sms_remove_complete">
							<div class="auth_button_h3">로그인</div>
							<div class="auth_button_h5">모바일 인증기가 제거된 채로</div>
						</div>
					</div>
					<div class="auth_buttonset"
						id="login_twofactorauth_buttonset_selfhelp_twofactor_replaced"
						style="display: none;">
						<div class="auth_button leftbtn"
							data-modalstate="selfhelp_sms_remove_complete">
							<div class="auth_button_h3">로그인</div>
							<div class="auth_button_h5">Stream 모바일 앱으로 가기</div>
						</div>
					</div>
					<div class="auth_buttonset"
						id="login_twofactorauth_buttonset_selfhelp_nosms"
						style="display: none;">
						<div class="auth_button leftbtn" data-modalstate="selfhelp_rcode">
							<div class="auth_button_h3">예</div>
							<div class="auth_button_h5">R로 시작하는 복구 코드를 가지고 있습니다</div>
						</div>
						<div class="auth_button" data-modalstate="selfhelp_couldnthelp">
							<div class="auth_button_h3">아니요</div>
							<div class="auth_button_h5">그런 코드를 가지고 있지 않습니다</div>
						</div>
					</div>
					<div class="auth_buttonset"
						id="login_twofactorauth_buttonset_selfhelp_rcode"
						style="display: none;">
						<div class="auth_button leftbtn"
							data-modalstate="selfhelp_rcode_checkcode">
							<div class="auth_button_h3">제출</div>
							<div class="auth_button_h5">내 복구 코드</div>
						</div>
						<div class="auth_button" data-modalstate="selfhelp_couldnthelp">
							<div class="auth_button_h3">도움이 필요합니다</div>
							<div class="auth_button_h5">Stream 지원의 도움이 필요한 것 같습니다...</div>
						</div>
					</div>
					<div class="auth_buttonset"
						id="login_twofactorauth_buttonset_selfhelp_rcode_incorrectcode"
						style="display: none;">
						<div class="auth_button leftbtn"
							data-modalstate="selfhelp_rcode_checkcode">
							<div class="auth_button_h3">제출</div>
							<div class="auth_button_h5">코드를 재입력했습니다. 다시 시도해주세요.</div>
						</div>
						<div class="auth_button" data-modalstate="selfhelp_couldnthelp">
							<div class="auth_button_h3">도움이 필요합니다</div>
							<div class="auth_button_h5">Stream 지원의 도움이 필요한 것 같습니다...</div>
						</div>
					</div>
					<div class="auth_buttonset"
						id="login_twofactorauth_buttonset_selfhelp_rcode_incorrectcode_exhausted"
						style="display: none;">
						<div class="auth_button" data-modalstate="selfhelp_couldnthelp">
							<div class="auth_button_h3">도움이 필요합니다</div>
							<div class="auth_button_h5">Stream 지원의 도움이 필요한 것 같습니다...</div>
						</div>
					</div>
					<div class="auth_buttonset"
						id="login_twofactorauth_buttonset_selfhelp_couldnthelp"
						style="display: none;">
						<a class="auth_button leftbtn"
							href="https://help.steampowered.com/">
							<div class="auth_button_h3">Stream 지원에 연락하여</div>
							<div class="auth_button_h5">계정에 로그인하는 데 도움을 받으세요</div>
						</a>
					</div>
					<div class="auth_buttonset"
						id="login_twofactorauth_buttonset_waiting" style="display: none;">
					</div>
				</div>
				<div style="display: none;">
					<input type="submit">
				</div>
			</form>
		</div>
	</div>
	-->

	<!-- Footer -->
	<jsp:include
		page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp" />
	<!-- End Footer -->

</body>
</html>
</html>