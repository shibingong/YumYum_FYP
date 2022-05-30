// user model
const mongoose = require("mongoose");
// const ObjectId = Schema.ObjectId;

const nutritionSchema = new mongoose.Schema({
    id: String,
    calories: String,
    sugar: String,
    fiber: String,
    sodium: String,
    fat: String
}, { versionKey: false });

const Nutrition = mongoose.model('nutritions', nutritionSchema);

module.exports = Nutrition;