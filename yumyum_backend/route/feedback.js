const express = require("express");
const router = express.Router();

const feedbackController = require("../controller/feedbackController");

router.get("/", feedbackController.getAllFeedback);
router.get("/:recipeId", feedbackController.getFeedbackByRecipeID);
router.post("/", feedbackController.addFeedback);

module.exports = router;