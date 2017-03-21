<recipe>
	<div class="recipe">
		<h2>{ recipe.name }</h2>
		<img src='{ recipe.imageLink }' alt='image' />
    	<button onclick={ viewRecipe } id={ recipe.key }>View Full Recipe</button>
	</div>
	<script>
	console.log("in recipe.tag, recipe =");
	console.log(this.recipe);
		var that = this;

		var dataRef = firebase.database().ref();
		var categoryDataRef = dataRef.child("categoryData");

		this.viewRecipe = function(event) {
			var recipeKey = event.target.id;
			var recipeDetailRef = dataRef.child("recipeDetailData");

			var chosenRecipeRef = recipeDetailRef.child(event.target.id);
			//var chosenRecipeRef = recipeDetailRef.orderByChild("key").equalTo(event.target.id);
			chosenRecipeRef.once('value', function(snap) {
				var recipe = snap.val();
				recipe.ingredientsList = recipe.ingredients.split(",");
				recipe.key = event.target.id;
				that.parent.fullRecipe = recipe;
				that.parent.update();
			});
		}

		this.submitInfo = function(event) {
			var username = document.getElementById("triedUser").value;
			var userRef = dataRef.child("userData").orderByChild("name").equalTo(username);
			// this only works so long as all recipes by an author have unique names; adding recipe IDs would make this more scalable
			var userTriedListRef = dataRef.child("recipeData/user/" + this.recipe.user + "/" + this.recipe.key + "/" + "recipesTriedList");
			var categoryUserTriedListRef = dataRef.child("recipeData/user/" + this.recipe.user + "/" + this.recipe.key + "/" + "recipesTriedList");
			var recipeUsersTriedRef = dataRef.child("recipeData").orderByChild("name").equalTo(username).ref.child("usersTriedList");

			// userTriedListRef.push(this.recipe.name, function(err) {
			// 	if(err) {
			// 		console.log("Error: " + err);
			// 	}
			// }).then(function(result) {
			// 	recipeUsersTriedRef.push(username, function(err) {
			// 	if(err) {
			// 		console.log("Error: " + err);
			// 	}
			// 	})
			// });


		};
	</script>
</recipe>