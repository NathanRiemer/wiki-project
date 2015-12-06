require_relative "config"
require_relative "migrations/create_schema"
require_relative "migrations/add_image_to_revisions"

AddImageToRevisions.migrate(:down)
CreateSchema.migrate(:down)