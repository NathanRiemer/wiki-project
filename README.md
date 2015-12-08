# wiki-project
Project Two

## Documentation

### App Description:

A wiki application. Users can create and view articles. Prior revisions of articles are maintained, and may be viewed and compared. The current theme of the application is *Star Wars*, however the application could be repurposed to any subject.

### Working Application link:

https://murmuring-inlet-6388.herokuapp.com/

### Technologies Used:

-  HTML
-  CSS
-  Javascript
-  jQuery
-  Ruby
-  Ruby gems:
  -  Sinatra
  -  ActiveRecord
  -  Bcrypt
  -  pry
  -  RedCarpet
  -  FFaker
  -  Diffy
  -  Sqlite3
  -  pg (Postgres)

## Planning

### User Stories

MVP features:

1.  A user can create a user account.
2.  A user can log in to their account with the correct password.
3.  A user can log out.
4.  A user can create an article.
5.  A user can edit an article.
6.  A user can see a list of all articles.
7.  An article displays the user that created it.
8.  An article displays the user that edited it last, and when.
9.  Articles render using markdown.
10.  Users can add categories to articles.
11.  Users can see all the articles in a given category.

Secondary features:
1.  A user can search by article title, article content, or category title.
2.  A user can view a printable version of an article.
3.  A user can view previous revisions of articles.
4.  A user can comment on revisions.
5.  A user can view a diff between a revision and the previous revision.
6.  A user can view a diff bewtween a revision and the current revision.
7.  An admin user can edit the name of an article.
8.  An admin user can grant admin status to other users.
9.  A user can edit their own profile information.
10.  A user can view other users' profiles. Admin users can see more profile information.
11.  A user can see the number of articles a user has created and contributed to, and the number of comments. 
12.  A user can see a list of the articles a user has contributed to.
13.  A user can add multiple categories at once to an article.
14.  A user can remove categories from an article.
15.  An admin user can edit the title of a category.


User
----
-username
-password
-email

Article
-------
-title

Revision
---------
-content
-datetime_created
-article_id
-user_id

Category
--------
-title

Article Category
----------------
-category_id
-article_id

Comment
-------
-content
-user_id
-revision_id