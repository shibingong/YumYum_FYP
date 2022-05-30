const Nutrition = require("../model/nutrition");

module.exports.getAllNutrition = async (req, res) => {
    let nutritions = await Nutrition.find();
    res.json(nutritions);
};
