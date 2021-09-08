# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#following?(user) returns true when following the user' do
    alice = create(:user)
    bob   = create(:user)

    create(:relationship, following: bob, follower: alice)

    assert alice.following?(bob)
  end

  test '#following?(user) returns false when not following the user' do
    alice = create(:user)
    bob   = create(:user)

    assert_not alice.following?(bob)
  end

  test '#followed_by?(user) returns true when followed by the user' do
    alice = create(:user)
    bob   = create(:user)

    create(:relationship, following: alice, follower: bob)

    assert alice.followed_by?(bob)
  end

  test '#followed_by?(user) returns false when not followed by the user' do
    alice = create(:user)
    bob   = create(:user)

    assert_not alice.followed_by?(bob)
  end

  test '#follow(user) should follow the user' do
    alice = create(:user)
    bob   = create(:user)

    assert_not alice.active_relationships.where(following: bob).exists?

    alice.follow(bob)

    assert alice.active_relationships.where(following: bob).exists?
  end

  test '#unfollow(user) should unfollow the user' do
    alice = create(:user)
    bob   = create(:user)
    create(:relationship, following: bob, follower: alice)

    assert alice.active_relationships.where(following: bob).exists?

    alice.unfollow(bob)

    assert_not alice.active_relationships.where(following: bob).exists?
  end

  test '#name_or_email returns a name when a name is present' do
    user = build(:user, name: 'Foo Bar')

    assert_equal 'Foo Bar', user.name_or_email
  end

  test '#name_or_email returns an email when a name is not present' do
    user = build(:user, email: 'foo@example.com', name: '')

    assert_equal 'foo@example.com', user.name_or_email
  end
end
