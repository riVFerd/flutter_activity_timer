Project Structure:

1. Database
   - Activity Table: Stores information about user-defined activities and time tracking data.
     - activityId (Primary Key): Unique identifier for the activity.
     - activityName: Name of the activity (e.g., "Coding").
     - goalTime: Goal time for the activity in seconds (e.g., 18000 seconds for 5 hours).
     - timeSpent: Total time spent on the activity (in seconds).
     - lastTrackedDate: Date when the activity was last interacted with (useful for daily reset and insights).

2. Model
   - ActivityModel: Represents an activity with activityId, activityName, goalTime, timeSpent, and lastTrackedDate.

3. Screens
   - HomeScreen: Displays a list of user-defined activities.
   - ActivityDetailScreen: Allows the user to interact with a specific activity, start/pause/resume timers, and see time tracking details.

4. Controller/Provider
   - ActivityController/Provider: Manages user-defined activities and provides CRUD operations.

5. Database Helper
   - DatabaseHelper: Manages interactions with the SQLite database, including CRUD operations for activities.

6. Utility
   - DateUtils: Provides utility functions for handling dates and time (e.g., comparing dates for daily reset).
