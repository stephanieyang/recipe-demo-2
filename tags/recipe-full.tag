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
				<li each={ username in recipe.triedByList }>{ username }</li>
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
			if(this.opts && this.opts.recipe) {
				this.recipe = this.opts.recipe;
				this.recipe.ingredientList = this.recipe.ingredients.split(",");
				this.recipe.triedByList = this.recipe.triedBy.split(",");
			}
		});


		this.submitInfo = function(event) {
			var user = document.getElementById("triedUser").value;

			//var userRef = dataRef.child("userData").orderByChild("name").equalTo(username);
			// this only works so long as all recipes by an author have unique names; adding recipe IDs would make this more scalable
			userTriedRef = dataRef.child("userData/" + user + "/tried");
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

			recipeUsersTriedRef = dataRef.child("recipeDetailData/" + this.recipe.key + "/triedBy");
			recipeUsersTriedRef.once('value', function(snap) {
				console.log(snap.val());
				var usersList = snap.val() ? snap.val().split(",") : [];
				console.log(usersList);
				// if 
				var userAlreadyInList = !!(_.find(usersList, function(name){ return name == user; })); // boolean witchery
				if(!userAlreadyInList) { // don't add if user is redundant
					if(usersList.length > 0) {
						var newVal = snap.val() + "," + user;
						console.log(newVal);
						recipeUsersTriedRef.set(newVal, function(err) {
							console.log("Error: " + err);
						});
					} else {
						recipeUsersTriedRef.set(user, function(err) {
							console.log("Error: " + err);
						});
					}

				}
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

	</script>
</recipe-full>