@works
Feature: Import Works
  In order to have an archive full of works
  As an author
  I want to create new works by importing them
  
  Scenario: You can't create a work unless you're logged in
  When I go to the import page
  Then I should see "Please log in"

  Scenario: Creating a new minimally valid work
    Given basic tags
      And I am logged in as a random user
    When I go to the import page
    Then I should see "Import New Work"
      And I fill in "urls" with "http://cesy.dreamwidth.org"
    When I press "Import"
    Then I should see "Preview Work"
      And I should see "Welcome"
      And I should not see "A work has already been imported from http://cesy.dreamwidth.org"
      And I should see "No Fandom"
      And I should see "Chose Not To"
      And I should see "Not Rated"
    When I press "Post"
    Then I should see "Work was successfully posted."
    When I go to the works page
    Then I should see "Recent Entries"

  Scenario: Creating a new work with tags
    Given basic tags
      And a category exists with name: "M/M", canonical: true
      And I am logged in as a random user
    When I go to the import page
    Then I should see "Import New Work"
      And I fill in "urls" with "http://astolat.dreamwidth.org/220479.html"
      And I select "Explicit" from "Rating"
      And I check "No Archive Warnings Apply"
      And I fill in "Fandoms" with "Idol RPF"
      And I check "M/M"
      And I fill in "Relationships" with "Adam/Kris"
      And I fill in "Characters" with "Adam, Kris"
      And I fill in "Additional Tags" with "kinkmeme"
    When I press "Import"
    Then I should see "Preview Work"
      And I should see "Extra Credit"
      And I should see "Explicit"
      And I should see "No Archive Warnings Apply"
      And I should see "Idol RPF"
      And I should see "M/M"
      And I should see "Adam/Kris"
      And I should see "Adam, Kris"
      And I should see "kinkmeme"
    When I press "Post"
    Then I should see "Work was successfully posted."

  Scenario: Importing multiple works with tags and backdating
    Given basic tags
      And I am logged in as a random user
    When I go to the import page
    Then I should see "Import New Work"
      And I fill in "urls" with 
        """
        http://www.intimations.org/fanfic/idol/Huddling.html
        http://www.intimations.org/fanfic/idol/Stardust.html
        """
      And I select "Explicit" from "Rating"
      And I check "No Archive Warnings Apply"
      And I fill in "Fandoms" with "Idol RPF"
      And I fill in "Relationships" with "Adam/Kris"
      And I fill in "Characters" with "Adam, Kris"
    When I press "Import"
      And I should see "Imported Works"
      And I should see "We were able to successfully upload"
      And I should see "Huddling"
      And I should see "Stardust"
    When I follow "Huddling"
    Then I should see "Preview Work"
      And I should see "Explicit"
      And I should see "No Archive Warnings Apply"
      And I should see "Idol RPF"
      And I should see "Adam/Kris"
      And I should see "Adam, Kris"
      And I should see "2010-01-11"
  Scenario: Creating a new work from an LJ story
    Given basic tags
      And a category exists with name: "Gen", canonical: true
      And a category exists with name: "F/M", canonical: true
      And the following activated user exists
        | login          | password    |
        | cosomeone      | something   |
      And I am logged in as "cosomeone" with password "something"
    When I go to the import page
      And I fill in "urls" with "http://cesy.dreamwidth.org/394320.html"
    When I press "Import"
    Then I should see "Preview Work"
      And I should see "OTW Meetup"
    When I press "Post"
    Then I should see "Work was successfully posted."
    When I am on cosomeone's user page
    Then I should see "OTW Meetup"
      And I should not see "Rambling musings"
      And I should not see "Search" within "#main"

  Scenario: Creating a new work from an LJ story without backdating it
    Given basic tags
      And a category exists with name: "Gen", canonical: true
      And a category exists with name: "F/M", canonical: true
      And the following activated user exists
        | login          | password    |
        | cosomeone      | something   |
      And I am logged in as a random user
    When I go to the import page
      And I fill in "urls" with "http://cesy.dreamwidth.org/394320.html"
    When I press "Import"
    Then I should see "Preview Work"
      And I should see "OTW Meetup"
    When I press "Edit"
    Then I should see "* Required information"
      And I should see "OTW Meetup"
    When I set the publication date to today
      And I check "No Archive Warnings Apply"
    When I press "Preview"
    Then I should see "OTW Meetup"
    When I press "Post"
    Then I should see "Work was successfully posted."
      And I should see "OTW Meetup"
      And I should not see "Rambling musings"
      And I should not see "Profile" within "#main"

  Scenario: Creating a new work from a Yuletide story
    Given basic tags
      And the following activated user exists
        | login          | password    |
        | cosomeone      | something   |
      And I am logged in as a random user
    When I go to the import page
      And I fill in "urls" with "http://yuletidetreasure.org/archive/79/littlemiss.html"
    When I press "Import"
    Then I should see "Preview Work"
      And I should see "Little Miss Curious"
    When I press "Post"
    Then I should see "Work was successfully posted."
      And I should see "Little Miss Sunshine" within "dd"
      And I should see "Yule Madness Treat, unbetaed." within "div"
      And I should not see "Search Engine"
      

#  Scenario: Getting tags out of a story with tags in the text in the format category: tag (eg, Fandom: Supernatural)
  
#  Scenario: Import a multi-chapter work from fanfiction.net
  
#  Scenario: Import works for others and have them automatically notified
      
