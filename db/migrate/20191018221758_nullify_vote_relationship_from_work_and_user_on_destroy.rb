class NullifyVoteRelationshipFromWorkAndUserOnDestroy < ActiveRecord::Migration[5.2]
  def change
    remove_reference :votes, :work
    add_reference :votes, :work, on_delete: :nullify

    remove_reference :votes, :user
    add_reference :votes, :user, on_delete: :nullify
  end
end
