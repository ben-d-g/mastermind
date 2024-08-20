# mastermind

Build a [Mastermind](https://www.wikihow.com/Play-Mastermind) game from the command line where you have 12 turns to guess the secret code, starting with you guessing the computer’s random code.

## Game Flow - Vs Computer

- Computer generates code
- Player makes guess
- Computer gives feedback on code
- Player either guesses code or runs out of guesses

## Classes

### Code

Variables:
- code - String of 4 chars from {1,2,3,4,5,6}, generated randomly on initialization

Methods:
- checkGuess(guess) - compares guess to code, returns string of 4 chars from {x, ., ?} indicating result of guess

### Guess

Variables:
- code - String of 4 chars from {1,2,3,4,5,6}, submitted by user
- guess_made - boolean, true if guess has been made, false if not

Methods:
- validate - Validate string
- make_guess
- get_guess

### Game
Variables:
- code - Code object
- guesses - Array of 8 Guess objects

Methods:
- play
