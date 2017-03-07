<recipe-full>
	<div class="recipe" show={recipe.name}>
		<h2>{ recipe.name }</h2>
		<img src='{ recipe.imageLink }' alt='image' />
		<h4>By { recipe.user }</h4>
		<div class="ingredients">
			<h3>Ingredients</h3>
			<ul>
				<li each={ ingredient in recipe.ingredientList }>{ ingredient }</li>
			</ul>
		</div>
		<div class="directions">
			<h3>Directions</h3>
			<p>{ recipe.directions }</p>
		</div>
		<div class="triedBy">
			<h3>Tried By</h3>
			<ul>
				<li each={ username in recipe.triedByUsers }>{ username }</li>
			</ul>
		</div>
		<div>
				<input type="text" name="triedUser" id="triedUser" placeholder="Tried By..."><br />
				<button role="button" type="button" onclick={ submitInfo }>Submit</button><br />
		</div>
	</div>
	<script>

		var dataRef = firebase.database().ref();
		var categoryDataRef = dataRef.child("categoryData");

		this.on('update', function(event) {
			console.log("recipe-full.tag: recipe =");
			console.log(this.opts.recipe);
			console.log(this.recipe);
			if(this.opts && this.opts.recipe) {
				this.recipe = this.opts.recipe;
				this.recipe.ingredientList = this.recipe.ingredients;
			}
			console.log(this.recipe);
			console.log("done in full update");
		});

		this.submitInfo = function(event) {
			var user = document.getElementById("triedUser").value;
			console.log(user);
			console.log(this.recipe.key);

			//var userRef = dataRef.child("userData").orderByChild("name").equalTo(username);
			// this only works so long as all recipes by an author have unique names; adding recipe IDs would make this more scalable
			userTriedRef = dataRef.child("userData/" + user + "/tried");
			console.log("key: " + this.recipe.key);
			var recipeBasicData = {
				"name":this.recipe.name,
				"imageLink":this.recipe.imageLink,
				"key":this.recipe.key,
			}

			userTriedRef.push(recipeBasicData, function(err) {
				console.log("Error: " + err);
			}).then(function(result) {
				console.log("successfully pushed recipe basic data to user tried");
			});

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

		this.on('update', function(event) {
			console.log("recipe update");
			console.log(event);
		});

	</script>
</recipe-full>