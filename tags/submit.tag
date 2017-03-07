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
		//var recipeDataRef = dataRef.child("recipeData");

		this.submitInfo = function(event) {
			var recipeName = document.getElementById("recipeName").value;
			var user = document.getElementById("author").value;
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
			};

			// push info
			recipeDetailRef = dataRef.child("recipeDetailData");
			recipeDetailRef.push(recipeData, function(err) {
				console.log("Error: " + err);
			}).then(function(result) {
				console.log("successfully pushed recipe detail data");
				console.log(result);
				var recipeBasicData = {
					"name":recipeName,
					"imageLink":imageLink,
					"key":result.key,
				}
				recipeBasicRef = dataRef.child("recipeBasicData");
				recipeBasicRef.push(recipeBasicData, function(err) {
					console.log("Error: " + err);
				}).then(function(result) {
					console.log("successfully pushed recipe basic data");
					// push info to user data
					userRecipeRef = dataRef.child("userData/" + user + "/recipes");
					userRecipeRef.push(recipeBasicData, function(err) {
						console.log("Error: " + err);
					}).then(function(result) {
						console.log("successfully pushed recipe basic data to user");
					});

				});
			});

		}





		this.uploadFile = function(event) {
			var file = event.srcElement.files[0];
			// Create a child reference
			var imagesRef = storageRef.child('images');
			var filename = file.name;
			var title = document.getElementById("title").value;
			var desc = document.getElementById("desc").value;
			console.log(filename);
			console.log(title);
			console.log(desc);
			var newLocationRef = imagesRef.child(filename);
			console.log(imagesRef);

			var metadata = {
				customMetadata: {
					'title':title,
					'desc':desc,
				},
				contentType: 'image/jpeg',
			};

			var uploadTask = newLocationRef.put(file);

			// Register three observers:
			// 1. 'state_changed' observer, called any time the state changes
			// 2. Error observer, called on failure
			// 3. Completion observer, called on successful completion
			uploadTask.on('state_changed', function(snapshot){
			  // Observe state change events such as progress, pause, and resume
			  // Get task progress, including the number of bytes uploaded and the total number of bytes to be uploaded
			  var progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
			  console.log('Upload is ' + progress + '% done');
			  switch (snapshot.state) {
			    case firebase.storage.TaskState.PAUSED: // or 'paused'
			      console.log('Upload is paused');
			      break;
			    case firebase.storage.TaskState.RUNNING: // or 'running'
			      console.log('Upload is running');
			      break;
			  }
			}, function(error) {
			  // Handle unsuccessful uploads
			  console.log(error);
			}, function() {
			  // Handle successful uploads on complete
			  // For instance, get the download URL: https://firebasestorage.googleapis.com/...
			  var downloadURL = uploadTask.snapshot.downloadURL;
			  console.log(downloadURL);
			  var locRef = imgDataRef.child(title);
			  locRef.push(downloadURL).then(function() {
			   		console.log("Push succeeded.");
			  })
			  .catch(function(error) {
			  		console.log("Push failed: " + error.message);
			  });
			});

		}
	</script>
</submit>