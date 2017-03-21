<categories>
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4" id="categories">
		<!-- <form action={ uploadFile } enctype="multipart/form-data">
			<input type="text" name="filename"> -->>
			<input type="text" name="categorySubmit" id="categorySubmit" placeholder="category"><br />
			<button role="button" type="button" onclick={ submitInfo }>Search category</button><br />
			<!-- <button type="submit">Upload File</button>
		</form> -->
		<div class="row">
			<div class="col-md-12">
				<recipe-full recipe={fullRecipe}></recipe-full>
				<h3>Recipes</h3>
    			<recipe each={ recipe in recipes }></recipe>
			</div>
		</div>
	</div>
	<script>
		var dataRef = firebase.database().ref();
		this.recipes = [];
		var that = this;
		var recipeData;
		this.recipes = [];
		this.fullRecipe = null;

		this.on('update', function() {
			console.log("update and run");
			console.log(this.recipes);
		});



		this.submitInfo = function(event) {
			var category = document.getElementById("categorySubmit").value;
			var recipeListRef = dataRef.child("category/" + category);
			recipeListRef.once('value', function(snap) {
				console.log(snap);
				recipeData = snap.val();
				for(recipeKey in recipeData) {
					that.recipes.push(recipeData[recipeKey]);
				}
			});
			console.log(that.recipes);
			that.update();

			// var userDataRecipesRef = dataRef.child("userData/" + username + "/recipes");
			// var userDataTriedRef = dataRef.child("userData/" + username + "/tried");
			// var recipePromise = userDataRecipesRef.once('value', function(recipesSnap) {
			// 	console.log("recipesSnap: ");
			// 	console.log(recipesSnap);
			// 	console.log(recipesSnap.val());
			// 	recipeData = recipesSnap.val();
			// 	for(recipeKey in recipeData) {
			// 		console.log("item:");
			// 		console.log(recipeData[recipeKey]);
			// 		that.submittedRecipes.push(recipeData[recipeKey]);
			// 		// var recipeRef = userDataRecipesRef.child(recipeKey);
			// 		// recipeRef.once('value', function(snap) {
			// 		// 	console.log("recipe snap: ");
			// 		// 	console.log(snap);
			// 		// 	var recipe = snap.val();
			// 		// 	console.log(recipe);
			// 		// 	that.submittedRecipes.push(recipe);
			// 		// });
			// 	}
			// });
			// var triedPromise = userDataTriedRef.once('value', function(triedSnap) {
			// 	console.log("triedSnap: ");
			// 	console.log(triedSnap);
			// 	console.log(triedSnap.val());
			// 	triedData = triedSnap.val();
			// 	for(recipeKey in triedData) {
			// 		var recipe = triedData[recipeKey];
			// 		console.log("tried recipe:");
			// 		console.log(recipe);
			// 		that.triedRecipes.push(triedData[recipeKey]);
			// 		// var recipeRef = userDataTriedRef.child(recipeKey);
			// 		// recipeRef.once('value', function(snap) {
			// 		// 	var recipe = snap.val();
			// 		// 	console.log(recipe);
			// 		// 	that.triedRecipes.push(recipe);
			// 		// });
			// 	}
			// });
			// var promises = [recipePromise, triedPromise];



			// Promise.all(promises).then(function(results) {
			// 	console.log("promises done, results =");
			// 	console.log(results);
			// 	console.log(that.submittedRecipes);
			// 	console.log(that.triedRecipes);
			// 	that.update();

			// });



			// console.log(username);
			// categoryDataRef.push({"name":username}, function(err) {
			// 	console.log(err).then(function() {
			//    		console.log("Push succeeded.");
			//   });
			// });
		};

	</script>
</categories>