require './test/test_helper'
require './lib/ideabox/idea'
require './lib/ideabox/idea_store'

class IdeaStoreTest < Minitest::Test
   def teardown
    IdeaStore.delete_all
   end


   def test_save_and_retrieve_ideas
    idea = Idea.new("celebrate", "with champagne")
    id1 = IdeaStore.save(idea)

    assert_equal 1, IdeaStore.count

    idea = Idea.new("dream", "of unicorns and rainbows")
    id2 = IdeaStore.save(idea)

    assert_equal 2, IdeaStore.count

    idea = IdeaStore.find(id1)
    assert_equal "celebrate", idea.title
    assert_equal "with champagne", idea.description

    idea = IdeaStore.find(id2)
    assert_equal "dream", idea.title
    assert_equal "of unicorns and rainbows", idea.description
  end

  def test_update_idea
      idea = Idea.new("drink", "tomato juice")
      id = IdeaStore.save(idea)

      idea = IdeaStore.find(id)
      idea.title = "cocktails"
      idea.description = "spicy tomato juice with vodka"

      IdeaStore.save(idea)

      assert_equal 1, IdeaStore.count

      idea = IdeaStore.find(id)
      assert_equal "cocktails", idea.title
      assert_equal "spicy tomato juice with vodka", idea.description
    end

    def test_delete_an_idea
      id1 = IdeaStore.save Idea.new("song", "99 bottles of beer")
      id2 = IdeaStore.save Idea.new("gift", "micky mouse belt")
      id3 = IdeaStore.save Idea.new("dinner", "cheeseburger with bacon and avocado")

      assert_equal ["dinner", "gift", "song"], IdeaStore.all.map(&:title).sort
      IdeaStore.delete(id2)
      assert_equal ["dinner", "song"], IdeaStore.all.map(&:title).sort
    end


end
