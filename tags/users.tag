<users>
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4" id="users">
		<!-- <form action={ uploadFile } enctype="multipart/form-data">
			<input type="text" name="filename"> -->>
			<input type="text" name="usernameSubmit" id="usernameSubmit" placeholder="username"><br />
			<button role="button" type="button" onclick={ submitInfo }>Submit</button><br />
			<!-- <button type="submit">Upload File</button>
		</form> -->
		<div class="row">
			<div class="col-md-12">
				<recipe-full recipe={fullRecipe}></recipe-full>
				<h3>Submitted Recipes</h3>
    			<recipe each={ recipe in submittedRecipes }></recipe>
				<h3>Tried</h3>
    			<recipe each={ recipe in triedRecipes }></recipe>
			</div>
		</div>
	</div>
	<script>
		var dataRef = firebase.database().ref();
		var userDataRef = dataRef.child("userData");
		this.recipes = [];
		var that = this;
		var recipeData;
		var triedData;
		this.submittedRecipes = [];
		this.triedRecipes = [];
		var that = this;
		this.fullRecipe = null;



		this.submitInfo = function(event) {
			var username = document.getElementById("usernameSubmit").value;
			var userDataRecipesRef = dataRef.child("userData/" + username + "/recipes");
			var userDataTriedRef = dataRef.child("userData/" + username + "/tried");
			var recipePromise = userDataRecipesRef.once('value', function(recipesSnap) {
				console.log(recipesSnap.val());
				recipeData = recipesSnap.val();
				for(recipeKey in recipeData) {
					var recipeRef = userDataRecipesRef.child(recipeKey);
					recipeRef.once('value', function(snap) {
						var recipe = snap.val();
						console.log(recipe);
						that.submittedRecipes.push(recipe);
					});
				}
			});
			var triedPromise = userDataTriedRef.once('value', function(triedSnap) {
				console.log(triedSnap.val());
				triedData = triedSnap.val();
				for(recipeKey in triedData) {
					var recipeRef = userDataTriedRef.child(recipeKey);
					recipeRef.once('value', function(snap) {
						var recipe = snap.val();
						console.log(recipe);
						that.triedRecipes.push(recipe);
					});
				}
			});
			var promises = [recipePromise, triedPromise];



			Promise.all(promises).then(function(results) {
				console.log("promises done, results =");
				console.log(results);
				console.log(that.submittedRecipes);
				console.log(that.triedRecipes);
				that.update();

			});



			// console.log(username);
			// categoryDataRef.push({"name":username}, function(err) {
			// 	console.log(err).then(function() {
			//    		console.log("Push succeeded.");
			//   });
			// });
		};

	</script>
</users>