const express = require("express");
const router = express.Router();

const recipeController = require("../controller/recipeController");

router.get("/", recipeController.getAllRecipe);
router.get("/user", recipeController.getUserRecipe);
router.get("/user/:id", recipeController.getRecipeByUserId);
router.get("/:recipeId", recipeController.getRecipeByID);
router.post("/", recipeController.newRecipe);
router.put("/:recipeId", recipeController.updateRecipe);
router.delete("/:recipeId", recipeController.deleteRecipe);

module.exports = router;