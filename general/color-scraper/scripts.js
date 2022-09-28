var system = require('system');
var webPage = require('webpage');

var page = webPage.create();
var url = 'https://coolors.co/generate'

page.viewportSize = {
  width: 1280,
  height: 720
};

var requestsArray = [];

page.onResourceRequested = function(requestData, networkRequest) {
  requestsArray.push(requestData.id);
};

page.onResourceReceived = function(response) {
  var index = requestsArray.indexOf(response.id);
  if (index > -1 && response.stage === 'end') {
    requestsArray.splice(index, 1);
  }
};

page.open(url, function(status) {

  var interval = setInterval(function () {

    if (requestsArray.length === 0) {

      clearInterval(interval);
      var content = page.content;
      console.log(content);
      phantom.exit();
    }
  }, 500);
});
