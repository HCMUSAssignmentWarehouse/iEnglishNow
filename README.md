# Final Project - *English Now*


[![Codacy Badge](https://api.codacy.com/project/badge/Grade/f73a48f33e314c88abef8b7a4dae85df)](https://www.codacy.com/app/nhoxbypass/EnglishNow?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=HCMUS-AssignmentWarehouse/EnglishNow&amp;utm_campaign=Badge_Grade)

**English Now** is an awesome iOS app create from Swift 3.0, OpenTok client sdk and NodeJS server, it allows a users to practice speaking, writing, chatting in English. By the time using this app, English level of users will be improved.

Time spent: **90** hours spent in total

## User Stories

The basic **required** functionality:

* [x] Find a friend to practice speaking English throught video call
* [x] Chatting with other friends in English
* [x] Writing/updating personal statuses, posts in English


The **extended** features are implemented:

* [ ] User can connect and share post/status with other social network.

The **advance** features are implemented:

* [ ] Improve UI/UX


## Install libraries with Podfile

Launch terminal, cd to the project's folder and type ``pod install`` to install needed libraries for this app.
Then close XCode and open EnglishNow.xcodeworkspace to open it.

## Quick deploy to Heroku

Heroku is a PaaS (Platform as a Service) that can be used to deploy simple and small applications for free. To easily deploy **EnglishNow NodeJS server** repository to Heroku, sign up for a Heroku account and click this button:

<a href="https://heroku.com/deploy?template=https://github.com/opentok/learning-opentok-node/" target="_blank">
<img src="https://www.herokucdn.com/deploy/button.png" alt="Deploy">
</a>

Heroku will prompt you to add your OpenTok API key and OpenTok API secret, which you can
obtain at the [TokBox Dashboard](https://dashboard.tokbox.com/keys).

## Video Walkthrough

Here's a walkthrough of implemented user stories:

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/a39a45a7f459486ba164a986b9163809)](https://www.codacy.com/app/nhoxbypass/EnglishNow?utm_source=github.com&utm_medium=referral&utm_content=HCMUS-AssignmentWarehouse/EnglishNow&utm_campaign=badger)
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/Sw4Gj1eF8is/0.jpg)](https://www.youtube.com/watch?v=Sw4Gj1eF8is)

## Notes

This project use localdb combine with Firebase and NodeJS server, so it cannot provide any method to import data by Firebase JSON files. 
Tester **MUST** sign up and sign in in-app.

## Open-source libraries used

- [OpenTok](https://tokbox.com/) - Everything you need to build WebRTC
- [MBProgressHUD](https://github.com/jdg/MBProgressHUD) - iOS drop-in class that displays a translucent HUD with an indicator and/or labels while work is being done in a background thread.
- [SwiftMessages](https://github.com/SwiftKickMobile/SwiftMessages) - A very flexible message bar for iOS written in Swift.
- [Cosmos](https://github.com/evgenyneu/Cosmos) - A star rating control for iOS/tvOS written in Swift
- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - A delightful networking framework for iOS, OS X, watchOS, and tvOS


## License

    Copyright 2017 IceTeaViet

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
