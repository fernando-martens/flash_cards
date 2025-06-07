#### Interface

* Create screen to review deck
* Show front of the card
* “Show answer” button
* Record the rating (e.g., easy, medium, hard)

| Column    | Type   | What it means                                        |
| --------- | ------ | ---------------------------------------------------- |
| `id`      | uuid   | Timestamp in milliseconds (when the review happened) |
| `card_id` | uuid   | Card ID — links to the `cards` table                 |
| `ease`    | number | Button you pressed: 1=Again, 2=Hard, 3=Good, 4=Easy  |
| `ivl`     | number | Interval **after** the review, in **days**           |
| `lastIvl` | number | Interval **before** the review, in **days**          |
| `time`    | number | Time you took to answer, in **milliseconds**         |

#### Future features

* Auth

#### Improvements

* Implement spaced repetition system (SRS)

| Column   | Type    | What it means                                               |
| -------- | ------- | ----------------------------------------------------------- |
| `factor` | Integer | Ease factor × 10 (e.g., 2500 = 2.5)                         |
| `type`   | Integer | Type of review:<br>0=Learn, 1=Review, 2=Relearn, 3=Filtered |
