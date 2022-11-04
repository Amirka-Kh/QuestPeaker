# QuestPeak
## Description:
Interactive city-scape quests.
User gets list of quests and bring one of it. Each quest consists of four parts: coordinate of quest, which is hidden from user; verbal description of this coordinate; the task and the answer. User has to guess, which coordinate is meant, and go to it. Once user is close to it (for example, distance is less than 50 meters), he gets task. Answer to this task is somewhere close to point, and it consists of some puzzle. User searches, thinks and writes answer, which is checked.

Stack: Flutter, Dart.

## APK

Download APK [here](https://github.com/Amirka-Kh/QuestPeaker/blob/main/build/app/outputs/apk/release/app-release.apk)

## Screenshots

Custom ico of the app (previous version)
<br/>
<img width="100" alt="imagen" src="/Screenshots/img.png">

You can scroll through and look for an interesting quest. Clicking "learn more" will take you to the details page, which shows a short story about the quest.
We had a plan to make a play button on the details page. This button was supposed to start the quest, however this doesn't seem like a good solution as navigation becomes difficult (it's better to place the button on the quest page). We also had little time, so this mechanism was not implemented.

main page screens
<br/>
<img width="400" alt="imagen" src="/Screenshots/img_1.png">
<img width="400" alt="imagen" src="/Screenshots/img_2.png">

You can mark a quest as a favorite. However, you cannot view the list of favorite quests in the "saved offer" (you can enter the "saved offer" using the top left button on the application bar). This happened due to the fact that the save to favorites logic has changed, and now it is necessary to change the rendering logic of the "saved offer" page (by the way, the logic was not implemented in the previous version, we also did not specify the version of our application when committing).

quest and details page screen
<br/>
<img width="400" alt="imagen" src="/Screenshots/img_3.png">
<img width="400" alt="imagen" src="/Screenshots/img_4.png">
