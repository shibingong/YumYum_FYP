// user model
const mongoose = require("mongoose");
// const ObjectId = Schema.ObjectId;

const recipeSchema = new mongoose.Schema({
    id: String,
    recipeName: String,
    recipeDescription: String,
    steps: [String],
    ingredients: [String],
    types: [String],
    videoUrl: String,
    userID: { type: mongoose.Schema.Types.ObjectId, ref: "users" },
    nutrition: {
        calories: String,
        sugar: String,
        fiber: String,
        sodium: String,
        fat: String,
        cholesterol: String,
        protein: String,
        carbohydrates: String,
      },
    recipeImage: String,
}, { versionKey: false });

const Recipe = mongoose.model('recipes', recipeSchema);

module.exports = Recipe;