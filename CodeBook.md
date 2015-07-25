DATA DICTIONARY
===============

  * activity 1
      type of human activity
      * LAYING
      * SITTING
      * STANDING
      * WALKING
      * WALKING_DOWNSTAIRS
      * WALKING_UPSTAIRS
  * subject
      measurement subject

Other fieds structures as followes:

  Space.Name.type[Dimention]

  where

    Space - stands for space:

      Time - time space;
      Freq - frequency space.

    Name - stands for measurement name
      BodyAcc - body acceleration
      GravityAcc - gravity acceleration
      for others see data/Dataset/features_info.txt after running a script

    type - type of measurement:
      std - standard deviation;
      mean - mean of the value.

    dimention - XYZ stands for dimention.
