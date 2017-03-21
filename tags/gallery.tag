<gallery>
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4" id="gallery">
		<recipe-full recipe={fullRecipe}></recipe-full>
    	<recipe each={ recipe in recipeList }></recipe>
	</div>
<script>
	
	var that = this;
	var dataRef = firebase.database().ref();
	this.recipeList = [];
	var recipeListRef = dataRef.child("recipeBasicData").orderByChild("name");
	var promises = [];
	this.fullRecipe = "";
	var init = true;
	// var categoryList = ["Snack","Drink","Meal","Dessert"];
	// this.snackList = [];
	// this.drinkList = [];
	// this.mealList = [];
	// this.dessertList = [];

	// for(category in categoryList) {
	// 	categoryRecipesRef = dataRef.child("category/" + category).limitToLast(3).orderByKey();
	// 	categoryRecipesRef.once('value', function(snap) {

	// 	var recipeList = snap.val();
	// 	});
	// }

	// that.fullRecipe = null;
	// that.update();

	recipeListRef.once('value', function(snap) {
		var newRecipe;

		var recipeList = snap.val();

		for(var recipeKey in snap.val()) {
			that.recipeList.push(recipeList[recipeKey]);
		}

		that.fullRecipe = null;
		that.update();

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

	recipeListRef.on('child_added', function(snap) {
		if(init) return;
		console.log(snap.val());
		// does this work?
		that.recipeList.push(snap.val());
		that.update();
	});

</script>
<style scoped>
	#gallery {
		overflow: scroll;
	}
</style>
</gallery>