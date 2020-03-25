import * as chartJs from "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.js";

document.addEventListener('DOMContentLoaded',
	() => {

		var voteForm = document.getElementById("voteForm");
		var submitVoteBtn = document.getElementById("submitVote");
		var formDisable = document.getElementById("HasVoted").value;
		var voteSpan = document.getElementById("votesOnRender");

		if (formDisable === "True") {
			disableForm();
		}
		getChartData();

		submitVoteBtn.addEventListener("click", handleSubmit);
	
		function getFormData() {
			var formData = new FormData(voteForm);
			var formDataContainer = {
				SelectedVotes : []
			};

			for (const [key, value] of formData.entries()) {

				if (key.startsWith("__RequestVerificationToken") || key.startsWith("HasVoted")) {
					continue;
				} else if (key.startsWith("PollId")) {
					formDataContainer[key] = value;
				} else {
					formDataContainer["SelectedVotes"].push({ Value: value });
				}
			}

			return formDataContainer;
		}

		function disableForm() {
			for (var i = 0; i < voteForm.length; i++) {
				voteForm[i].disabled = true;
			}
		}

		function validateFormChecked() {

			var formFields = voteForm.getElementsByTagName("input");
			for (var i = 0; i < formFields.length; i++) {
				if (formFields[i].checked === true) {
					return true;
				}
			}
			return false;

		}


		function handleSubmit(event) {

			var isFormSubmittedCorrectly = validateFormChecked();
			var formDataJson = getFormData();
			var formDataToSend = JSON.stringify(formDataJson);
			var xmlHttpRequest = new XMLHttpRequest();
			xmlHttpRequest.onreadystatechange = function () {
				if (this.readyState === 4 && this.status === 200) {
					getChartData();
				}
				else if (this.status === 500) {
					voteSpan.innerText = "Something bad happened on our server! Try again later";
				}
				else if (this.status === 400) {
					voteSpan.innerText = "We couldn't recognize your request.";
				}
			};
			if (isFormSubmittedCorrectly) {
				voteSpan.innerText = "";
				xmlHttpRequest.open('POST', '/p/submit', true);
				xmlHttpRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
				xmlHttpRequest.send(formDataToSend);
				disableForm();
				document.getElementById("submitVote").remove();


			} else {
				voteSpan.innerText = "Select at least one option!";
			}
		}

		function renderChart(chartData) {
			var ctx = document.getElementById('voteChart');
			var chartLabels = [];
			var chartVotesCount = [];
			for (var i = 0; i < chartData.votes.length; i++) {
				chartLabels.push(chartData.votes[i].value);
			}
			for (var i = 0; i < chartData.votes.length; i++) {
				chartVotesCount.push(chartData.votes[i].count);
			}

		var myChart = new Chart(ctx, {
				type: 'pie',
				data: {
					labels: chartLabels,
					datasets: [{
						label: '# of Votes',
						data: chartVotesCount,
						backgroundColor: [
							'rgba(255, 99, 132, 0.2)',
							'rgba(54, 162, 235, 0.2)',
							'rgba(255, 206, 86, 0.2)',
							'rgba(75, 192, 192, 0.2)',
							'rgba(153, 102, 255, 0.2)',
							'rgba(255, 159, 64, 0.2)',
							'rgba(124, 112, 42, 0.2)',
							'rgba(210, 112, 219, 0.2)',
							'rgba(241, 83, 219, 0.2)',
							'rgba(254, 250, 20, 0.2)'
						],
						borderColor: [
							'rgba(255, 99, 132, 1)',
							'rgba(54, 162, 235, 1)',
							'rgba(255, 206, 86, 1)',
							'rgba(75, 192, 192, 1)',
							'rgba(153, 102, 255, 1)',
							'rgba(255, 159, 64, 1)',
							'rgba(124, 112, 42, 1)',
							'rgba(210, 112, 219, 1)',
							'rgba(241, 83, 219, 1)',
							'rgba(254, 250, 20, 1)'

						],
						borderWidth: 1
					}]
				},
				options: {
					title:
					{
						display: true,
						text: "Poll Votes"
					},
					responsive: true,
					maintainAspectRatio: true
				}
			});
		}

		function getChartData() {
			var pollId = document.getElementById("PollId").value;
			var xmlHttpRequest = new XMLHttpRequest();
			xmlHttpRequest.onreadystatechange = function () {
				if (this.readyState === 4 && this.status === 200) {
					voteForm.classList.remove("position__absolute");
					renderChart(this.response);
				}
			};
			xmlHttpRequest.responseType = 'json';
			xmlHttpRequest.open('POST', '/p/renderChart', true);
			xmlHttpRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
			xmlHttpRequest.send(JSON.stringify({ "PollId": pollId }));
		};

	});




