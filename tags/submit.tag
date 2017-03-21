<submit>
	<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4" id="submit">
		<!-- <form action={ uploadFile } enctype="multipart/form-data">
			<input type="text" name="filename"> -->
			<input type="text" name="recipeName" id="recipeName" placeholder="Recipe Name"><br />
			<input type="text" name="category" id="category" placeholder="Category"><br />
			<input type="text" name="author" id="author" placeholder="Author"><br />
			<input type="text" name="imageLink" id="imageLink" placeholder="Image Link"><br />
			<input type="text" name="ingredients" id="ingredients" placeholder="Ingredients"><br />
			<input type="text" name="directions" id="directions" placeholder="Directions"><br />
			<button role="button" type="button" onclick={ submitInfo }>Submit</button><br />
			<!-- <button type="submit">Upload File</button>
		</form> -->
	</div>
	<script>
		// Create a storage reference from our storage service
		var storageRef = storage.ref();
		var dataRef = firebase.database().ref();
		var that = this;
		//var recipeDataRef = dataRef.child("recipeData");

		this.submitInfo = function(event) {
			var recipeName = document.getElementById("recipeName").value;
			var user = document.getElementById("author").value;
			if(!user) {
				user = firebase.auth().currentUser.displayName;
			}
			var category = document.getElementById("category").value;
			var imageLink = document.getElementById("imageLink").value;
			//var ingredients = document.getElementById("ingredients").value.split(",");
			var ingredients = document.getElementById("ingredients").value; // store as comma-separated string
			var directions = document.getElementById("directions").value;
			var recipeData = {
				"name":recipeName,
				"user":user,
				"category":category,
				"imageLink":imageLink,
				"ingredients":ingredients,
				"directions":directions,
				"triedBy":"",
			};

			// push info
			recipeDetailRef = dataRef.child("recipeDetailData");
			recipeDetailRef.push(recipeData).then(function(result) {
				console.log("successfully pushed recipe detail data");
				var recipeBasicData = {
					"name":recipeName,
					"imageLink":imageLink,
					"key":result.key,
				}
				recipeBasicRef = dataRef.child("recipeBasicData");
				recipeBasicRef.push(recipeBasicData).then(function(result) {
					console.log("successfully pushed recipe basic data");
					// push info to user data
					userRecipeRef = dataRef.child("userData/" + user + "/recipes");
					userRecipeRef.push(recipeBasicData).then(function(result) {
						console.log("successfully pushed recipe basic data to user");
					});

				});
				categoryRef = dataRef.child("category/" + category);
				categoryRef.push(recipeBasicData).then(function(result) {
					console.log("successfully pushed category data");
				});
			});

		}
	</script>
</submit>