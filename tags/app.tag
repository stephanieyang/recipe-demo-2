<app>
	<div id="app">
		<div show={!loggedIn}>
			Please log in to view content.
		<button id="sign-in" role="button" onclick={ signIn }>Sign-in with Google</button>
		</div>
		<div show={ loggedIn }>

			<div class="container-fluid">
			<div class="row">
				<gallery></gallery>
				<users></users>
				<!-- <users></users> -->
				<submit></submit>
				</div>
			</div>

	</div>
<style scoped>
#app {
	width: 100%;
	height: 100%;
}


</style>
<script>
	var provider = new firebase.auth.GoogleAuthProvider();
	var that = this;

	//this.auth = firebase.auth();
	//this.user = this.auth.currentUser;
	this.user = firebase.auth().currentUser;
	this.loggedIn = (this.user != null);
	this.signIn = function() {
		//console.log("sign in");

		// For some reason, on my computer redirect doesn't work and popup doesn't get recognized.
		// So, fake login it is.


		firebase.auth().signInWithPopup(provider).then(function(result) {
			// This gives you a Google Access Token. You can use it to access the Google API.
			var token = result.credential.accessToken;
			// The signed-in user info.
			var user = result.user;
			that.user = firebase.auth().currentUser;
			// this.loggedIn = true;\
			// ...
			console.log("logged in");
			console.log(this.user);
			that.loggedIn = true;
			that.update();
		}).catch(function(error) {
		  // Handle Errors here.
		  var errorCode = error.code;
		  var errorMessage = error.message;
		  // // The email of the user's account used.
		  // var email = error.email;
		  // // The firebase.auth.AuthCredential type that was used.
		  // var credential = error.credential;
		  // ...

			console.log("login failed");
			console.log(errorCode);
			console.log(errorMessage);
		});
		// this.user = firebase.auth().currentUser;
		// this.loggedIn = true;
		// if(this.loggedIn) {
		// 	console.log("logged in");
		// } else {
		// 	console.log("login failed");
		// }

	}


</script>
</app>