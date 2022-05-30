import 'package:flutter/material.dart';
import 'package:yumyumfyp/widgets/custom_text_field.dart';

class StepsForm extends StatelessWidget {
  final int stepsNum;
  final List<TextEditingController> stepController;
  final Function addStepsButtonOnPressed;
  final Function removeStepsButtonOnPressed;
  const StepsForm(
      {Key key,
      this.stepsNum,
      this.stepController,
      this.addStepsButtonOnPressed,
      this.removeStepsButtonOnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: stepsNum,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 29, right: 29, bottom: 5),
        child: Container(
          height: 60,
          child: Row(children: [
            Expanded(
              flex: 6,
              child: CustomTextField(
                hintText: 'Step ' + (index + 1).toString(),
                controller: stepController[index],
              ),
            ),
            Visibility(
              visible: index == stepsNum - 1,
              child: Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: IconButton(
                    onPressed: () {
                      addStepsButtonOnPressed(index);
                    },
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: index > 0,
              child: Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: IconButton(
                    onPressed: () {
                      removeStepsButtonOnPressed(index);
                    },
                    icon: Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
