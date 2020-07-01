<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<script src="https://www.gstatic.com/firebasejs/7.15.5/firebase-app.js"></script>
<script
	src="https://www.gstatic.com/firebasejs/7.15.5/firebase-analytics.js"></script>
<script src="https://www.gstatic.com/firebasejs/7.15.5/firebase-auth.js"></script>
<script
	src="https://www.gstatic.com/firebasejs/7.15.5/firebase-firestore.js"></script>
	<script
	src="https://www.gstatic.com/firebasejs/7.15.5/firebase-database.js"></script>
	<script
	src="https://www.gstatic.com/firebasejs/7.15.5/firebase-storage.js"></script>
<script>
	//Your web app's Firebase configuration
	var firebaseConfig = {
		apiKey : "AIzaSyBaW4hPPV0Pdz6QoXxX1USFIijUgJhqQUg",
		authDomain : "webprogramming-df368.firebaseapp.com",
		databaseURL : "https://webprogramming-df368.firebaseio.com",
		projectId : "webprogramming-df368",
		storageBucket : "webprogramming-df368.appspot.com",
		messagingSenderId : "359102557982",
		appId : "1:359102557982:web:07aca8db80567b3d06e30f",
		measurementId : "G-4198BS2X0J"
	};
	// Initialize Firebase
	firebase.initializeApp(firebaseConfig);
	firebase.analytics();
	var database = firebase.database();
	var storageRef = firebase.storage().ref();
	function login(email, pwd) {
		firebase.auth().signInWithEmailAndPassword(email, pwd).then(
				function(user) {
					location.href = "./regLoc.jsp?Name="+email.split("@")[0];
				}, function(error) {
					// Handle Errors here.
					var errorCode = error.code;
					var errorMessage = error.message;
					// [START_EXCLUDE]
					if (errorCode == 'auth/weak-password') {
						alert('The password is too weak.');
					} else {
						alert(errorMessage);
					}
					console.log(error);
					// [END_EXCLUDE]
				});
	}
	function signup(email, pwd, pwd_check, name, age, sex, department, text){
		if(pwd == pwd_check){
			firebase.auth().createUserWithEmailAndPassword(email, pwd).then(
					function(user) {
						email = email.split("@");
						database.ref('people/' + email[0]).set({
							user_name : name,
							user_age : age,
							user_sex : sex,
							user_department : department,
							user_text : text
						});
						location.href = "./index.jsp";
					}, function(error) {
						// Handle Errors here.
						var errorCode = error.code;
						var errorMessage = error.message;
						// [START_EXCLUDE]
						if (errorCode == 'auth/weak-password') {
							alert('The password is too weak.');
						} else {
							alert(errorMessage);
						}
						console.log(error);
						// [END_EXCLUDE]
					});
		}
		else{
			alert("비밀번호를 확인하세요.");
		}
	}
	function xy_setting(x, y, name){
		database.ref('xy/' + name).set({
			x:x,
			y:y
		});
		location.href = "./map.jsp?Name="+name;
	}
</script>
