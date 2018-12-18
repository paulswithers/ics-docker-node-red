const axios = require('axios');

module.exports = {
  type: "credentials",
  users: function(username) {
      return new Promise(function(resolve) {
        var user = { username: username, permissions: "*" };
        resolve(user);
      });
  },
  authenticate: function(username,password) {
      return new Promise(function(resolve) {
		var user = null;
		var credentialsBase64 = Buffer.from(username + ":" + password).toString('base64');
        var params = {
            method: "GET",
            url: "http://hermes.intec.co.uk/names.nsf/$icon",
			headers: {'Authorization' : 'Basic ' + credentialsBase64}
        };

		axios.request(params)
          .then(function (response) {
			var data = response.data;
				if (data.includes('DOCTYPE')) {
					console.log('Incorrect username or password');
					resolve(null);
				} else {
					console.log('Authenticated');
					user = { username: username, permissions: "*" };
					resolve(user);
				}
          }).catch(function (error) {
            console.log("Authentication Error");
            console.log(error);
            resolve(null);
          });
      });
  },
  default: function() {
      return new Promise(function(resolve) {
          resolve(null);
      });
  }
}