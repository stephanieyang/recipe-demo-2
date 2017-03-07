<gallery>
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4" id="gallery">
	{fullRecipe}
		<recipe-full recipe={fullRecipe}></recipe-full>
    	<recipe each={ recipe in recipeList }></recipe>
	</div>
<script>
	var that = this;
	var dataRef = firebase.database().ref();
	this.recipeList = [];
	var recipeListRef = dataRef.child("recipeBasicData");
	var promises = [];
	this.fullRecipe = "sss";

	function viewRecipe(event) {
		console.log(event);
		that.update();
	}

	recipeListRef.once('value', function(snap) {
		var newRecipe;

		console.log(snap);
		console.log(snap.val());

		for(var recipeKey in snap.val()) {
			var recipeRef = recipeListRef.child(recipeKey).orderByChild("name");
			recipeRef.once('value', function(recipeSnap) {
				var recipe = recipeSnap.val();
				console.log(recipe);
				that.recipeList.push(recipe);

			}).then(function(result) {
				console.log("result =");
				console.log(result);
			});
		}

		// for(var catKey in catSnap.val()) {
		// 	var recipeListRef = categoryRef.child(catKey);
		// 	recipeListRef.once('value', function(snap) {
		// 		console.log("category key: " + catKey);
		// 		console.log(catKey + " snap val:");
		// 		console.log(snap.val());
		// 		var recipeList = snap.val();
		// 		for(var recipeKey in recipeList) {
		// 			console.log(recipeKey);
		// 			var recipeRef = recipeListRef.child(recipeKey);
		// 			var currentPromise = recipeRef.once('value', function(recipeSnap) {
		// 				var recipe = recipeSnap.val();
		// 				console.log("recipe = ");
		// 				console.log(recipe);
		// 				if(recipe) {
		// 					console.log("pushing to list");
		// 					that.recipeList.push(recipe);
		// 					console.log(that.recipeList);
		// 				}
		// 			});
		// 			promises.push(currentPromise);
		// 		}
		// 	});
		// }


		// Promise.all(promises).then(function(results) {
		// 	console.log("recipeList =");
		// 	console.log(that.recipeList);
		// 	console.log("that =");
		// 	console.log(that);
		// 	that.update();
		// });
	}, function(err) {
		console.log(err);
	});

</script>
<style scoped>
	#gallery {
		overflow: scroll;
	}
</style>
</gallery>