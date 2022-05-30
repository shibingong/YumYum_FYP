const Feedback = require("../model/feedback");

module.exports.getAllFeedback = async (req, res) => {
  const host = req.headers.host;
  let feedbacks = await Feedback.find()
    .populate("userID");
    // .populate("recipeID");

  feedbacks.forEach(element => {
    // element.userID.profileImage = `http://${host}/images/${element.userID.profileImage}`
    let testProfileImage = element.userID.profileImage;
    if (!testProfileImage.includes('http')) {
      element.userID.profileImage = `http://${host}/images/${element.userID.profileImage}`
    }
  });

  res.json(feedbacks);
};

module.exports.getFeedbackByRecipeID = async (req, res) => {
  const host = req.headers.host;
  const recipeId = req.params["recipeId"];
  let feedbacks = await Feedback.find({ 'recipeID': recipeId })
    .populate("userID");
    // .populate("recipeID");

  feedbacks.forEach(element => {
    // element.userID.profileImage = `http://${host}/images/${element.userID.profileImage}`
    let testProfileImage = element.userID.profileImage;
    if (!testProfileImage.includes('http')) {
      element.userID.profileImage = `http://${host}/images/${element.userID.profileImage}`
    }
  });

  res.json(feedbacks);
};

module.exports.addFeedback = async (req, res) => {
  const host = req.headers.host;
  const { comment, rating, recipeid } = req.body;
  const userid = req.id;

  let feedback = new Feedback();
  feedback.comment = comment;
  feedback.rating = rating;
  feedback.recipeID = recipeid;
  feedback.userID = userid;

  const { _id } = await feedback.save();
  let newFeedback = await Feedback.findById(_id)
    .populate("userID");
    // .populate("recipeID");

  let testProfileImage = newFeedback.userID.profileImage;
  if (!testProfileImage.includes('http')) {
    newFeedback.userID.profileImage = `http://${host}/images/${newFeedback.userID.profileImage}`
  }

  res.json(newFeedback);
};
