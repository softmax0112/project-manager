# README

Base Entities:
● User
● Client
● Project
● Time Logs
● Payment
● Comment
● Attachments

-Admin can enable and disable a user.
-Admin can give manager rights to a user.
-Manager is able to create/edit/update Client, Project and Payment.
-Users can perform Create/READ/Update/Delete on time logs and comments.
-User can view Clients, Projects and Time logs.
-Attachments can be uploaded as part of a project(multiple) and also a user’s profile picture.
-Comments can only be made against a project.
-User is only able to edit his/her profile.

On home page, there will be top 5 projects listed based on earnings (details on that table would
be project/hours clocked/earning) and similarly a table for bottom 5 projects alongside this it will
also have a chart for earnings and time logged per month.

Following are the show pages
-User show page is basically the profile of the user.
-Client show page would list the client details along with his projects.
-Project show page would list the project details, hours spent, comments and total payments
made on that project.

Following are the index pages
-User Index
-Client Index
-Project index

Each page would have basic search functionalities in them on relevant fields.

On project index page there will be options to log hours against a project(we are linked to), add
comments on a project and also to add payment against a project(only for managers). This
would be an ajax based call.

Comments modal box would have the latest 5 comments and a form below to add a new
comment.

API system which other websites can use to access our website database
and we can return details for any project they search for. They can send multiple parameters for
the search.

Milestone #1
1) User creation
-> Sign up
-> Login
-> Edit profile
2) Bootstrap
3) Admin
-> Enable / disable a user
-> Give managerial rights to existing users
4) Manager
-> CRUD to manage clients

Milestone #2
1) Manager
-> CRUD to manage projects, payments
2) User
-> CRUD for time logs and comments
-> Can view clients, projects, and time logs
-> Attachments / profile picture

Milestone #3
1) Project
-> Top / bottom 5 projects listed on the homepage
-> Show top 5 comments for a specific project.
2) Writing API
