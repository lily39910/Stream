<%@page language="java" contentType="text/html; charset=UTF-8;"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<body>
	<div id="specials_container">
		<h2>Recommended Specials</h2>
		<div class="contenthub_specials_ctn">
			<div class="contenthub_specials_grid">
				<!-- 12번 반복 -->
				<c:forEach begin="0" end="11">
				<div class="contenthub_specials_grid_cell">
					<a class="store_capsule" data-ds-appid="게임 번호" href="#">
						<div class="capsule header">
							<img src="<c:url value="${pageContext.request.contextPath}/resources/public/test/capsule_sm_120.jpg"/>">
						</div>
						<div>
							<!-- 할인 할 경우 -->
							<div class="discount_block discount_block_inline">
								<div class="discount_pct">-15%</div><div class="discount_prices">
									<div class="discount_original_price">₩ 10,500</div><div class="discount_final_price">₩ 8,920</div>
								</div>
							</div>
							<!-- end 할인 할 경우 -->
						</div>
					</a>
				</div>
				</c:forEach>

				<div style="clear: both"></div>
			</div>

			<div class="contenthub_specials_see_more">
				<a class="btnv6_white_transparent btn_small_tall"
					href="#gameSearch1 페이지로 이동">
					<span>모든 특별 할인 보기</span>
				</a>
			</div>
			<div style="clear: both"></div>

		</div>
	</div>
</body>
</html>