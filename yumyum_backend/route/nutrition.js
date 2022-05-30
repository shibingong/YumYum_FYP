const express = require("express");
const router = express.Router();

const nutritionController = require("../controller/nutritionController");

router.get("/", nutritionController.getAllNutrition);

module.exports = router;