<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=pg43l9dp5c"></script>
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="./css/profile.css">
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
<title>View Other User</title>
</head>
<body>
	<div id="map" style="width: 100%; height: 100vh"></div>
	<script type="text/javascript">
		var Request = function() {
			this.getParameter = function(name) {
				var rtnval = '';
				var nowAddress = unescape(location.href);
				var parameters = (nowAddress.slice(nowAddress.indexOf('?') + 1,
						nowAddress.length)).split('&');
				for (var i = 0; i < parameters.length; i++) {
					var varName = parameters[i].split('=')[0];
					if (varName.toUpperCase() == name.toUpperCase()) {
						rtnval = parameters[i].split('=')[1];
						break;
					}
				}
				return rtnval;
			}
		}
		var request = new Request();
	</script>
	<script>
		// create naver map object
		var map = new naver.maps.Map('map', {
			center : new naver.maps.LatLng(35.889845, 128.6105),
			zoom : 17,
			minZoom : 17
		});
		//다른 사람 좌표 찍기 
		var Name = request.getParameter("Name");
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
		var storage = firebase.storage().ref('img/');
		var people = database.ref('people');
		var temp_x;
		var temp_y;
		var temp_age;
		var temp_department;
		var temp_name;
		var temp_sex;
		var temp_text;
		var img;
		var i=0;
		
		var nameList = [];
		
		people.on('value', function(snapshot) {
			snapshot.forEach(function(childSnapshot) {
				var childKey = childSnapshot.key;
				var childData = childSnapshot.val();
								
				if (childKey != Name){
					//console.log(childKey);
					//find_xy(childKey);
					var people_x = database.ref('xy/' + childKey);
					people_x.once('value', function(snapshot) {
						temp_x = snapshot.val().x;
						temp_y = snapshot.val().y;
						temp_age = childSnapshot.val().user_age;
						temp_department = childSnapshot.val().user_department;
						temp_name = childSnapshot.val().user_name;
						temp_sex = childSnapshot.val().user_sex;
						temp_text = childSnapshot.val().user_text;
						create_symbol(temp_age, temp_department, temp_name, temp_sex, temp_text, temp_x, temp_y, childKey);
						

						nameList.push(childKey);
					});
				}
			});
		});
		//function find_xy(name){
		//	var people_x = database.ref('xy/' + name);
		//	people_x.once('value', function(snapshot) {
		//		temp_x = snapshot.val().x;
		//		temp_y = snapshot.val().y;
		//	});
		//}
		var markerList = [], infoWindowList = [];
		
		function create_symbol(age, department, name, sex, text, x, y, childKey){
			var str;
			if(sex == 1)
				str = '남자';
			else
				str = '여자';
			storage.child(childKey+'.png').getDownloadURL().then(function(url){
				img = url;
			var latLngs = new naver.maps.LatLng(x,y);
			var contentStr = [
				'<div class="container">',
				'<div style="width:400px; height:280px;">', //  class="row"
				'<div >', //class="col-xs-12 col-sm-6 col-md-6"
				'<div >', //class="well well-sm"
				'<div class="row">',
				'<div>', // class="col-sm-6 col-md-4"
				'<img src='+img+' alt="" width="200" align="left" hspace="5" />', //class="img-rounded img-responsive"
				'<h4>'+name+'</h4>',
				'</i></cite></small>',
				'<p>',
				'생년월일: '+age+'</p>',
				'학과: '+department+'</p>',
				'성별: '+str+'</p>',
				'소개: '+text+'</p>',
				'<div class="btn-group">',
				'<button type="button" class="btn btn-primary" onclick=' + "chat(\'" + childKey + "\')" + '>chat</button>',
				'</div>','</div>', '</div>', '</div>', '</div>', '</div>',
				'</div>' ].join('');
			
				marker = new naver.maps.Marker({
					position : latLngs,
					map : map,
				//icon:icon,
				//animation :naver.maps.Animation.BOUNCE,
				});
				
				var infowindow = new naver.maps.InfoWindow({
					content : contentStr
				});
				
				nameList.push(childKey);
				markerList.push(marker);
				infoWindowList.push(infowindow);
				marker = null;
				infowindow = null;
				naver.maps.Event.addListener(markerList[i], 'click', getClickHandler(i));
				i++;
			// add click listener in marker
			});
		}
		
		function getClickHandler(num) {
			return function(e) {
				var marker = markerList[num], infoWindow = infoWindowList[num];
				if (infoWindow.getMap()) {
					infoWindow.close();
				} else {
					infoWindow.open(map, marker);
				}
			}
		}
		
		function chat(other){
			window.open("jstalktheme.html?myName=" + Name + '&other=' + other, "chat", "width=350, height=500, left=100, top=50");
		}
	</script>
	
</body>
</html>