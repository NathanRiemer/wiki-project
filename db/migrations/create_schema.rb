require_relative "../config"

class CreateSchema < ActiveRecord::Migration

  def up
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :avatar_image_url
      t.string :city
      t.string :state
      t.string :country
      t.boolean :is_admin
    end # :users

    create_table :articles do |t|
      t.string :title
    end # :articles

    create_table :revisions do |t|
      t.text :content
      t.datetime :created_at
      t.integer :user_id
      t.integer :article_id
    end # :revisions

    create_table :comments do |t|
      t.text :content
      t.datetime :created_at
      t.integer :user_id
      t.integer :revision_id
    end # :comments

    create_table :categories do |t|
      t.string :title
    end # :categories

    create_table :articles_categories, id: false do |t|
      t.integer :article_id
      t.integer :category_id
    end # :articles_categories

  end # up

  def down
    drop_table :users
    drop_table :articles
    drop_table :revisions
    drop_table :comments
    drop_table :categories
    drop_table :articles_categories
  end # down

end # CreateSchema

CreateSchema.migrate(ARGV[0])