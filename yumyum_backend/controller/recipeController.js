const Recipe = require("../model/recipe");
var fs = require('fs');

module.exports.getAllRecipe = async (req, res) => {
    const host = req.headers.host;
    const recipeName = req.query.recipeName;
    const types = req.query.types;

    let filterQuery = {};
    recipeName &&
        (filterQuery.recipeName = { $regex: recipeName, $options: "i" });
    types &&
        (filterQuery.types = { $regex: types, $options: "i" });


    let recipes = await Recipe.find(filterQuery)
        .populate("userID")
        .populate("nutrition");

    recipes.forEach(element => {
        // element.userID.profileImage = `http://${host}/images/${element.userID.profileImage}`
        let testProfileImage = element.userID.profileImage;
        if ((!testProfileImage.includes('http')) && (testProfileImage !== '')) {
            element.userID.profileImage = `https://${host}/images/${element.userID.profileImage}`
            console.log("profile image ->", element.userID.profileImage)
        }
        if (element.recipeImage !== "")
            element.recipeImage = `https://${host}/images/${element.recipeImage}`;
    });

    res.json(recipes);
};

module.exports.getUserRecipe = async (req, res) => {
    const host = req.headers.host;
    const userid = req.id;
    let filterQuery = {};
    filterQuery.userID = userid;
    let recipes = await Recipe.find(filterQuery)
        .populate("userID")
        .populate("nutrition");

    recipes.forEach(element => {
        // element.userID.profileImage = `http://${host}/images/${element.userID.profileImage}`
        let testProfileImage = element.userID.profileImage;
        if ((!testProfileImage.includes('http')) && (testProfileImage !== '')) {
            element.userID.profileImage = `https://${host}/images/${element.userID.profileImage}`
        }
        if (element.recipeImage !== "")
            element.recipeImage = `https://${host}/images/${element.recipeImage}`;
    });

    res.json(recipes);
};

module.exports.getRecipeByUserId = async (req, res) => {
    const host = req.headers.host;
    const userid = req.params["id"];
    let filterQuery = {};
    filterQuery.userID = userid;
    let recipes = await Recipe.find(filterQuery)
        .populate("userID")
        .populate("nutrition");

    recipes.forEach(element => {
        // element.userID.profileImage = `http://${host}/images/${element.userID.profileImage}`
        let testProfileImage = element.userID.profileImage;
        if ((!testProfileImage.includes('http')) && (testProfileImage !== '')) {
            element.userID.profileImage = `https://${host}/images/${element.userID.profileImage}`
        }
        if (element.recipeImage !== "")
            element.recipeImage = `https://${host}/images/${element.recipeImage}`;
    });

    res.json(recipes);
};

module.exports.getRecipeByID = async (req, res) => {
    const host = req.headers.host;
    const recipeId = req.params["recipeId"];
    let recipe = await Recipe.findById(recipeId)
        .populate("userID")
        .populate("nutrition");
    res.json(recipe);
};

module.exports.newRecipe = async (req, res) => {
    const host = req.headers.host;
    const userid = req.id;
    const { recipeName, recipeDescription, steps, ingredients, types, videoUrl, calories, sugar, fiber, sodium, fat, cholesterol, protein, carbohydrates, image, imgName } = req.body;

    var realFile = Buffer.from(image, "base64");
    console.log("new recipe image testing");
    fs.writeFile("public/images/" + imgName, realFile, function (err) {
        if (err) console.log(err);
    });

    let recipe = new Recipe();
    recipe.recipeName = recipeName;
    recipe.recipeDescription = recipeDescription;
    recipe.steps = steps;
    recipe.ingredients = ingredients;
    recipe.types = types;
    recipe.videoUrl = videoUrl;
    recipe.userID = userid;
    recipe.nutrition.calories = calories;
    recipe.nutrition.sugar = sugar;
    recipe.nutrition.fiber = fiber;
    recipe.nutrition.sodium = sodium;
    recipe.nutrition.fat = fat;
    recipe.nutrition.cholesterol = cholesterol;
    recipe.nutrition.protein = protein;
    recipe.nutrition.carbohydrates = carbohydrates;
    recipe.recipeImage = imgName;

    const { _id } = await recipe.save();
    let newRecipe = await Recipe.findById(_id)
        .populate("userID");

    let testProfileImage = newRecipe.userID.profileImage;
    if (!testProfileImage.includes('http')) {
        newRecipe.userID.profileImage = `https://${host}/images/${newRecipe.userID.profileImage}`
    }
    if (newRecipe.recipeImage !== "")
        newRecipe.recipeImage = `https://${host}/images/${newRecipe.recipeImage}`;

    res.json(newRecipe);
};

module.exports.updateRecipe = async (req, res) => {
    const userid = req.id;
    const recipeId = req.params["recipeId"];
    const newRecipeData = req.body;

    if (newRecipeData.imgName !== '') {
        var realFile = Buffer.from(newRecipeData.image, "base64");
        fs.writeFile("public/images/" + newRecipeData.imgName, realFile, function (err) {
            if (err) console.log(err);
        });
    }
    console.log(newRecipeData);

    let recipe;
    let updatedRecipe;
    if (newRecipeData.imgName !== '') {
        updatedRecipe = await Recipe.findByIdAndUpdate(recipeId, newRecipeData, {
            new: true,
            useFindAndModify: false,
        });

        recipe = await Recipe.findByIdAndUpdate(recipeId, { recipeImage: newRecipeData.imgName }, {
            new: true,
            useFindAndModify: false,
        });
    }
    else {
        recipe = await Recipe.findByIdAndUpdate(recipeId, newRecipeData, {
            new: true,
            useFindAndModify: false,
        });
    }

    res.json(recipe);
};

module.exports.deleteRecipe = async (req, res) => {
    const userid = req.id;
    const recipeId = req.params["recipeId"];

    const recipe = await Recipe.findByIdAndDelete(recipeId);
    res.send("deleted");
};