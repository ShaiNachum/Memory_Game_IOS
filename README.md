# Memory Game App - IOS
  Welcome to the Memory Game App! This is a fun and engaging game that tests your memory and concentration skills.
  Match pairs of cards and see how quickly you can clear the board.

## This Project Made During "IOS Development" Course.

## Introduction:
  The Memory Game App is designed to be both entertaining and challenging.
  Players can log in, play a memory game, and keep track of their scores and attempts.
  The app stores game records using Firebase, allowing players to see their progress over time.
  
### The Features:
  * Login Screen: Allows players to enter their name and start a new game.
  * Game Screen: Displays a 4x4 grid of cards that players can tap to reveal and match.
  * Timer and Score Tracking: Keeps track of the time, number of attempts, and score for each game.
  * Game Records: Stores game records in Firebase and displays them in a card view list.
  * Persistent Data: Uses Firebase to store and retrieve game data.
 
### Technologies:
  * Swift
  * UIKit
  * Firebase Database

### Components:
  * LoginController: Handles user login and navigation to the game screen or records screen.
  * GameController: Manages the game logic, including the timer, score, and card interactions.
  * GameManager: Contains the core game logic for handling card matches, score calculation, and game state.
  * DataManager: Manages the data for the cards, including shuffling and distributing the cards for the game.
  * Card: Represents a single card in the game with its name, ID, and flipped state.
  * Game: Model class representing a single game with player name, attempts, time, and score.
  * RecordsController: Displays the list of game records stored in Firebase.
  * RecordsManager: Handles interactions with Firebase, including adding and fetching game records.

### Libraries Used:
  * Firebase Database: For storing and retrieving game records.

### Video Example:


### License:
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

