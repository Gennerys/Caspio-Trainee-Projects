import * as chartJs from "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.js";
var optionNumber = 1;

function createInput(e,optionValue) {
	var identifier = optionNumber++;
	var inputField = document.createElement("INPUT");
	inputField.setAttribute("type", "text");
	inputField.setAttribute("id", `Option${identifier}`);
	inputField.setAttribute("name", `Option${identifier}`);
	inputField.setAttribute("placeholder", "Your option goes here");
	inputField.setAttribute("class", "pollOptions");
	if (optionValue !== "" && optionValue!== undefined) {

		inputField.setAttribute("value", optionValue);
	}
	document.getElementById("options").appendChild(inputField);

	if (optionNumber === 11) {
		document.getElementById("addPollOption").disabled = true;
	}

}
function createVotingPageLink(pollId, host) {

	createParagraph("Your poll was published:");
	var votingPageLink = document.createElement('a');
	votingPageLink.setAttribute("href", `/p/${pollId}`);
	votingPageLink.setAttribute("target", "_blank");
	var linkText = document.createTextNode(`localhost:5000/p/${pollId}`);//вычислить путь
	votingPageLink.appendChild(linkText);
	document.getElementById("container").appendChild(votingPageLink);
	createHiddenLinkInput(votingPageLink.href);
}

function createCopyUrlButton() {

	var copyToClipboardBtn = document.createElement("button");
	copyToClipboardBtn.setAttribute("type", "button");
	copyToClipboardBtn.style.margin = "0 0 0 10px";
	var buttonText = document.createTextNode("Copy Link");
	copyToClipboardBtn.appendChild(buttonText);
	document.getElementById("container").appendChild(copyToClipboardBtn);
	copyToClipboardBtn.addEventListener("click", () => {
		var hiddenLink = document.getElementById("hiddenLink");
		hiddenLink.focus();
		hiddenLink.select();
		document.execCommand("copy");
	});
}

function createHiddenLinkInput(url) {

	var inputField = document.createElement("INPUT");
	inputField.setAttribute("id", "hiddenLink");
	inputField.setAttribute("type", "text");
	inputField.style.top = "-9999px";
	inputField.style.position = "absolute";
	inputField.setAttribute("value", `${url}`);
	document.getElementById("container").appendChild(inputField);
}
function createParagraph(text) {
	var paragraph = document.createElement('p');
	paragraph.innerText = text;
	document.getElementById("container").appendChild(paragraph);
}

function deletePublishButtonAndAddOptionButtons() {
	var publishBtn = document.getElementById("publishPoll");
	publishBtn.remove();
	var optionButton = document.getElementById("addPollOption");
	optionButton.remove();
}

function renderOptions(event) {

	var pollModel = JSON.parse(document.getElementById('data').innerHTML);

	if (pollModel.options === null) {
		createInput(event, "");
		createInput(event, "");
	} else {
		for (var i = 0; i < pollModel.options.length; i++) {
			createInput(event, pollModel.options[i].value);
		}
		console.log(pollModel.host);
		createVotingPageLink(pollModel.pollId, pollModel.host);
		createCopyUrlButton();
		document.getElementById("pollBuilderFromFields").disabled = true;
		deletePublishButtonAndAddOptionButtons();
	}
}

document.addEventListener('DOMContentLoaded',
	() => {

		renderOptions(event);

	});

document.addEventListener('DOMContentLoaded', () => {

	var pollForm = document.getElementById("pollBuilderForm");
	var addOptionButton = document.getElementById("addPollOption");
	var publishPollButton = document.getElementById("publishPoll");
	var pollBuilderFormFields = document.getElementById("pollBuilderFromFields");
	var errorMessageHolder = document.getElementById("inputError");
	var votesSpan = document.getElementById("votesOnBuilder");
	if (addOptionButton) {
		addOptionButton.addEventListener("click", createInput);
	}
	if (publishPollButton) {
		publishPollButton.addEventListener("click", handlePublish);
	}
	var myChart;
	window.setInterval(function () {
		if (typeof myChart !== "undefined") {
			myChart.clear();
		}
		getChartData();
	}, 15000);

	getChartData();

	function extractProperId(key) {
		return key.substring(6);
	}

	function getFormData() {
		var formData = new FormData(pollForm);
		var formDataContainer = {
			options: []
		};
		for (const [key, value] of formData.entries()) {
			if (key.startsWith("Option")) {
				formDataContainer["options"].push({ SerialNumber: extractProperId(key), Value: value });
			}
			formDataContainer[key] = value;
		}

		var formattedFormData = jsonObjectFormatter(formDataContainer);

		return formattedFormData;
	}

	function jsonObjectFormatter(jsonObjectToFormat) {

		var formattedFormData = {
			Title: jsonObjectToFormat["title"],
			IsSingleOption: jsonObjectToFormat["pollType"],
			Options: jsonObjectToFormat["options"],
			PollId: jsonObjectToFormat["PollId"],
			EditorToken: jsonObjectToFormat["EditorToken"],
			IsPublished: jsonObjectToFormat["IsPublished"],
			__RequestVerificationToken: jsonObjectToFormat["__RequestVerificationToken"]
		};

		return formattedFormData;
	}

	function renderChart(chartData) {
		//document.getElementById("chart").style.display = "block";
		var ctx = document.getElementById('voteContainer');
		var chartLabels = [];
		var chartVotesCount = [];
		for (var i = 0; i < chartData.votes.length; i++) {
			chartLabels.push(chartData.votes[i].value);
		}
		for (var j = 0; j < chartData.votes.length; j++) {
			chartVotesCount.push(chartData.votes[j].count);
		}

		myChart = new Chart(ctx, {
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
				if (this.response.votes.length === 0) {
					votesSpan.innerText = "No Votes Yet";
				} else {
					votesSpan.innerText = "";
					document.getElementById("pageBuilderFormContainer").classList.remove("position__absolute");
					renderChart(xmlHttpRequest.response);
				}
			}
			else if (this.status === 418) {
				votesSpan.innerHTML = "No votes yet!";
			}
		};
		xmlHttpRequest.responseType = 'json';
		xmlHttpRequest.open('POST', '/p/renderChart', true);
		xmlHttpRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

		xmlHttpRequest.send(JSON.stringify({ "PollId": pollId }));
	};

	function handlePublish(event) {

		var isFormValid = validateForm();
		errorMessageHolder.style.color = "red";

		if (isFormValid) {
			errorMessageHolder.innerHTML = "";
			var formDataJson = getFormData();
			var formDataToSend = JSON.stringify(formDataJson);
			pollBuilderFormFields.disabled = true;
			var xmlHttpRequest = new XMLHttpRequest();
			xmlHttpRequest.onreadystatechange = function() {
				if (this.readyState === 4 && this.status === 200) {
					createVotingPageLink(formDataJson.PollId);
					createCopyUrlButton();
					deletePublishButtonAndAddOptionButtons();
					getChartData();
					votesSpan.innerText = "";
				} else if(this.status === 400) {
					errorMessageHolder.innerHTML = `${status} Bad Request, we can't recognize your request`;
				}
				else if (this.status === 400) {
					errorMessageHolder.innerHTML = "Something bad happened on our server! Try again later";
				}

			};

			xmlHttpRequest.open('POST', '/p/publish', true);
			xmlHttpRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
			xmlHttpRequest.send(formDataToSend);
		}

	}

	function validateForm() {

		var formFields = pollForm.getElementsByTagName("input");
		for (var i = 0; i < formFields.length; i++) {
			if (formFields[i].value === "") {
				errorMessageHolder.innerHTML = `Input error in ${formFields[i].name}`;
				return false;
			}
		}
		return true;

	}

});

	
