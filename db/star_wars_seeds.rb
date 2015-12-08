require_relative "config"

george = User.create(username: "george_lucas", password: "jarjar", email: "george.lucas@example.com", is_admin: true, city: "Modesto", state: "CA", country: "USA", avatar_image_url: "http://www.chicagonow.com/getting-real/files/2015/05/george-lucas.jpg")

ep1 = Article.create(title: "Episode I: The Phantom Menace")
ep2 = Article.create(title: "Episode II: Attack of the Clones")
ep3 = Article.create(title: "Episode III: Revenge of the Sith")
ep4 = Article.create(title: "Episode IV: A New Hope")
ep5 = Article.create(title: "Episode V: The Empire Strikes Back")
ep6 = Article.create(title: "Episode VI: Return of the Jedi")


