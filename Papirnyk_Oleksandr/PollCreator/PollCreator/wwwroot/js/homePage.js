//document.addEventListener('DOMContentLoaded',
//	() => {

//		renderTopFivePolls(event);

//	});

//function renderTopFivePolls(event) {

//	var xmlHttpRequest = new XMLHttpRequest();
//	xmlHttpRequest.onreadystatechange = function () {
//		if (this.readyState === 4 && this.status === 200) {
//			console.log(xmlHttpRequest.response);
//		}
//	};
//	xmlHttpRequest.open('GET', '/p/renderTopFive', true);
//	xmlHttpRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
//	xmlHttpRequest.send();


//}