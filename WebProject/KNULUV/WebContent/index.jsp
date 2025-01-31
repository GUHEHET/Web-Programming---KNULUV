<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="./css/login.css?after">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>

<title>로그인</title>
</head>
<body>
	<jsp:include page="firebase.jsp"></jsp:include>
	<section class="login-block login">

		<div class="container">

			<div class="row">

				<div class="col-md-4 login-sec">
					<h2 class="text-center">KNULUV</h2>

					<form class="login-form">

						<div class="form-group">
							<label for="exampleInputEmail1" class="text-uppercase">e-mail</label>
							<input type="text" class="form-control" id="email" placeholder="">
						</div>

						<div class="form-group">
							<label for="exampleInputPassword1" class="text-uppercase">비밀번호</label>
							<input type="password" class="form-control" id="pwd"
								placeholder="">
						</div>

						<div class="form-check">

							<label class="form-check-label"> <input type="checkbox"
								class="form-check-input"> <small>로그인 정보 저장</small>
							</label>
							<button type="button" class="btn btn-login float-right"
								onclick="login(email.value, pwd.value)">LOGIN</button>

						</div>

					</form>

					<div class="copy-text">
						계정이 없으신가요? <a href="./SignUp.jsp">회원 가입</a>
					</div>
				</div>


				<div class="col-md-8 banner-sec">

					<div id="carouselExampleIndicators" class="carousel slide"
						data-ride="carousel">
						<ol class="carousel-indicators">
							<li data-target="#carouselExampleIndicators" data-slide-to="0"
								class="active"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
						</ol>

						<div class="carousel-inner" role="listbox">

							<div class="carousel-item active">
								<img class="d-block img-fluid"
									src="./img/slide1.png"
									alt="First slide">
								<div class="carousel-caption d-none d-md-block">
									<div class="banner-text">
										<h2>시스템 소개</h2>
										<p>경북대 내 연애를 하고싶지만 기회가 되지 않는 청춘들을 위한 웹 채팅 앱입니다.
											학교 내의 여러 사람을 만나고, 원하는 사람과 대화하세요.
											새로운 사람과의 새로운 만남을 통해 대학 생활의 새로운 활력을 얻어보세요.</p>
									</div>
								</div>
							</div>

							<div class="carousel-item">
								<img class="d-block img-fluid"
									src="./img/slide2.png"
									alt="First slide">
								<div class="carousel-caption d-none d-md-block">
									<div class="banner-text">
										<h2>기능 소개</h2>
										<p>자신의 위치를 표시하고, 교내에 위치한 다른 사람을 확인하세요.
											마음에 드는 사람을 발견하면 '채팅'버튼을 통해 그 사람과 대화할 수 있습니다.</p>
									</div>
								</div>
							</div>

							<div class="carousel-item">
								<img class="d-block img-fluid"
									src="./img/slide3.png"
									alt="First slide">
								<div class="carousel-caption d-none d-md-block">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>